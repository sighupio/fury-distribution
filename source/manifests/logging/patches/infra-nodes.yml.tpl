{{- define "nodeSelector" -}}
  {{ $indent := 8 -}}
  {{ if hasKey . "indent" -}}
    {{ $indent = .indent -}}
  {{- end -}}
  {{ if ne .spec.distribution.modules.logging.overrides.nodeSelector nil -}}
    {{ .spec.distribution.modules.logging.overrides.nodeSelector | toYaml | indent $indent | trim }}
  {{- else -}}
    {{ template "commonNodeSelector" ( dict "spec" .spec "indent" $indent ) }}
  {{- end }}
{{- end -}}
{{- define "tolerations" -}}
  {{ $indent := 8 -}}
  {{ if hasKey . "indent" -}}
    {{ $indent = .indent -}}
  {{- end -}}
  {{ if ne .spec.distribution.modules.logging.overrides.tolerations nil -}}
    {{ .spec.distribution.modules.logging.overrides.tolerations | toYaml | indent $indent | trim }}
  {{- else -}}
    {{ template "commonTolerations" ( dict "spec" .spec "indent" $indent ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
---
apiVersion: logging.banzaicloud.io/v1beta1
kind: Logging
metadata:
  name: infra
spec:
  fluentd:
    nodeSelector:
      {{ template "nodeSelector" ( dict "spec" .spec ) }}
    tolerations:
      {{ template "tolerations" ( dict "spec" .spec "indent" 6 ) }}
