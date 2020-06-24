#!/usr/bin/env bats
# shellcheck disable=SC2154

load ./helper

@test "Elasticsearch is Running" {
    info
    test() {
        kubectl get pods -l app=elasticsearch -o json -n logging |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
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
        kubectl get pods -l app=fluentd -o json -n logging |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}

@test "Kibana is Running" {
    info
    test() {
        kubectl get pods -l app=kibana -o json -n logging |jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}
