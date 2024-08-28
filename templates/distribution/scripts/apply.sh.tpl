#!/usr/bin/env sh

set -e

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"
vendorPath="{{ .paths.vendorPath }}"

$kustomizebin build --load_restrictor LoadRestrictionsNone . > out.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
  cat out.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > out-filtered.yaml
  cp out-filtered.yaml out.yaml
fi
{{- end }}

{{- if and (ne .spec.distribution.modules.monitoring.type "prometheusAgent") (not .spec.distribution.modules.monitoring.alertmanager.installDefaultRules) }}
if $kubectlbin get apiservice v1alpha1.monitoring.coreos.com > /dev/null 2>&1; then
  # filter out the Alertmanger Configuration custom resources from the build.
  cat out.yaml | $yqbin 'select(.kind != "AlertmanagerConfig")' > out-filtered.yaml
  cp out-filtered.yaml out.yaml
fi
{{- end }}

if [ "$dryrun" != "" ]; then
  exit 0
fi

{{- if eq .spec.distribution.modules.networking.type "calico" }}
$kubectlbin create namespace calico-system --dry-run=client -o yaml | $kubectlbin apply -f - --server-side
{{- end }}

< out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin apply -f - --server-side
< out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin wait --for condition=established --timeout=60s -f -

echo "Clean up init jobs, since they cannot be changed without conficts and they are idempotent by nature..."

$kubectlbin delete --ignore-not-found --wait --timeout=180s job minio-setup -n kube-system
$kubectlbin delete --ignore-not-found --wait --timeout=180s job minio-logging-buckets-setup -n logging
$kubectlbin delete --ignore-not-found --wait --timeout=180s job minio-monitoring-buckets-setup -n monitoring
$kubectlbin delete --ignore-not-found --wait --timeout=180s job minio-tracing-buckets-setup -n tracing

< out.yaml \
  $yqbin 'select(.kind != "Issuer" and .kind != "ClusterIssuer" and .kind != "Certificate" and .kind != "Ingress" and .kind != "K8sLivenessProbe" and .kind != "K8sReadinessProbe" and .kind != "K8sUniqueIngressHost" and .kind != "SecurityControls")' \
  | $yqbin 'select(.metadata.name != "gatekeeper-mutating-webhook-configuration" and .metadata.name != "gatekeeper-validating-webhook-configuration")' \
  | $kubectlbin apply -f - --server-side

< out.yaml $yqbin 'select(.kind == "Deployment" and .metadata.namespace == "cert-manager")' | $kubectlbin wait --for condition=available --timeout=360s -f -

< out.yaml \
  $yqbin 'select(.kind == "Issuer" or .kind == "ClusterIssuer" or .kind == "Certificate")' \
  | $kubectlbin apply -f - --server-side

{{- if eq .spec.distribution.modules.ingress.nginx.type "dual" }}
$kubectlbin rollout status daemonset nginx-ingress-controller-external -n ingress-nginx --timeout=180s

$kubectlbin rollout status daemonset nginx-ingress-controller-internal -n ingress-nginx --timeout=180s

{{- end }}

{{- if eq .spec.distribution.modules.ingress.nginx.type "single" }}
$kubectlbin rollout status daemonset nginx-ingress-controller -n ingress-nginx --timeout=180s

{{- end }}

{{- if eq .spec.distribution.modules.policy.type "gatekeeper" }}
$kubectlbin rollout status deployment gatekeeper-audit -n gatekeeper-system --timeout=180s
$kubectlbin rollout status deployment gatekeeper-controller-manager -n gatekeeper-system --timeout=180s
$kubectlbin rollout status deployment gatekeeper-policy-manager -n gatekeeper-system --timeout=180s
{{- end }}

{{- if eq .spec.distribution.modules.policy.type "kyverno" }}
$kubectlbin rollout status deployment kyverno-admission-controller -n kyverno --timeout=180s
$kubectlbin rollout status deployment kyverno-background-controller  -n kyverno --timeout=180s
$kubectlbin rollout status deployment kyverno-cleanup-controller -n kyverno --timeout=180s
$kubectlbin rollout status deployment kyverno-reports-controller  -n kyverno --timeout=180s
{{- end }}

< out.yaml $kubectlbin apply -f - --server-side

echo "Executing cleanup migrations on values that can be nil..."

{{- if ne .spec.distribution.modules.monitoring.type "none" }}
{{- if not .spec.distribution.modules.monitoring.alertmanager.installDefaultRules }}

echo "Cleaning up alertmanagerconfigs..."

$kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring alertmanagerconfigs.monitoring.coreos.com deadmanswitch
$kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring alertmanagerconfigs.monitoring.coreos.com infra
$kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring alertmanagerconfigs.monitoring.coreos.com k8s
$kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring secret infra-slack-webhook
$kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring secret k8s-slack-webhook
$kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring secret healthchecks-webhook

{{- end }}
{{- end }}

{{- if eq .spec.distribution.modules.tracing.type "tempo" }}
{{- if eq .spec.distribution.modules.tracing.tempo.backend "externalEndpoint" }}

echo "Cleaning up Minio HA on tracing namespace..."

$kustomizebin build $vendorPath/modules/tracing/katalog/minio-ha > delete-tracing-minio-ha.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
  cat delete-tracing-minio-ha.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-tracing-minio-ha-filtered.yaml
  cp delete-tracing-minio-ha-filtered.yaml delete-tracing-minio-ha.yaml
fi
{{- end }}
$kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-tracing-minio-ha.yaml

{{- end }}
{{- end }}

{{- if eq .spec.distribution.modules.monitoring.type "mimir" }}
{{- if eq .spec.distribution.modules.monitoring.mimir.backend "externalEndpoint" }}

echo "Cleaning up Minio HA on monitoring namespace..."

$kustomizebin build $vendorPath/modules/monitoring/katalog/minio-ha > delete-monitoring-minio-ha.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
  cat delete-monitoring-minio-ha.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-monitoring-minio-ha-filtered.yaml
  cp delete-monitoring-minio-ha-filtered.yaml delete-monitoring-minio-ha.yaml
fi
{{- end }}
$kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-monitoring-minio-ha.yaml

{{- end }}
{{- end }}

{{- if ne .spec.distribution.modules.dr.type "none" }}
{{- if eq .spec.distribution.modules.dr.velero.backend "externalEndpoint" }}

echo "Cleaning up Minio on kube-system namespace..."

$kustomizebin build $vendorPath/modules/dr/katalog/velero/velero-on-prem/minio > delete-dr-minio.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
  cat delete-dr-minio.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-dr-minio-filtered.yaml
  cp delete-dr-minio-filtered.yaml delete-dr-minio.yaml
fi
{{- end }}
$kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-dr-minio.yaml

{{- end }}
{{- end }}


{{- if eq .spec.distribution.modules.policy.type "kyverno" }}
{{- if not .spec.distribution.modules.policy.kyverno.installDefaultPolicies }}

echo "Cleaning up Kyverno default policies..."

$kustomizebin build $vendorPath/modules/opa/katalog/kyverno/policies | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -

{{- end }}
{{- end }}


{{- if eq .spec.distribution.modules.policy.type "gatekeeper" }}
{{- if not .spec.distribution.modules.policy.gatekeeper.installDefaultPolicies }}

echo "Cleaning up Gatekeeper default policies..."

$kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/rules/constraints | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
$kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/rules/config | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
$kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/rules/templates | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -

{{- end }}
{{- end }}

echo "Apply script completed."
