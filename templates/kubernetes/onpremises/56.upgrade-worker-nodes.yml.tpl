# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.


- name: Kubernetes node preparation
  hosts: nodes
  vars:
    skip_kubelet_upgrade: True
  roles:
    - kube-node-common
  tags:
    - kube-node-common

- name: Kubernetes drain
  hosts: nodes
  tasks:
    - name: Get node name
      set_fact:
        node_name: "{{ print "{{ kubernetes_hostname }}" }}"
    - name: Drain node
      delegate_to: localhost
      shell: "{{ .paths.kubectl }} {{ print "drain --grace-period=60 --timeout=360s --force --ignore-daemonsets --delete-local-data {{ node_name }} --kubeconfig={{ kubernetes_kubeconfig_path }}admin.conf" }}"

- name: Kubernetes kubeadm upgrade node
  hosts: nodes
  tasks:
    - name: Upgrade kubelet config
      shell: "kubeadm upgrade node"

- name: Kubelet and Containerd upgrade
  hosts: nodes
  vars:
    skip_kubelet_upgrade: False
  roles:
    - kube-node-common
    - containerd
  tags:
    - kube-node-common
    - containerd

- name: Kubernetes uncordon node
  hosts: nodes
  tasks:
    - name: Get node name
      set_fact:
        node_name: "{{ print "{{ kubernetes_hostname }}" }}"
    - name: Uncordon node
      delegate_to: localhost
      shell: "sleep 60 && {{ .paths.kubectl }} {{ print "uncordon {{ node_name }} --kubeconfig={{ kubernetes_kubeconfig_path }}admin.conf" }}"