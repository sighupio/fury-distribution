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

@test "Install CRDs" {
    info
    kubectl apply -f vendor/katalog/networking/calico/crd.yml
    kubectl apply -f vendor/katalog/monitoring/prometheus-operator/crd-alertmanager.yml
    kubectl apply -f vendor/katalog/monitoring/prometheus-operator/crd-prometheus.yml
    kubectl apply -f vendor/katalog/monitoring/prometheus-operator/crd-rule.yml
    kubectl apply -f vendor/katalog/monitoring/prometheus-operator/crd-servicemonitor.yml
    kubectl apply -f vendor/katalog/ingress/cert-manager/cert-manager-controller/crd.yml
    kubectl apply -f vendor/katalog/opa/gatekeeper/core/crd.yml
    kubectl apply -f vendor/katalog/dr/velero/velero-base/crds.yaml
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
