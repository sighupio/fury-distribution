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

{{- if eq .spec.distribution.modules.networking.type "calico" }}
$kubectlcmd create namespace calico-system --dry-run=client -o yaml | $kubectlcmd apply -f - --server-side
{{- end }}

< out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd apply -f - --server-side
< out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd wait --for condition=established --timeout=60s -f -
< out.yaml \
  $yqbin 'select(.kind != "Issuer" and .kind != "ClusterIssuer" and .kind != "Certificate" and .kind != "Ingress" and .kind != "K8sLivenessProbe" and .kind != "K8sReadinessProbe" and .kind != "K8sUniqueIngressHost" and .kind != "SecurityControls")' \
  | $yqbin 'select(.metadata.name != "gatekeeper-mutating-webhook-configuration" and .metadata.name != "gatekeeper-validating-webhook-configuration")' \
  | $kubectlcmd apply -f - --server-side

< out.yaml $yqbin 'select(.kind == "Deployment" and .metadata.namespace == "cert-manager")' | $kubectlcmd wait --for condition=available --timeout=360s -f -

< out.yaml \
  $yqbin 'select(.kind == "Issuer" or .kind == "ClusterIssuer" or .kind == "Certificate")' \
  | $kubectlcmd apply -f - --server-side

{{- if eq .spec.distribution.modules.ingress.nginx.type "dual" }}
$kubectlcmd rollout status daemonset nginx-ingress-controller-external -n ingress-nginx --timeout=180s

$kubectlcmd rollout status daemonset nginx-ingress-controller-internal -n ingress-nginx --timeout=180s

{{- end }}

{{- if eq .spec.distribution.modules.ingress.nginx.type "single" }}
$kubectlcmd rollout status daemonset nginx-ingress-controller -n ingress-nginx --timeout=180s

{{- end }}

{{- if eq .spec.distribution.modules.policy.type "gatekeeper" }}
$kubectlbin rollout status deployment gatekeeper-audit -n gatekeeper-system --timeout=180s
$kubectlbin rollout status deployment gatekeeper-controller-manager -n gatekeeper-system --timeout=180s
$kubectlbin rollout status deployment gatekeeper-policy-manager -n gatekeeper-system --timeout=180s
{{- end }}

< out.yaml $kubectlcmd apply -f - --server-side
