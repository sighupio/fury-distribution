#!/usr/bin/env bats

load ./helper

@test "Download" {
    info
    download() {
        furyctl install -H
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
    loop_it install 30 5
    status=${loop_it_result}
    [ "$status" -eq 0 ]
}
