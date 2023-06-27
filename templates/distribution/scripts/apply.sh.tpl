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

$kustomizebin build . > out.yaml

< out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd apply -f - --server-side

if [ "$dryrun" = "" ]; then
  < out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd wait --for condition=established --timeout=60s -f -
fi

< out.yaml \
  $yqbin 'select(.kind != "Issuer" and .kind != "ClusterIssuer" and .kind != "Certificate" and .kind != "Ingress" and .kind != "K8sLivenessProbe" and .kind != "K8sReadinessProbe" and .kind != "K8sUniqueIngressHost" and .kind != "SecurityControls")' \
  | $kubectlcmd apply -f - --server-side

if [ "$dryrun" = "" ]; then
  < out.yaml $yqbin 'select(.kind == "Deployment" and .metadata.namespace == "cert-manager")' | $kubectlcmd wait --for condition=available --timeout=120s -f -
fi

< out.yaml \
  $yqbin 'select(.kind == "Issuer" or .kind == "ClusterIssuer" or .kind == "Certificate")' \
  | $kubectlcmd apply -f - --server-side

if [ "$dryrun" = "" ]; then
  $kubectlcmd get pods -o yaml -n ingress-nginx | $kubectlcmd wait --for condition=Ready --timeout=180s -f -
fi

< out.yaml $kubectlcmd apply -f - --server-side
