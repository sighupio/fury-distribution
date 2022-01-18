#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# shellcheck disable=SC2154

load ./helper

@test "Calico Kube Controller is Running" {
    info
    test() {
        kubectl get pods -l k8s-app=calico-kube-controllers -o json -n kube-system |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Calico Node is Running" {
    info
    test() {
        kubectl get pods -l k8s-app=calico-node -o json -n kube-system |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}
