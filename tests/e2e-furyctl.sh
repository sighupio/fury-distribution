#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# shellcheck disable=SC2154

load ./helper

@test "KFDDistribution: Install furyctl config 1" {
    info
    create() {
        ./tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-init-cluster.yaml --outdir "$PWD" -D --distro-location ./
    }
    run create
    [ "$status" -eq 0 ]
}

