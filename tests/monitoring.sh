#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# shellcheck disable=SC2154

load ./helper

@test "Grafana is Running" {
    info
    test() {
        kubectl get pods -l app.kubernetes.io/name=grafana -o json -n monitoring |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Prometheus Operator is Running" {
    info
    test() {
        kubectl get pods -l app.kubernetes.io/name=prometheus-operator -o json -n monitoring |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Kube State Metrics is Running" {
    info
    test() {
        kubectl get pods -l app.kubernetes.io/name=kube-state-metrics -o json -n monitoring |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Node Exporter is Running" {
    info
    test() {
        kubectl get pods -l app.kubernetes.io/name=node-exporter -o json -n monitoring |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Prometheus is Running" {
    info
    test() {
        kubectl get pods -l app.kubernetes.io/name=prometheus -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true

    }
    loop_it test 160 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "kube-proxy-metrics is Running" {
    info
    test() {
        kubectl get pods -l k8s-app=kube-proxy-metrics -o json -n monitoring | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}
