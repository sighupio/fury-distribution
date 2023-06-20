#!/usr/bin/env sh

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"

if [ "$1" = "true" ]; then
  dryRun="--dry-run=client"
else
  dryRun=""
fi

$kubectlbin delete --all-namespaces --wait --timeout=180s --all ingress $dryRun

$kubectlbin delete --namespace logging --wait --timeout=180s --ignore-not-found deployment loki-distributed-distributor $dryRun
$kubectlbin delete --namespace logging --wait --timeout=180s --ignore-not-found deployment loki-distributed-compactor $dryRun
$kubectlbin delete --namespace logging --wait --timeout=180s --all loggings.logging.banzaicloud.io $dryRun
$kubectlbin delete --namespace logging --wait --timeout=180s --all statefulsets.apps $dryRun
$kubectlbin delete --namespace logging --wait --timeout=180s --all persistentvolumeclaims $dryRun

$kubectlbin delete --namespace monitoring --wait --timeout=180s --all prometheuses.monitoring.coreos.com $dryRun
$kubectlbin delete --namespace monitoring --wait --timeout=180s --all prometheusrules.monitoring.coreos.com $dryRun
$kubectlbin delete --namespace monitoring --wait --timeout=180s --all persistentvolumeclaims $dryRun

$kubectlbin delete --namespace ingress-nginx --wait --timeout=180s --all services $dryRun

$kustomizebin build . | $kubectlbin delete -f - $dryRun
