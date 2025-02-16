# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
- name: Upgrade etcd
  hosts: master,etcd
  serial: 1
  become: true
  vars:
    etcd_address: "{{ "{{ ansible_host }}" }}"
  roles:
    - etcd
  tags:
    - etcd

- name: Etcd certificates renewal
  hosts: master,etcd
  vars:
    etcd_certs:
      - etcd/ca.crt
      - apiserver-etcd-client.crt
      - apiserver-etcd-client.key
  tasks:
    - name: Ensure rsync is installed
      package:
        name:
          - rsync
        state: latest

    - name: Backup etcd certs
      shell: |
        BCK_FOLDER=$HOME/certs-backup/$(date +%Y-%m-%d_%H-%M-%S)
        mkdir -p $BCK_FOLDER/etc-etcd-pki
        rsync -av /etc/etcd/pki/ $BCK_FOLDER/etc-etcd-pki

    - name: Renewing etcd certificates
      command: "{{ print "{{ item }}" }}"
      loop:
        - "kubeadm certs renew --cert-dir=/etc/etcd/pki apiserver-etcd-client --config=/etc/etcd/kubeadm-etcd.yml"
        - "kubeadm certs renew --cert-dir=/etc/etcd/pki etcd-healthcheck-client --config=/etc/etcd/kubeadm-etcd.yml"
        - "kubeadm certs renew --cert-dir=/etc/etcd/pki etcd-peer --config=/etc/etcd/kubeadm-etcd.yml"
        - "kubeadm certs renew --cert-dir=/etc/etcd/pki etcd-server --config=/etc/etcd/kubeadm-etcd.yml"

    - name: Restarting etcd service
      systemd:
        name: etcd
        daemon_reload: yes
        state: restarted

- name: Distribute etcd certificates from etcd to control plane nodes
  hosts: etcd
  become: true
  vars:
    etcd_certs:
      - etcd/ca.crt
      - apiserver-etcd-client.crt
      - apiserver-etcd-client.key
  tasks:
    - name: Fetching certificates from etcd
      run_once: true
      delegate_to: "{{ print "{{ groups.etcd[0] }}" }}"
      fetch:
        src: "/etc/etcd/pki/{{ print "{{ item }}" }}"
        dest: "/tmp/etcd-certs/"
        flat: yes
      with_items: "{{ print "{{ etcd_certs }}" }}"
      when: not etcd_on_control_plane | bool

    - name: Copying certificates to control plane nodes
      run_once: true
      copy:
        src: "/tmp/etcd-certs/{{ print "{{ item[1] | basename }}" }}"
        dest: "/etc/etcd/pki/{{ print "{{ item[1] }}" }}"
        owner: root
        group: root
        mode: '0640'
      loop: "{{ print "{{ groups['master'] | product(etcd_certs) | list }}" }}"
      loop_control:
        loop_var: item
      vars:
        master: "{{ print "{{ item[0] }}" }}"
        cert: "{{ print "{{ item[1] }}" }}"
      delegate_to: "{{ print "{{ item[0] }}" }}"
      when: not etcd_on_control_plane | bool

    - name: Cleaning up temporary certificates
      run_once: true
      become: false
      delegate_to: localhost
      file:
        path: /tmp/etcd-certs
        state: absent
      when: not etcd_on_control_plane | bool

- name: Kubeadm package upgrade on etcd nodes
  become: true
  hosts: etcd
  tasks:
    - name: Include kube-node-common role
      include_role:
        name: kube-node-common
      when: not etcd_on_control_plane | bool
  tags:
    - kube-node-common
