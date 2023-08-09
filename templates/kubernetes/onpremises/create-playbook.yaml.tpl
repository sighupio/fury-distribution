# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# pki
- name: Locally generate CA certificates for ETCD and MASTERS
  hosts: localhost
  tasks:
    - name: Generate etcd pkis
      delegate_to: localhost
      shell: "furyagent init etcd"
    - name: Generate master pkis
      delegate_to: localhost
      shell: "furyagent init master"
  tags:
    - pki

# containerd
- name: Containerd install
  hosts: master,nodes
  roles:
    - containerd
  tags:
    - containerd

# loadbalancer
- name: Copy CA certificates to HAProxy
  hosts: haproxy
  become: true
  vars:
    pki_dir: "{{ .spec.kubernetes.pkiFolder }}"
  tasks:
    - name: Copy Kubernetes CA
      copy:
        src: "{{ print "{{ pki_dir }}" }}/master/ca.crt"
        dest: /etc/ssl/certs/kubernetes.crt
        owner: root
        group: root
        mode: 0644
  tags:
    - pki

- name: Load balancer installation
  hosts: haproxy
  become: true
  roles:
    - haproxy
  tags:
    - haproxy

# cluster
- name: Copy etcd and master PKIs
  hosts: master
  become: true
  vars:
    pki_dir: "{{ .spec.kubernetes.pkiFolder }}"
  tasks:
    - name: Create etcd PKI directory
      file:
        path: /etc/etcd/pki/etcd
        owner: root
        group: root
        mode: 0750
        state: directory
    - name: Create Kubernetes PKI directory
      file:
        path: /etc/kubernetes/pki
        owner: root
        group: root
        mode: 0750
        state: directory
    - name: Copy etcd CA
      copy:
        src: "{{ "{{ pki_dir }}" }}/etcd/{{ "{{ item }}" }}"
        dest: "/etc/etcd/pki/etcd/{{ "{{ item }}" }}"
        owner: root
        group: root
        mode: 0640
      with_items:
        - ca.crt
        - ca.key
    - name: Copy Kubernetes CA
      copy:
        src: "{{ "{{ pki_dir }}" }}/master/{{ "{{ item }}" }}"
        dest: "/etc/kubernetes/pki/{{ "{{ item }}" }}"
        owner: root
        group: root
        mode: 0640
      with_items:
        - ca.crt
        - ca.key
        - front-proxy-ca.crt
        - front-proxy-ca.key
        - sa.key
        - sa.pub
  tags:
    - pki

- name: Kubernetes node preparation
  hosts: master,nodes
  roles:
    - kube-node-common
  tags:
    - kube-node-common

- name: etcd cluster preparation
  hosts: master
  vars:
    etcd_address: "{{ "{{ ansible_host }}" }}"
  roles:
    - etcd
  tags:
    - etcd

- name: Control plane configuration
  hosts: master
  serial: 1
  roles:
    - kube-control-plane
  tags:
    - kube-control-plane

- name: Kubernetes join nodes
  hosts: nodes
  vars:
    kubernetes_bootstrap_token: "{{ "{{ hostvars[groups.master[0]].kubernetes_bootstrap_token.stdout }}" }}"
    kubernetes_ca_hash: "{{ "{{ hostvars[groups.master[0]].kubernetes_ca_hash.stdout }}" }}"
  roles:
    - kube-worker
  tags:
    - kube-worker
