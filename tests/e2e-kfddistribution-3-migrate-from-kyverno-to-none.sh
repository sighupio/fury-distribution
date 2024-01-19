#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# shellcheck disable=SC2154

load ./helper

@test "Kyverno NS has been deleted" {
    info
    test() {
        kubectl get namespace | grep -q -v "kyverno"
    }
    loop_it test 60 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}