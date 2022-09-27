{{- define "nodeSelector" -}}
  {{ if ne .modules.monitoring.overrides.nodeSelector nil -}}
    {{ .modules.monitoring.overrides.nodeSelector | toYaml | indent 8 | trim }}
  {{- else -}}
    {{ template "commonNodeSelector" . }}
  {{- end }}
{{- end -}}
{{- define "tolerations" -}}
  {{ if ne .modules.monitoring.overrides.tolerations nil -}}
    {{ .modules.monitoring.overrides.tolerations | toYaml | indent 8 | trim }}
  {{- else -}}
    {{ template "commonTolerations" . }}
  {{- end }}
{{- end -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cerebro
  namespace: logging
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: opensearch-cluster-master
  namespace: logging
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: opensearch-dashboards
  namespace: logging
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: minio
  namespace: logging
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
---
apiVersion: logging.banzaicloud.io/v1beta1
kind: Logging
metadata:
  name: infra
spec:
  fluentd:
    nodeSelector:
      {{ template "nodeSelector" . }}
    tolerations:
      {{ template "tolerations" . }}
