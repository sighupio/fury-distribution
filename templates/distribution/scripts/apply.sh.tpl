#!/usr/bin/env sh

set -e

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"

kustomizebuild=$($kustomizebin build .)

echo $kustomizebuild | $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin apply -f - --server-side
echo $kustomizebuild | $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin wait --for condition=established --timeout=60s -f -

echo $kustomizebuild \
  | $yqbin 'select(.kind != "Issuer" and .kind != "ClusterIssuer" and .kind != "Certificate" and .kind != "Ingress" and .kind != "K8sLivenessProbe" and .kind != "K8sReadinessProbe" and .kind != "K8sUniqueIngressHost" and .kind != "SecurityControls")' \
  | $kubectlbin apply -f - --server-side   

echo $kustomizebuild | $yqbin 'select(.kind == "Deployment" and .metadata.namespace == "cert-manager")' | $kubectlbin wait --for condition=available --timeout=120s -f -

echo $kustomizebuild \
  | $yqbin 'select(.kind == "Issuer" or .kind == "ClusterIssuer" or .kind == "Certificate")' \
  | $kubectlbin apply -f - --server-side

$kubectlbin get pods -o yaml -n ingress-nginx | $kubectlbin wait --for condition=Ready --timeout=180s -f -

echo $kustomizebuild | $kubectlbin apply -f - --server-side
