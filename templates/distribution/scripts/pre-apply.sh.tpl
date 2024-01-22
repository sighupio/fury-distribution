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

{{- if eq .reducers.distributionModulesTracingTempoBackend.from "minio" }}
deleteTracingMinioHA
{{- end }}

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

{{- if eq .reducers.distributionModulesDRVeleroBackend.from "minio" }}
deleteVeleroMinio
{{- end }}

{{- end }}

{{- end }} # end distributionModulesDRVeleroBackend


# ███████ ███    ██ ██████  
# ██      ████   ██ ██   ██ 
# █████   ██ ██  ██ ██   ██ 
# ██      ██  ██ ██ ██   ██ 
# ███████ ██   ████ ██████  

{{- end }} # end reducers
