#!/usr/bin/env bats
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
