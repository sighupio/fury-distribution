#!/usr/bin/env bats

load ./helper

@test "Goldpinger is Running" {
    info
    test() {
        kubectl get pods -l k8s-app=goldpinger -o json -n monitoring |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 30 2
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Grafana is Running" {
    info
    test() {
        kubectl get pods -l app=grafana -o json -n monitoring |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 30 2
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Prometheus Operator is Running" {
    info
    test() {
        kubectl get pods -l k8s-app=prometheus-operator -o json -n monitoring |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 30 2
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Kube State Metrics is Running" {
    info
    test() {
        kubectl get pods -l app=kube-state-metrics -o json -n monitoring |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 30 2
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Node Exporter is Running" {
    info
    test() {
        kubectl get pods -l app=node-exporter -o json -n monitoring |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 30 2
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Prometheus is Running" {
    info
    test() {
        kubectl get pods -l app=prometheus -o json -n monitoring |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 30 2
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}
