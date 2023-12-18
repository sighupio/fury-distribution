# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/tracing/katalog/tempo-distributed" }}
{{- if eq .spec.distribution.modules.tracing.tempo.backend "minio" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/tracing/katalog/minio-ha" }}
{{- end }}
{{- if ne .spec.distribution.modules.ingress.nginx.type "none" }}
  - resources/ingress-infra.yml
{{- end }}

patchesStrategicMerge:
  - patches/infra-nodes.yml
{{- if eq .spec.distribution.modules.tracing.tempo.backend "minio" }}
  - patches/minio.yml
{{- end }}

configMapGenerator:
  - name: tempo-distributed-config
    namespace: tracing
    behavior: merge
    files:
      - patches/tempo.yaml

secretGenerator:
  - name: minio-tracing
    namespace: tracing
    behavior: replace
    envs:
      - patches/minio.root.env