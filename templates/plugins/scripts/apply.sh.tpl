#!/usr/bin/env sh

set -e

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"

if [ "$1" = "true" ]; then
  dryrun="--dry-run=server"
else
  dryrun=""
fi

if [ -n "$2" ]; then
  kubeconfig="--kubeconfig=$2"
else
  kubeconfig=""
fi

kubectlcmd="$kubectlbin $dryrun $kubeconfig"

$kustomizebin build --load_restrictor LoadRestrictionsNone . > out.yaml

if [ "$dryrun" != "" ]; then
  exit 0
fi

< out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd apply -f - --server-side
< out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd wait --for condition=established --timeout=60s -f -
< out.yaml $kubectlcmd apply -f - --server-side
