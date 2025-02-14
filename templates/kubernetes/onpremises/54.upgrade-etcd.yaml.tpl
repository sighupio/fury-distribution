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
    - name: Retrieving certificates from etcd nodes
      run_once: true
      delegate_to: "{{ print "{{ groups.etcd[0] }}" }}"
      fetch:
        src: "/etc/etcd/pki/{{ print "{{ item }}" }}"
        dest: "/tmp/etcd-certs/"
        flat: yes
      with_items: "{{ print "{{ etcd_certs }}" }}"
      when: not etcd_on_control_plane | bool

    - name: Copying certificates to control plane nodes
      copy:
        src: "/tmp/etcd-certs/{{ print "{{ item | basename }}" }}"
        dest: "/etc/etcd/pki/{{ print "{{ item }}" }}"
        owner: root
        group: root
        mode: 0640
      with_items: "{{ print "{{ etcd_certs }}" }}"
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
