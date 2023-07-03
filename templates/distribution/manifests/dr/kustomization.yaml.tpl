# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
{{- if eq .spec.distribution.common.provider.type "eks" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/dr/katalog/velero/velero-aws" }}
{{- else if eq .spec.distribution.common.provider.type "none" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/dr/katalog/velero/velero-on-prem" }}
{{- end }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/dr/katalog/velero/velero-schedules" }}
{{- if eq .spec.distribution.common.provider.type "eks" }}
  - resources/eks-velero-backupstoragelocation.yml
  - resources/eks-velero-volumesnapshotlocation.yml
{{- end }}

patchesStrategicMerge:
  - patches/infra-nodes.yml
{{- if eq .spec.distribution.common.provider.type "eks" }}
  - patches/eks-velero.yml
{{- end }}
