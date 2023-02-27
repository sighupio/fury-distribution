---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
{{- if ne .spec.distribution.modules.auth.provider.type "none" }}
  - auth
{{- end }}
{{- if eq .spec.distribution.common.provider.type "eks" }}
  - aws
{{- end }}
  - dr
  - ingress
  - logging
  - monitoring
  - networking
  - opa
  
{{- if .spec.overrides.patchStrategicMerge }}
patchesStrategicMerge: {{ .spec.overrides.patchStrategicMerge }}
{{- end }}

{{- if .spec.overrides.patchesJson6902 }}
patchesJson6902: {{ .spec.overrides.patchesJson6902 }}
{{- end }}

{{- if .spec.overrides.secretGenerator }}
secretGenerator: {{ .spec.overrides.secretGenerator }}
{{- end }}

{{- if .spec.overrides.secretGenerator }}
configGenerator: {{ .spec.overrides.secretGenerator }}
{{- end }}
