#!/usr/bin/env sh

set -e

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"
kubeconfig="$2"

if [ "$1" = "true" ]; then
  dryRun="--dry-run=client"
else
  dryRun=""
fi

kubectlcmd="$kubectlbin $dryRun --kubeconfig $kubeconfig"

$kustomizebin build . > out.yaml

# list generated with: kustomize build . | yq 'select(.kind == "CustomResourceDefinition") | .spec.group' | sort | uniq
cat out.yaml | $yqbin 'select(.apiVersion == "acme.cert-manager.io/*" or .apiVersion == "cert-manager.io/*" or .apiVersion == "config.gatekeeper.sh/*" or .apiVersion == "expansion.gatekeeper.sh/*" or .apiVersion == "externaldata.gatekeeper.sh/*" or .apiVersion == "forecastle.stakater.com/*" or .apiVersion == "logging-extensions.banzaicloud.io/*" or .apiVersion == "logging.banzaicloud.io/*" or .apiVersion == "monitoring.coreos.com/*" or .apiVersion == "mutations.gatekeeper.sh/*" or .apiVersion == "status.gatekeeper.sh/*" or .apiVersion == "templates.gatekeeper.sh/*" or .apiVersion == "velero.io/*")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -

cat out.yaml | $yqbin 'select(.kind == "StatefulSet")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -

cat out.yaml | $yqbin 'select(.kind == "PersistentVolumeClaim" and .metadata.namespace == "monitoring")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -
cat out.yaml | $yqbin 'select(.kind == "PersistentVolumeClaim" and .metadata.namespace == "logging")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -

cat out.yaml | $yqbin 'select(.kind == "Service" and .spec.type == "LoadBalancer")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -

cat out.yaml | $yqbin 'select(.kind != "CustomResourceDefinition")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -
cat out.yaml | $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -
