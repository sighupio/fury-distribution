#!/usr/bin/env bats

load ./helper

@test "Velero is Running" {
    info
    test() {
        kubectl get pods -l k8s-app=velero -o json -n kube-system |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Velero Restic is Running" {
    info
    test() {
        kubectl get pods -l k8s-app=velero-restic -o json -n kube-system |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 5
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}
