#!/usr/bin/env sh

set -e

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"
vendorPath="{{ .paths.vendorPath }}"

{{- if index . "reducers" }}

{{- if index .reducers "distributionModulesLoggingType" }}

deleteOpensearch() {
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n logging opensearch-dashboards
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n pomerium opensearch-dashboards
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n pomerium cerebro
  $kustomizebin build $vendorPath/modules/logging/katalog/opensearch-dashboards | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/logging/katalog/opensearch-triple | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/logging/katalog/cerebro | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  echo "Waiting 3 minutes"
  sleep 180
  $kubectlbin delete -l app.kubernetes.io/name=opensearch pvc -n logging --wait --timeout=180s
  echo "Opensearch resources deleted"
}

deleteLoki() {
  $kustomizebin build $vendorPath/modules/logging/katalog/loki-distributed | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  echo "Waiting 3 minutes"
  sleep 180
  $kubectlbin delete -l app.kubernetes.io/name=loki-distributed pvc -n logging --wait --timeout=180s
  echo "Loki resources deleted"
}

{{- if eq .reducers.distributionModulesLoggingType.to "loki" }}

{{- if eq .reducers.distributionModulesLoggingType.from "opensearch" }}
deleteOpensearch
{{- end }}

{{- end }}

{{- if eq .reducers.distributionModulesLoggingType.to "opensearch" }}

{{- if eq .reducers.distributionModulesLoggingType.from "loki" }}
deleteLoki
{{- end }}

{{- end }}

{{- end }} # end distributionModulesLoggingType

{{- end }} # end reducers
