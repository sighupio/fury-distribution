# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
{{- if eq .spec.distribution.common.provider.type "eks" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/networking/katalog/tigera/eks-policy-only" }}
{{- end }}

{{- if eq .spec.distribution.common.provider.type "none" }}
{{- if eq .spec.distribution.modules.networking.type "calico" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/networking/katalog/tigera/on-prem" }}
{{- end }}
{{- if eq .spec.distribution.modules.networking.type "cilium" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/networking/katalog/cilium" }}
{{- end }}
{{- end }}

patchesStrategicMerge:
{{- if eq .spec.distribution.common.provider.type "eks" }}
  - patches/infra-nodes-tigera.yaml
{{- end }}
{{- if eq .spec.distribution.common.provider.type "none" }}
{{- if eq .spec.distribution.modules.networking.type "calico" }}
  - patches/infra-nodes-tigera.yaml
{{- end }}
{{- if eq .spec.distribution.modules.networking.type "cilium" }}
  - patches/infra-nodes-distro-cilium.yaml
{{- end }}
{{- end }}

{{- if eq .spec.distribution.common.provider.type "none" }}
{{- if eq .spec.distribution.modules.networking.type "calico" }}

patchesJson6902:
  - target:
      group: apps
      version: v1
      kind: Deployment
      name: tigera-operator
      namespace: tigera-operator
    path: patchesjson/tigera-tolerations.yaml

{{- end }}
{{- end }}