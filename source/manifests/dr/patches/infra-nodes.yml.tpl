{{- define "nodeSelector" -}}
  {{ if .modules.dr.overrides.nodeSelector -}}
    {{ .modules.dr.overrides.nodeSelector | toYaml | indent 8 | trim }}
  {{- else -}}
    {{ template "commonNodeSelector" . }}
  {{- end }}
{{- end -}}
{{- define "tolerations" -}}
  {{ if .modules.dr.overrides.tolerations -}}
    {{ .modules.dr.overrides.tolerations | toYaml | indent 8 | trim }}
  {{- else -}}
    {{ template "commonTolerations" . }}
  {{- end }}
{{- end -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: velero
  namespace: kube-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
