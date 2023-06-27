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

cat out.yaml | $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin apply -f - --server-side $dryRun
cat out.yaml | $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin wait --for condition=established --timeout=60s -f - $dryRun

cat out.yaml \
  | $yqbin 'select(.kind != "Issuer" and .kind != "ClusterIssuer" and .kind != "Certificate" and .kind != "Ingress" and .kind != "K8sLivenessProbe" and .kind != "K8sReadinessProbe" and .kind != "K8sUniqueIngressHost" and .kind != "SecurityControls")' \
  | $kubectlbin apply -f - --server-side $dryRun

cat out.yaml | $yqbin 'select(.kind == "Deployment" and .metadata.namespace == "cert-manager")' | $kubectlbin wait --for condition=available --timeout=120s -f - $dryRun

cat out.yaml \
  | $yqbin 'select(.kind == "Issuer" or .kind == "ClusterIssuer" or .kind == "Certificate")' \
  | $kubectlbin apply -f - --server-side $dryRun

$kubectlbin get pods -o yaml -n ingress-nginx | $kubectlbin wait --for condition=Ready --timeout=180s -f - $dryRun

cat out.yaml | $kubectlbin apply -f - --server-side $dryRun
