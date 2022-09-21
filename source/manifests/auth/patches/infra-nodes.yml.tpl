{{- define "nodeSelector" -}}
  {{ if .modules.auth.overrides.nodeSelector -}}
    {{ .modules.auth.overrides.nodeSelector | toYaml | indent 8 | trim }}
  {{- else -}}
    {{ template "commonNodeSelector" . }}
  {{- end }}
{{- end -}}
{{- define "tolerations" -}}
  {{ if .modules.auth.overrides.tolerations -}}
    {{ .modules.auth.overrides.tolerations | toYaml | indent 8 | trim }}
  {{- else -}}
    {{ template "commonTolerations" . }}
  {{- end }}
{{- end -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dex
  namespace: kube-system
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
  name: pomerium
  namespace: pomerium
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
