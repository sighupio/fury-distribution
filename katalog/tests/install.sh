#!/usr/bin/env bats

load ./helper

@test "Download" {
    info
    download() {
        furyctl install
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
        kustomize build | kubectl apply -f -
    }
    run install
    [ "$status" -eq 0 ]
}
