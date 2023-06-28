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

# list generated with: kustomize build . | yq 'select(.kind == "CustomResourceDefinition") | .spec.group' | sort | uniq
{{- if eq .spec.distribution.common.provider.type "eks" }}
< out.yaml $yqbin 'select(.kind == "Ingress")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -
sleep 180
{{- end }}
echo "Ingresses deleted"
< out.yaml $yqbin 'select(.apiVersion == "acme.cert-manager.io/*" or .apiVersion == "cert-manager.io/*" or .apiVersion == "config.gatekeeper.sh/*" or .apiVersion == "expansion.gatekeeper.sh/*" or .apiVersion == "externaldata.gatekeeper.sh/*" or .apiVersion == "forecastle.stakater.com/*" or .apiVersion == "logging-extensions.banzaicloud.io/*" or .apiVersion == "logging.banzaicloud.io/*" or .apiVersion == "monitoring.coreos.com/*" or .apiVersion == "mutations.gatekeeper.sh/*" or .apiVersion == "status.gatekeeper.sh/*" or .apiVersion == "templates.gatekeeper.sh/*" or .apiVersion == "velero.io/*")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -
echo "CRDs deleted"
< out.yaml $yqbin 'select(.kind == "StatefulSet")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -
echo "StatefulSets deleted"
$kubectlcmd delete --ignore-not-found --wait --timeout=180s -n monitoring --all persistentvolumeclaims || true
echo "Monitoring PVCs deleted"
$kubectlcmd delete --ignore-not-found --wait --timeout=180s -n logging --all persistentvolumeclaims || true
echo "Logging PVCs deleted"
< out.yaml $yqbin 'select(.kind == "Service" and .spec.type == "LoadBalancer")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f - || true
echo "LoadBalancer Services deleted"
sleep 180
< out.yaml $yqbin 'select(.kind != "CustomResourceDefinition")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f - || true
echo "Resources deleted"
< out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f - || true
echo "CRDs deleted"
