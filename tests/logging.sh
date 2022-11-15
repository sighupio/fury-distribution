#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# shellcheck disable=SC2154

load ./helper

@test "OpenSearch is Running" {
    info
    test() {
        kubectl get pods -l app.kubernetes.io/name=opensearch -o json -n logging |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Cerebro is Running" {
    info
    test() {
        kubectl get pods -l app=cerebro -o json -n logging |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Fluentd is Running" {
    info
    test() {
        kubectl get pods -l app.kubernetes.io/name=fluentd -o json -n logging |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "OpenSearch Dashboards is Running" {
    info
    test() {
        kubectl get pods -l app.kubernetes.io/name=opensearch-dashboards -o json -n logging |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}
