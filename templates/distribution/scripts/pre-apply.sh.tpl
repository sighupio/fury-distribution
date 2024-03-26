#!/usr/bin/env sh

set -e

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"
vendorPath="{{ .paths.vendorPath }}"

{{- if index . "reducers" }}

# ███████ ████████  █████  ██████  ████████ 
# ██         ██    ██   ██ ██   ██    ██    
# ███████    ██    ███████ ██████     ██    
#      ██    ██    ██   ██ ██   ██    ██    
# ███████    ██    ██   ██ ██   ██    ██    

# Text generated with: https://www.patorjk.com/software/taag/#p=display&f=ANSI%20Regular&t=TRACING%20TYPE

# ██       ██████   ██████   ██████  ██ ███    ██  ██████      ████████ ██    ██ ██████  ███████ 
# ██      ██    ██ ██       ██       ██ ████   ██ ██              ██     ██  ██  ██   ██ ██      
# ██      ██    ██ ██   ███ ██   ███ ██ ██ ██  ██ ██   ███        ██      ████   ██████  █████   
# ██      ██    ██ ██    ██ ██    ██ ██ ██  ██ ██ ██    ██        ██       ██    ██      ██      
# ███████  ██████   ██████   ██████  ██ ██   ████  ██████         ██       ██    ██      ███████ 
                                           
{{- if index .reducers "distributionModulesLoggingType" }}

deleteOpensearch() {
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n logging opensearch-dashboards
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n pomerium opensearch-dashboards
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n pomerium cerebro

  $kustomizebin build $vendorPath/modules/logging/katalog/opensearch-dashboards > delete-opensearch-cerebro.yaml
  $kustomizebin build $vendorPath/modules/logging/katalog/opensearch-triple >> delete-opensearch-cerebro.yaml
  $kustomizebin build $vendorPath/modules/logging/katalog/cerebro >> delete-opensearch-cerebro.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-opensearch-cerebro.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-opensearch-cerebro-filtered.yaml
    cp delete-opensearch-cerebro-filtered.yaml delete-opensearch-cerebro.yaml
  fi
{{- end }}

  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-opensearch-cerebro.yaml
  $kubectlbin delete --ignore-not-found -l app.kubernetes.io/name=opensearch pvc -n logging --wait --timeout=180s
  echo "Opensearch resources deleted"
}

deleteLoki() {

  $kustomizebin build $vendorPath/modules/logging/katalog/loki-distributed > delete-loki.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-loki.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-loki-filtered.yaml
    cp delete-loki-filtered.yaml delete-loki.yaml
  fi
{{- end }}

  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-loki.yaml
  $kubectlbin delete --ignore-not-found -l app.kubernetes.io/name=loki-distributed pvc -n logging --wait --timeout=180s
  echo "Loki resources deleted"
}

deleteLoggingOperator() {

  $kustomizebin build $vendorPath/modules/logging/katalog/logging-operated | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/logging/katalog/configs | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -

  $kustomizebin build $vendorPath/modules/logging/katalog/minio-ha > delete-logging-minio-ha.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-logging-minio-ha.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-logging-minio-ha-filtered.yaml
    cp delete-logging-minio-ha-filtered.yaml delete-tracing-minio-ha.yaml
  fi
{{- end }}
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-logging-minio-ha.yaml

  $kustomizebin build $vendorPath/modules/logging/katalog/logging-operator | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -

  echo "Logging Operator and NS deleted"
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



{{- if eq .reducers.distributionModulesLoggingType.to "none" }}
deleteLoki
deleteOpensearch
deleteLoggingOperator
{{- end }}



{{- end }} # end distributionModulesLoggingType

#  █████  ██      ███████ ██████  ████████ ███    ███     ██████  ██    ██ ██      ███████ ███████ 
# ██   ██ ██      ██      ██   ██    ██    ████  ████     ██   ██ ██    ██ ██      ██      ██      
# ███████ ██      █████   ██████     ██    ██ ████ ██     ██████  ██    ██ ██      █████   ███████ 
# ██   ██ ██      ██      ██   ██    ██    ██  ██  ██     ██   ██ ██    ██ ██      ██           ██ 
# ██   ██ ███████ ███████ ██   ██    ██    ██      ██     ██   ██  ██████  ███████ ███████ ███████ 
                                                                                                 
                                                                                                
{{- if index .reducers "distributionModulesMonitoringAlertmanagerInstalldefaultrules" }}
{{- if eq .reducers.distributionModulesMonitoringAlertmanagerInstalldefaultrules.to false }}

   $kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring alertmanagerconfigs.monitoring.coreos.com deadmanswitch
   $kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring alertmanagerconfigs.monitoring.coreos.com infra
   $kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring alertmanagerconfigs.monitoring.coreos.com k8s
   $kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring secret infra-slack-webhook
   $kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring secret k8s-slack-webhook
   $kubectlbin delete --ignore-not-found --wait --timeout=180s -n monitoring secret healthchecks-webhook

{{- end }}
{{- end }} # end distributionModulesMonitoringAlertmanagerInstalldefaultrules

# ██████   ██████  ██      ██  ██████ ██    ██     ████████ ██    ██ ██████  ███████ 
# ██   ██ ██    ██ ██      ██ ██       ██  ██         ██     ██  ██  ██   ██ ██      
# ██████  ██    ██ ██      ██ ██        ████          ██      ████   ██████  █████   
# ██      ██    ██ ██      ██ ██         ██           ██       ██    ██      ██      
# ██       ██████  ███████ ██  ██████    ██           ██       ██    ██      ███████ 

{{- if index .reducers "distributionModulesPolicyType" }}

deleteGatekeeper() {
  
  $kubectlbin delete --ignore-not-found --wait --timeout=180s validatingwebhookconfiguration -l gatekeeper.sh/system=yes
  $kubectlbin delete --ignore-not-found --wait --timeout=180s mutatingwebhookconfiguration -l gatekeeper.sh/system=yes
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n gatekeeper-system gpm
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n pomerium gpm
  $kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/rules/constraints | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/rules/config | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/rules/templates | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/gpm | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
{{- if ne .spec.distribution.modules.monitoring.type "none" }}
  $kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/monitoring | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
{{- end }}
  $kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/core | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -

  echo "Gatekeeper resources deleted"
}

deleteKyverno() {
  $kustomizebin build $vendorPath/modules/opa/katalog/kyverno | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kubectlbin delete --ignore-not-found --wait --timeout=180s validatingwebhookconfiguration -l webhook.kyverno.io/managed-by=kyverno
  $kubectlbin delete --ignore-not-found --wait --timeout=180s mutatingwebhookconfiguration -l webhook.kyverno.io/managed-by=kyverno
  echo "Kyverno resources deleted"
}

{{- if eq .reducers.distributionModulesPolicyType.to "none" }}

{{- if eq .reducers.distributionModulesPolicyType.from "kyverno" }}
deleteKyverno
{{- end }}

{{- end }}

{{- if eq .reducers.distributionModulesPolicyType.to "none" }}

{{- if eq .reducers.distributionModulesPolicyType.from "gatekeeper" }}
deleteGatekeeper
{{- end }}

{{- end }}

{{- end }} # end distributionModulesPolicyType

# ██   ██ ██    ██ ██    ██     ██████   █████  ████████ ███████     ██████   ██████  ██      ██  ██████ ██ ███████ ███████ 
# ██  ██   ██  ██  ██    ██    ██       ██   ██    ██    ██          ██   ██ ██    ██ ██      ██ ██      ██ ██      ██      
# █████     ████   ██    ██    ██   ███ ███████    ██    █████       ██████  ██    ██ ██      ██ ██      ██ █████   ███████ 
# ██  ██     ██     ██  ██     ██    ██ ██   ██    ██    ██          ██      ██    ██ ██      ██ ██      ██ ██           ██ 
# ██   ██    ██      ████   ▄█  ██████  ██   ██    ██    ███████     ██       ██████  ███████ ██  ██████ ██ ███████ ███████ 
                                                                                                                          

{{- if index .reducers "distributionModulesPolicyGatekeeperInstallDefaultPolicies" }}

deleteGatekeeperDefaultPolicies() {
  $kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/rules/constraints | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/rules/config | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/opa/katalog/gatekeeper/rules/templates | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  echo "Gatekeeper default policies resources deleted"
}

# from enabled
{{- if .reducers.distributionModulesPolicyGatekeeperInstallDefaultPolicies.from }}
# to disabled
{{- if not .reducers.distributionModulesPolicyGatekeeperInstallDefaultPolicies.to }}
# changing from true to false -> delete the policies
deleteGatekeeperDefaultPolicies
{{- end }}
{{- end }}

{{- end }} # end distributionModulesPolicyGatekeeperInstallDefaultPolicies

{{- if index .reducers "distributionModulesPolicyKyvernoInstallDefaultPolicies" }}

deleteKyvernoDefaultPolicies() {
  $kustomizebin build $vendorPath/modules/opa/katalog/kyverno/policies | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  echo "Kyverno default policies resources deleted"
}

# from enabled
{{- if .reducers.distributionModulesPolicyKyvernoInstallDefaultPolicies.from }}
# to disabled
{{- if not .reducers.distributionModulesPolicyKyvernoInstallDefaultPolicies.to }}
# changing from true to false -> delete the policies
deleteKyvernoDefaultPolicies
{{- end }}
{{- end }}

{{- end }} # end distributionModulesPolicyKyvernoInstallDefaultPolicies

# ████████ ██████   █████   ██████ ██ ███    ██  ██████      ████████ ██    ██ ██████  ███████ 
#    ██    ██   ██ ██   ██ ██      ██ ████   ██ ██              ██     ██  ██  ██   ██ ██      
#    ██    ██████  ███████ ██      ██ ██ ██  ██ ██   ███        ██      ████   ██████  █████   
#    ██    ██   ██ ██   ██ ██      ██ ██  ██ ██ ██    ██        ██       ██    ██      ██      
#    ██    ██   ██ ██   ██  ██████ ██ ██   ████  ██████         ██       ██    ██      ███████ 

{{- if index .reducers "distributionModulesTracingType" }}

deleteTempo() {

  $kustomizebin build $vendorPath/modules/tracing/katalog/minio-ha > delete-tracing-minio-ha.yaml
  $kustomizebin build $vendorPath/modules/tracing/katalog/tempo-distributed > delete-tracing-tempo-distributed.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-tracing-minio-ha.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-tracing-minio-ha-filtered.yaml
    cp delete-tracing-minio-ha-filtered.yaml delete-tracing-minio-ha.yaml
    cat delete-tracing-tempo-distributed.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-tracing-tempo-distributed-filtered.yaml
    cp delete-tracing-tempo-distributed-filtered.yaml delete-tracing-tempo-distributed.yaml
  fi
{{- end }}
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-tracing-minio-ha.yaml
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-tracing-tempo-distributed.yaml
  echo "Tempo resources deleted"
}

{{- if eq .reducers.distributionModulesTracingType.to "none" }}

{{- if eq .reducers.distributionModulesTracingType.from "tempo" }}
deleteTempo
{{- end }}

{{- end }}


{{- end }} # end distributionModulesTracingType

# ████████ ███████ ███    ███ ██████   ██████      ██████   █████   ██████ ██   ██ ███████ ███    ██ ██████  
#    ██    ██      ████  ████ ██   ██ ██    ██     ██   ██ ██   ██ ██      ██  ██  ██      ████   ██ ██   ██ 
#    ██    █████   ██ ████ ██ ██████  ██    ██     ██████  ███████ ██      █████   █████   ██ ██  ██ ██   ██ 
#    ██    ██      ██  ██  ██ ██      ██    ██     ██   ██ ██   ██ ██      ██  ██  ██      ██  ██ ██ ██   ██ 
#    ██    ███████ ██      ██ ██       ██████      ██████  ██   ██  ██████ ██   ██ ███████ ██   ████ ██████  
                                                                                                           
{{- if index .reducers "distributionModulesTracingTempoBackend" }}

deleteTracingMinioHA() {

  $kustomizebin build $vendorPath/modules/tracing/katalog/minio-ha > delete-tracing-minio-ha.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-tracing-minio-ha.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-tracing-minio-ha-filtered.yaml
    cp delete-tracing-minio-ha-filtered.yaml delete-tracing-minio-ha.yaml
  fi
{{- end }}
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-tracing-minio-ha.yaml
  echo "Minio HA on tracing namespace deleted"
}

{{- if eq .reducers.distributionModulesTracingTempoBackend.to "externalEndpoint" }}

deleteTracingMinioHA

{{- end }}

{{- end }} # end distributionModulesTracingTempoBackend

# ██████  ██████      ████████ ██    ██ ██████  ███████ 
# ██   ██ ██   ██        ██     ██  ██  ██   ██ ██      
# ██   ██ ██████         ██      ████   ██████  █████   
# ██   ██ ██   ██        ██       ██    ██      ██      
# ██████  ██   ██        ██       ██    ██      ███████ 
                                                                                             
{{- if index .reducers "distributionModulesDRType" }}

deleteVelero() {

  $kustomizebin build $vendorPath/modules/dr/katalog/velero/velero-node-agent | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/dr/katalog/velero/velero-schedules | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  # on prem can be used to delete also the eks one, since it has more manifests and we are using --ignore-not-found
  $kustomizebin build $vendorPath/modules/dr/katalog/velero/velero-on-prem > delete-velero.yaml

{{- if eq .spec.distribution.modules.dr.type "none" }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-velero.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-velero-filtered.yaml
    cp delete-velero-filtered.yaml delete-velero.yaml
  fi
{{- end }}

< delete-velero.yaml $yqbin 'select(.kind != "CustomResourceDefinition")' | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
< delete-velero.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  echo "Velero resources deleted"

}

{{- if eq .reducers.distributionModulesDRType.to "none" }}

{{- if eq .reducers.distributionModulesDRType.from "on-premises" }}
deleteVelero
{{- end }}

{{- if eq .reducers.distributionModulesDRType.from "eks" }}
deleteVelero
{{- end }}

{{- end }}

{{- end }} # end distributionModulesDRType

# ██    ██ ███████ ██      ███████ ██████   ██████      ██████   █████   ██████ ██   ██ ███████ ███    ██ ██████  
# ██    ██ ██      ██      ██      ██   ██ ██    ██     ██   ██ ██   ██ ██      ██  ██  ██      ████   ██ ██   ██ 
# ██    ██ █████   ██      █████   ██████  ██    ██     ██████  ███████ ██      █████   █████   ██ ██  ██ ██   ██ 
#  ██  ██  ██      ██      ██      ██   ██ ██    ██     ██   ██ ██   ██ ██      ██  ██  ██      ██  ██ ██ ██   ██ 
#   ████   ███████ ███████ ███████ ██   ██  ██████      ██████  ██   ██  ██████ ██   ██ ███████ ██   ████ ██████  
                                                                                                                

{{- if index .reducers "distributionModulesDRVeleroBackend" }}

deleteVeleroMinio() {

  $kustomizebin build $vendorPath/modules/dr/katalog/velero/velero-on-prem/minio > delete-dr-minio.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-dr-minio.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-dr-minio-filtered.yaml
    cp delete-dr-minio-filtered.yaml delete-dr-minio.yaml 
  fi
{{- end }}
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-dr-minio.yaml 
  echo "Minio on kube-system namespace deleted"
}

{{- if eq .reducers.distributionModulesDRVeleroBackend.to "externalEndpoint" }}

deleteVeleroMinio

{{- end }}

{{- end }} # end distributionModulesDRVeleroBackend

{{- if index .reducers "distributionModulesMonitoringType" }}


# ███    ███  ██████  ███    ██ ██ ████████  ██████  ██████  ██ ███    ██  ██████      ████████ ██    ██ ██████  ███████ 
# ████  ████ ██    ██ ████   ██ ██    ██    ██    ██ ██   ██ ██ ████   ██ ██              ██     ██  ██  ██   ██ ██      
# ██ ████ ██ ██    ██ ██ ██  ██ ██    ██    ██    ██ ██████  ██ ██ ██  ██ ██   ███        ██      ████   ██████  █████   
# ██  ██  ██ ██    ██ ██  ██ ██ ██    ██    ██    ██ ██   ██ ██ ██  ██ ██ ██    ██        ██       ██    ██      ██      
# ██      ██  ██████  ██   ████ ██    ██     ██████  ██   ██ ██ ██   ████  ██████         ██       ██    ██      ███████ 

deleteMonitoringCommon() {
  # packages that are installed always when monitoring type!=none, so they always
  # need to be uninstalled.
  # delete alertmanager first to avoid false positive alerts and notifications.
  $kustomizebin build $vendorPath/modules/monitoring/katalog/alertmanager-operated | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/monitoring/katalog/blackbox-exporter | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/monitoring/katalog/eks-sm | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/monitoring/katalog/grafana | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/monitoring/katalog/kube-proxy-metrics | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/monitoring/katalog/kube-state-metrics | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/monitoring/katalog/node-exporter | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/monitoring/katalog/x509-exporter | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  $kustomizebin build $vendorPath/modules/monitoring/katalog/prometheus-adapter | $kubectlbin delete --ignore-not-found --wait --timeout=180s -f -
  echo "Monitoring common resources deleted."
}

deletePrometheusOperator() {
  $kustomizebin build $vendorPath/modules/monitoring/katalog/prometheus-operator | $kubectlbin delete --ignore-not-found --wait --timeout=360s -f -
  echo "Prometheus Operator resources deleted"
}

deletePrometheusOperated() {
  # we first delete the CRs before deleting the CRDs to avoid the `kubectl delete` command from failing due to unexisting APIs.
  $kustomizebin build $vendorPath/modules/monitoring/katalog/prometheus-operated | $kubectlbin delete --ignore-not-found --wait --timeout=360s -f -
  $kubectlbin delete -l app.kubernetes.io/name=prometheus,app.kubernetes.io/instance=k8s pvc -n monitoring --wait --timeout=360s
  echo "Prometheus Operated resources deleted"
}

deleteMimir() {
  $kustomizebin build $vendorPath/modules/monitoring/katalog/mimir | $kubectlbin delete --ignore-not-found --wait --timeout=360s -f -
  $kustomizebin build $vendorPath/modules/monitoring/katalog/minio-ha | $kubectlbin delete --ignore-not-found --wait --timeout=360s -f -
  $kubectlbin delete -l app.kubernetes.io/name=mimir pvc -n monitoring --wait --timeout=360s
  $kubectlbin delete -l app=minio,release=minio-monitoring pvc -n monitoring --wait --timeout=360s
  echo "Mimir resources deleted"
}

{{- if eq .reducers.distributionModulesMonitoringType.from "mimir" }}
  {{- if eq .reducers.distributionModulesMonitoringType.to "none" }}
  deleteMonitoringCommon
  deleteMimir
  # we delete the operator package last because it includes the CRDs. If we
  # delete first the CRDs, then the subsequent `kubectl delete` commands will
  # fail because they'll try to use APIs that don't exist anymore.
  # prometheus-operator includes also the namespace, so it will be deleted with
  # all the remaining resources like configmaps and secrets that may remain.
  deletePrometheusOperator
  echo "Monitoring module resources deleted"
  {{- end }}
{{- end }}

{{- if eq .reducers.distributionModulesMonitoringType.from "prometheus" }}
  {{- if eq .reducers.distributionModulesMonitoringType.to "none" }}
  deleteMonitoringCommon
  deletePrometheusOperated
  deletePrometheusOperator
  echo "Monitoring module resources deleted"
  {{- end }}
{{- end }}

{{- end }} # end distributionModulesMonitoringType

# ███    ███ ██ ███    ███ ██ ██████      ██████   █████   ██████ ██   ██ ███████ ███    ██ ██████  
# ████  ████ ██ ████  ████ ██ ██   ██     ██   ██ ██   ██ ██      ██  ██  ██      ████   ██ ██   ██ 
# ██ ████ ██ ██ ██ ████ ██ ██ ██████      ██████  ███████ ██      █████   █████   ██ ██  ██ ██   ██ 
# ██  ██  ██ ██ ██  ██  ██ ██ ██   ██     ██   ██ ██   ██ ██      ██  ██  ██      ██  ██ ██ ██   ██ 
# ██      ██ ██ ██      ██ ██ ██   ██     ██████  ██   ██  ██████ ██   ██ ███████ ██   ████ ██████  
                                                                                                                                  
{{- if index .reducers "distributionModulesMonitoringMimirBackend" }}

deleteMimirMinioHA() {

  $kustomizebin build $vendorPath/modules/monitoring/katalog/minio-ha > delete-monitoring-minio-ha.yaml

{{- if or (eq .spec.distribution.modules.monitoring.type "none") (eq .storedCfg.spec.distribution.modules.monitoring.type "none") }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-monitoring-minio-ha.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-monitoring-minio-ha-filtered.yaml
    cp delete-monitoring-minio-ha-filtered.yaml delete-monitoring-minio-ha.yaml
  fi
{{- end }}
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-monitoring-minio-ha.yaml
  echo "Minio HA on monitoring namespace deleted"
}

{{- if eq .reducers.distributionModulesMonitoringMimirBackend.to "externalEndpoint" }}

deleteMimirMinioHA

{{- end }}

{{- end }} # end distributionModulesDRVeleroBackend

# ███    ██  ██████  ██ ███    ██ ██   ██     ████████ ██    ██ ██████  ███████ 
# ████   ██ ██       ██ ████   ██  ██ ██         ██     ██  ██  ██   ██ ██      
# ██ ██  ██ ██   ███ ██ ██ ██  ██   ███          ██      ████   ██████  █████   
# ██  ██ ██ ██    ██ ██ ██  ██ ██  ██ ██         ██       ██    ██      ██      
# ██   ████  ██████  ██ ██   ████ ██   ██        ██       ██    ██      ███████ 

{{- if index .reducers "distributionModulesIngressNginxType" }}

deleteNginx() {

  $kustomizebin build $vendorPath/modules/ingress/katalog/nginx > delete-nginx.yaml
  $kustomizebin build $vendorPath/modules/ingress/katalog/dual-nginx > delete-dual-nginx.yaml
  $kustomizebin build $vendorPath/modules/ingress/katalog/external-dns/public > delete-external-dns.yaml
  $kustomizebin build $vendorPath/modules/ingress/katalog/external-dns/private >> delete-external-dns.yaml
  $kustomizebin build $vendorPath/modules/ingress/katalog/forecastle > delete-forecastle.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-nginx.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-nginx-filtered.yaml
    cp delete-nginx-filtered.yaml delete-nginx.yaml
    cat delete-dual-nginx.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-dual-nginx-filtered.yaml
    cp delete-dual-nginx-filtered.yaml delete-dual-nginx.yaml
    cat delete-external-dns.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-external-dns-filtered.yaml
    cp delete-external-dns-filtered.yaml delete-external-dns.yaml
    cat delete-forecastle.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-forecastle-filtered.yaml
    cp delete-forecastle-filtered.yaml delete-forecastle.yaml
  fi
{{- end }}
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-external-dns.yaml
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-forecastle.yaml
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-dual-nginx.yaml
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-nginx.yaml
  echo "nginx or dual nginx have been deleted from the cluster"
}

deleteNginxIngresses() {
  
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n pomerium --all
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n monitoring --all
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n tracing --all
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n logging --all
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n gatekeeper-system --all
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n ingress-nginx --all
  echo "All the infrastructural ingresses associated with nginx have been deleted"
}

{{- if eq .reducers.distributionModulesIngressNginxType.to "none" }}
deleteNginxIngresses
deleteNginx
{{- end }}

{{- end }} # end distributionModulesIngressNginxType                                                                        

#  █████  ██    ██ ████████ ██   ██     ████████ ██    ██ ██████  ███████ 
# ██   ██ ██    ██    ██    ██   ██        ██     ██  ██  ██   ██ ██      
# ███████ ██    ██    ██    ███████        ██      ████   ██████  █████   
# ██   ██ ██    ██    ██    ██   ██        ██       ██    ██      ██      
# ██   ██  ██████     ██    ██   ██        ██       ██    ██      ███████ 

{{- if index .reducers "distributionModulesAuthProviderType" }}

deleteDex() {

  $kustomizebin build $vendorPath/modules/auth/katalog/dex > delete-dex.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-dex.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-dex-filtered.yaml
    cp delete-dex-filtered.yaml delete-dex.yaml
    
  fi
{{- end }}
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-dex.yaml
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n kube-system dex
  echo "dex has been deleted from the cluster"
}

deleteGangway() {

  $kustomizebin build $vendorPath/modules/auth/katalog/gangway > delete-gangway.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-gangway.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-gangway-filtered.yaml
    cp delete-gangway-filtered.yaml delete-pomerium.yaml
    
  fi
{{- end }}
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-gangway.yaml
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n kube-system gangway
  echo "dex has been deleted from the cluster"
}

deletePomerium() {

  $kustomizebin build $vendorPath/modules/auth/katalog/pomerium > delete-pomerium.yaml

{{- if eq .spec.distribution.modules.monitoring.type "none" }}
  if ! $kubectlbin get apiservice v1.monitoring.coreos.com; then
    cat delete-pomerium.yaml | $yqbin 'select(.apiVersion != "monitoring.coreos.com/v1")' > delete-pomerium-filtered.yaml
    cp delete-pomerium-filtered.yaml delete-pomerium.yaml
    
  fi
{{- end }}
  $kubectlbin delete --ignore-not-found --wait --timeout=180s -f delete-pomerium.yaml
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n pomerium pomerium
  echo "pomerium has been deleted from the cluster"
}

deletePomeriumIngresses() {
  
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n pomerium --all
  echo "All the ingresses in the pomerium namespace have been deleted"
}

deleteInfraIngresses() {
  
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n monitoring --all
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n tracing --all
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n logging --all
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n gatekeeper-system --all
  $kubectlbin delete --ignore-not-found --wait --timeout=180s ingress -n ingress-nginx --all
  echo "All the infrastructural ingresses have been deleted"
}


{{- if eq .reducers.distributionModulesAuthProviderType.to "none" }}

deleteDex
deleteGangway
deletePomeriumIngresses
deletePomerium

{{- end }}

{{- if eq .reducers.distributionModulesAuthProviderType.to "sso" }}

{{- if eq .reducers.distributionModulesAuthProviderType.from "basicAuth" }}
deleteDex
deleteGangway
deletePomeriumIngresses
deletePomerium
{{- end }}

{{- end }}

{{- if eq .reducers.distributionModulesAuthProviderType.to "sso" }}

{{- if eq .reducers.distributionModulesAuthProviderType.from "basicAuth" }}
deleteDex
deleteGangway
deleteInfraIngresses
deletePomerium
{{- end }}

{{- end }}

{{- end }} # end distributionModulesAuthProviderType                                                      


# ███████ ███    ██ ██████  
# ██      ████   ██ ██   ██ 
# █████   ██ ██  ██ ██   ██ 
# ██      ██  ██ ██ ██   ██ 
# ███████ ██   ████ ██████  

{{- end }} # end reducers
