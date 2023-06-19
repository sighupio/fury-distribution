#!/bin/env sh

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"

$kustomizebin build . | $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin apply -f - --server-side
$kustomizebin build . | $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin wait --for condition=established --timeout=60s -f -

$kustomizebin build . \
  | $yqbin 'select(.kind != "Issuer" and .kind != "ClusterIssuer" and .kind != "Certificate" and .kind != "Ingress" and .kind != "K8sLivenessProbe" and .kind != "K8sReadinessProbe" and .kind != "K8sUniqueIngressHost" and .kind != "SecurityControls")' \
  | $kubectlbin apply -f - --server-side   

$kustomizebin build . | $yqbin 'select(.kind == "Deployment" and .metadata.namespace =="cert-manager" )' | $kubectlbin wait --for condition=available --timeout=120s -f -

$kustomizebin build . \
  | $yqbin 'select(.kind == "Issuer" or .kind == "ClusterIssuer" or .kind == "Certificate")' \
  | $kubectlbin apply -f - --server-side

$kubectlbin get pods -o yaml -n ingress-nginx | $kubectlbin wait --for condition=Ready --timeout=180s -f -

$kustomizebin build . | $kubectlbin apply -f - --server-side
