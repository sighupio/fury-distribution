#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# shellcheck disable=SC2154

load ./helper

@test "Gatekeeper Controller is Running" {
    info
    test() {
        kubectl get pods -l control-plane=controller-manager -o json -n gatekeeper-system | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}
@test "Gatekeeper Audit is Running" {
  info
  test(){
    kubectl get pods -l control-plane=audit-controller -o json -n gatekeeper-system | jq '.items[].status.containerStatuses[].ready' | uniq | grep -q true
  }
  loop_it test 30 2
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}

@test "Wait for Gatekeeper Policy Manager" {
  info
  test(){
    readyReplicas=$(kubectl get deploy gatekeeper-policy-manager -n gatekeeper-system -o jsonpath="{.status.readyReplicas}")
    if [ "${readyReplicas}" != "1" ]; then return 1; fi
  }
  loop_it test 30 2
  status=${loop_it_result}
  [[ "$status" -eq 0 ]]
}
