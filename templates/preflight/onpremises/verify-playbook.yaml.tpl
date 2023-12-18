# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

- name: Verify that the cluster exists
  hosts: master
  become: true
  tasks:
    - name: Check that the /etc/kubernetes/admin.conf exists
      stat:
        path: /etc/kubernetes/admin.conf
    - name: Getting admin.conf kubeconfig
      fetch:
        src: /etc/kubernetes/admin.conf
        dest: "{{ "{{ kubernetes_kubeconfig_path }}/admin.conf" }}"
        flat: yes
