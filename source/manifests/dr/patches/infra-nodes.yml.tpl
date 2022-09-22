{{- define "nodeSelector" -}}
  {{ if ne .modules.dr.overrides.nodeSelector nil -}}
    {{ .modules.dr.overrides.nodeSelector | toYaml | indent 8 | trim }}
  {{- else -}}
    {{ template "commonNodeSelector" . }}
  {{- end }}
{{- end -}}
{{- define "tolerations" -}}
  {{ if ne .modules.dr.overrides.tolerations nil -}}
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
