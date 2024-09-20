# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
#
# Kubernetes PKI certificates renewal playbook
#
# This playbook automates the Kubernetes certificates renewal process, it performs:
#   1. Renew Control Plane certificates.
#   2. Renew Kubelet certificates.
#   3. Print all certificates expiration dates for check.
#
# Check for expiration first e.g. via executing the following on a master node via:
#
#   find /etc/kubernetes/pki /etc/etcd/pki -type f -name "*.crt" -print | sort |
#   egrep -v 'ca\.crt$|\/pki\/expired\/|\/tmp\/|ca-bundle\.' |
#   xargs -L 1 -t  -i bash -c 'openssl x509  -noout -text -in {} | grep After'
#
# or via:
#
#   find /etc/kubernetes -type f -name '*.conf' |
#   grep -v expired |
#   xargs -L 1 -t -i bash -c 'kubectl config view --raw -o jsonpath="{.users[0].user.client-certificate-data}" --kubeconfig={} | base64 -d | openssl x509 -noout -text | grep After'
#
# In case the certificates are close to expiring, this playbook can be used to renew them.

- name: Renew Kubernetes PKI certificates
  hosts: master
  become: true
  serial: 1
  tasks:
    
    # Get Kubernetes version and modify the output from something like "v1.29.3" to "1.29".
    - name: Get the current Kubernetes version
      shell: |
        K8S_VERSION=$(kubectl version --kubeconfig=/etc/kubernetes/admin.conf --short 2>/dev/null | grep 'Server Version:' | awk '{print $3}')
        if [ -z "$K8S_VERSION" ]; then
          K8S_VERSION=$(kubectl version --kubeconfig=/etc/kubernetes/admin.conf 2>/dev/null | grep 'Server Version:' | awk '{print $3}')
        fi
        if [ -z "$K8S_VERSION" ]; then
          echo "ERROR: Unable to get Kubernetes version"
          exit 1
        fi
        echo "$K8S_VERSION" | sed -E 's/^v?([0-9]+\.[0-9]+)\.[0-9]+.*/\1/'
      register: kubernetes_version
    
    - name: Ensure rsync is installed
      package:
        name:
          - rsync
        state: latest

    - name: Backup all Kubernetes certs
      shell: |
        (BCK_FOLDER=$HOME/certs-backup/$(date +%Y-%m-%d_%H-%M-%S)
        mkdir -p $BCK_FOLDER/etc-kubernetes $BCK_FOLDER/etc-etcd-pki \
        && rsync -av /etc/kubernetes/ $BCK_FOLDER/etc-kubernetes --exclude tmp \
        && rsync -av /etc/etcd/pki/ $BCK_FOLDER/etc-etcd-pki
        )

    - name: Renew all Kubernetes certs
      shell: |
        kubeadm certs renew admin.conf \
        && kubeadm certs renew apiserver \
        && kubeadm certs renew apiserver-kubelet-client \
        && kubeadm certs renew controller-manager.conf \
        && kubeadm certs renew front-proxy-client \
        && kubeadm certs renew scheduler.conf \
        && kubeadm certs renew --config=/etc/etcd/kubeadm-etcd.yml --cert-dir=/etc/etcd/pki apiserver-etcd-client \
        && kubeadm certs renew --config=/etc/etcd/kubeadm-etcd.yml --cert-dir=/etc/etcd/pki etcd-healthcheck-client \
        && kubeadm certs renew --config=/etc/etcd/kubeadm-etcd.yml --cert-dir=/etc/etcd/pki etcd-peer \
        && kubeadm certs renew --config=/etc/etcd/kubeadm-etcd.yml --cert-dir=/etc/etcd/pki etcd-server

    - name: Renew Kubernetes super-admin.conf (only if Kubernetes version >= 1.29)
      shell: |
        kubeadm certs renew super-admin.conf
      when: kubernetes_version.stdout is version('1.29', '>=')

    - name: Restart all control plane components
      shell: |
        crictl ps -q --name 'kube-(controller-manager|scheduler|apiserver)' | xargs -r crictl stop
        crictl ps -a -q --state exited --name 'kube-(apiserver|controller-manager|scheduler)' | xargs -r crictl rm
        systemctl restart etcd

    - name: Wait for kube-controller-manager to be running
      shell: crictl ps --name kube-controller-manager | grep -q Running
      register: kube_controller_manager_status
      retries: 10
      delay: 5
      until: kube_controller_manager_status.rc == 0

    - name: Wait for kube-scheduler to be running
      shell: crictl ps --name kube-scheduler | grep -q Running
      register: kube_scheduler_status
      retries: 10
      delay: 5
      until: kube_scheduler_status.rc == 0

    - name: Wait for kube-apiserver to be running
      shell: crictl ps --name kube-apiserver | grep -q Running
      register: kube_apiserver_status
      retries: 10
      delay: 5
      until: kube_apiserver_status.rc == 0

    - name: Wait for etcd to be running
      shell: systemctl is-active etcd --quiet
      register: etcd_status
      retries: 10
      delay: 5
      until: etcd_status.rc == 0


- name: Renew Kubelet certificates
  hosts: master,nodes
  become: true
  serial: 1
  tasks:
    - name: Ensure Kubelet client certificate auto-renewal
      block:
      - name: Check whether it's already done
        shell: cat /etc/kubernetes/kubelet.conf | grep /var/lib/kubelet/pki/kubelet-client-current.pem
      rescue:
      - name: Remove static client cert from kubelet.conf
        lineinfile:
          path: /etc/kubernetes/kubelet.conf
          state: absent
          regexp: '.*client-certificate-data.*'
      - name: Remove static client key from kubelet.conf
        lineinfile:
          path: /etc/kubernetes/kubelet.conf
          state: absent
          regexp: '.*client-key-data.*'
      - name: Link kubelet.conf to kubelet-client-current.pem
        blockinfile:
          path: /etc/kubernetes/kubelet.conf
          marker: ""
          insertafter: "user:"
          content: |4
                  client-certificate: /var/lib/kubelet/pki/kubelet-client-current.pem
                  client-key: /var/lib/kubelet/pki/kubelet-client-current.pem
      - name: Remove the blank line from the previous "blockinfile" task
        lineinfile :
          path: /etc/kubernetes/kubelet.conf
          state: absent
          regexp: '^$'

    - name: Delete the Kubelet server cert before regenarating them
      file: 
        path: "{{ print "{{ item }}" }}"
        state: absent 
      with_items:
        - /var/lib/kubelet/pki/kubelet.crt
        - /var/lib/kubelet/pki/kubelet.key
        
    - name: Restart Kubelet and regenerate the server certificate
      shell: |
        systemctl restart kubelet.service

    - name: Check if Kubelet is running
      shell: systemctl is-active kubelet --quiet
      register: kubelet_status
      retries: 10
      delay: 5
      until: kubelet_status.rc == 0


- name: Print Control Plane certificates expiration dates
  hosts: master
  become: true
  tasks:
    - name: Print certificates expiration dates
      shell: |
        find /etc/kubernetes/pki /etc/etcd/pki -type f -name "*.crt" -print | sort |
        egrep -v 'ca\.crt$|\/pki\/expired\/|\/tmp\/|ca-bundle\.' |
        xargs -L 1 -t  -i bash -c 'openssl x509  -noout -text -in {} | grep After'
      register: pki_info
    - debug: var=pki_info.stdout_lines

    - name: Print kubeconfig expiration dates (expected 'unable to load certificate' error)
      ignore_errors: true # error with message 'unable to load certificate' are expected here
      shell: |
        find /etc/kubernetes -type f -name '*.conf' |
        egrep -v 'expired' |
        xargs -L 1 -t -i bash -c 'kubectl config view --kubeconfig=/etc/kubernetes/admin.conf --raw -o jsonpath="{.users[0].user.client-certificate-data}" --kubeconfig={} | base64 -d | openssl x509 -noout -text | grep After'
      register: kconfig_info
    - debug: var=kconfig_info.stdout_lines

- name: Print Kubelet certificates expiration dates
  hosts: master,nodes
  become: true
  tasks:
    - name: Print Kubelet certificates expiration dates
      shell: |
        curl -kv https://127.0.0.1:10250 2>&1 | grep expire 
      register: kubelet_info
    - debug: var=kubelet_info.stdout_lines