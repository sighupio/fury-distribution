# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

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
{{- if ne .spec.distribution.common.provider.type "none" }}
  - networking
{{- end }}
  - opa

{{- if .spec.distribution.customPatches.patchesStrategicMerge }}
patchesStrategicMerge:
  {{ .spec.distribution.customPatches.patchesStrategicMerge | toYaml | indent 2 | trim -}}
{{- end }}

{{- if .spec.distribution.customPatches.patches }}
patches:
  {{ .spec.distribution.customPatches.patches | toYaml | indent 2 | trim -}}
{{- end }}

{{- if .spec.distribution.customPatches.secretGenerator }}
secretGenerator:
  {{ .spec.distribution.customPatches.secretGenerator | toYaml | indent 2 | trim -}}
{{- end }}

{{- if .spec.distribution.customPatches.configMapGenerator }}
configMapGenerator:
  {{ .spec.distribution.customPatches.configMapGenerator | toYaml | indent 2 | trim  -}}
{{- end }}
