# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# reset
- name: Reset Kubernetes cluster
  hosts: master,nodes
  tasks:
    - name: Reset kubeadm
      shell: "kubeadm reset -f"
    - name: Clean iptables
      shell: "iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X"
    - name: Clean IPVS
      shell: "ipvsadm --clear"
    - name: Stop etcd
      systemd:
        name: etcd
        state: stopped
    - name: Clean etcd datadir
      file:
        path: /var/lib/etcd
        state: absent
    - name: Cleanup pki etcd
      file:
        path: /etc/etcd/pki
        state: absent
    - name: Cleanup pki kubernetes
      file:
        path: /etc/kubernetes/pki
        state: absent
    - name: Reboot
      reboot:
  tags:
    - reset-kubernetes
