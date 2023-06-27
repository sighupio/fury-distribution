#!/usr/bin/env sh

set -e

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"

if [ "$1" = "--dry-run=true" ]; then
  dryRun="--dry-run=client"
else
  dryRun=""
fi

$kustomizebin build . > out.yaml

# list generated with: kustomize build . | yq 'select(.kind == "CustomResourceDefinition") | .spec.group' | sort | uniq
cat out.yaml | $yqbin 'select(.apiVersion == "acme.cert-manager.io/*" or .apiVersion == "cert-manager.io/*" or .apiVersion == "config.gatekeeper.sh/*" or .apiVersion == "expansion.gatekeeper.sh/*" or .apiVersion == "externaldata.gatekeeper.sh/*" or .apiVersion == "forecastle.stakater.com/*" or .apiVersion == "logging-extensions.banzaicloud.io/*" or .apiVersion == "logging.banzaicloud.io/*" or .apiVersion == "monitoring.coreos.com/*" or .apiVersion == "mutations.gatekeeper.sh/*" or .apiVersion == "status.gatekeeper.sh/*" or .apiVersion == "templates.gatekeeper.sh/*" or .apiVersion == "velero.io/*")' | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f - $dryRun

cat out.yaml | $yqbin 'select(.kind == "StatefulSet")' | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f - $dryRun

cat out.yaml | $yqbin 'select(.kind == "PersistentVolumeClaim" and .metadata.namespace == "monitoring")' | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f - $dryRun
cat out.yaml | $yqbin 'select(.kind == "PersistentVolumeClaim" and .metadata.namespace == "logging")' | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f - $dryRun

cat out.yaml | $yqbin 'select(.kind == "Service" and .spec.type == "LoadBalancer")' | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f - $dryRun

cat out.yaml | $yqbin 'select(.kind != "CustomResourceDefinition")' | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f - $dryRun
cat out.yaml | $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f - $dryRun
