#!/usr/bin/env bats
# Copyright (c) 2020 SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# shellcheck disable=SC2154

load ./helper

@test "Download" {
    info
    download() {
        furyctl vendor -H
    }
    run download
    [ "$status" -eq 0 ]
}

@test "Render" {
    info
    render() {
        kustomize build
    }
    run render
    [ "$status" -eq 0 ]
}

@test "Install" {
    info
    install() {
        apply .
    }
    loop_it install 120 10
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}
