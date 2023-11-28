# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/tracing/katalog/tempo-distributed" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/tracing/katalog/minio-ha" }}
{{- if ne .spec.distribution.modules.ingress.nginx.type "none" }}
  - resources/ingress-infra.yml
{{- end }}

patchesStrategicMerge:
  - patches/infra-nodes.yml
  - patches/minio.yml

