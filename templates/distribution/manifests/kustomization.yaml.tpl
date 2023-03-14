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
  
{{- if .spec.distribution.customPatches.patchesStrategicMerge }}
patchesStrategicMerge: 
  {{- "\n"}}{{- .spec.distribution.customPatches.patchesStrategicMerge | toYaml}}
{{- end }}

{{- if .spec.distribution.customPatches.patches }}
patches: 
  {{- "\n"}}{{- .spec.distribution.customPatches.patches | toYaml}}
{{- end }}

{{- if .spec.distribution.customPatches.secretsGenerator }}
secretsGenerator:
  {{- "\n"}}{{- .spec.distribution.customPatches.secretsGenerator | toYaml}}
{{- end }}

{{- if .spec.distribution.customPatches.configMapGenerator }}
configMapGenerator:
  {{- "\n"}}{{- .spec.distribution.customPatches.configMapGenerator | toYaml}}
{{- end }}
