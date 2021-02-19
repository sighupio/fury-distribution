#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# shellcheck disable=SC2154

load ./helper

@test "Cert-manager Controller is Running" {
    info
    test() {
        kubectl get pods -l app=cert-manager -o json -n cert-manager |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Nginx Ingress Controller is Running" {
    info
    test() {
        kubectl get pods -l app=ingress-nginx -o json -n ingress-nginx |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Forecastle is Running" {
    info
    test() {
        kubectl get pods -l app=forecastle -o json -n ingress-nginx |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}
