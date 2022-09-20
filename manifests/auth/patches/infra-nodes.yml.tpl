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
        {{ if .modules.auth.overrides.nodeSelector }}
          {{ .modules.auth.overrides.nodeSelector | toYaml | indent 8 }}
        {{ else }}
          {{ .common.nodeSelector | toYaml |indent 8 }}
        {{ end }}
      tolerations:
        {{ if .modules.auth.overrides.tolerations }}
          {{ .modules.auth.overrides.tolerations | toYaml | indent 8 }}
        {{ else }}
          {{ .common.tolerations | toYaml | indent 8 }}
        {{ end }}
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
        {{ if .modules.auth.overrides.nodeSelector }}
          {{ .modules.auth.overrides.nodeSelector | toYaml | indent 8 }}
        {{ else }}
          {{ .common.nodeSelector | toYaml | indent 8 }}
        {{ end }}
      tolerations:
        {{ if .modules.auth.overrides.tolerations }}
          {{ .modules.auth.overrides.tolerations | toYaml | indent 8 }}
        {{ else }}
          {{ .common.tolerations | toYaml | indent 8 }}
        {{ end }}
