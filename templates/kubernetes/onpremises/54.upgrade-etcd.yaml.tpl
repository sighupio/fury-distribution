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
    - kubeadm-upgrade

- name: Etcd certificates renewal
  hosts: master,etcd
  vars:
    etcd_certs:
      - etcd/ca.crt
      - apiserver-etcd-client.crt
      - apiserver-etcd-client.key
  tasks:
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
  - name: Ensuring temporary directory exists on localhost
    run_once: true
    delegate_to: localhost
    become: false
    file:
      path: /tmp/etcd-certs
      state: directory
      mode: '0755'
  - name: Fetching certificates from etcd
    run_once: true
    fetch:
      src: "/etc/etcd/pki/{{ "{{ item }}" }}"
      dest: "/tmp/etcd-certs/"
      flat: yes
    delegate_to: "{{ "{{ groups['etcd'][0] }}" }}"
    with_items: "{{ "{{ etcd_certs }}" }}"
  - name: Copy certificates from localhost to control plane nodes
    delegate_to: "{{ "{{ master }}" }}"
    copy:
      src: "/tmp/etcd-certs/{{ "{{ cert | basename }}" }}"
      dest: "/etc/etcd/pki/{{ "{{ cert }}" }}"
      owner: root
      group: root
      mode: '0640'
    loop: "{{ "{{ groups['master'] | product(etcd_certs) | list }}" }}"
    loop_control:
      loop_var: item
    vars:
      master: "{{ "{{ item[0] }}" }}"
      cert: "{{ "{{ item[1] }}" }}"
  - name: Clean up temporary certificates on localhost
    run_once: true
    become: false
    delegate_to: localhost
    file:
      path: /tmp/etcd-certs
      state: absent

- name: Kubeadm package upgrade on etcd nodes
  become: true
  hosts: etcd
  roles:
    - kube-node-common
  tags:
    - kube-node-common
