#!/usr/bin/env bats
# shellcheck disable=SC2154

load ./helper

@test "Gatekeeper Controller is Running" {
    info
    test() {
        kubectl get pods -l control-plane=controller-manager -o json -n gatekeeper-system | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 30 2
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}
