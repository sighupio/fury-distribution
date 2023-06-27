# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/opa/katalog/gatekeeper/core" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/opa/katalog/gatekeeper/gpm" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/opa/katalog/gatekeeper/rules" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/opa/katalog/gatekeeper/monitoring" }}
{{- if ne .spec.distribution.modules.ingress.nginx.type "none" }}
  - resources/ingress-infra.yml
{{- end }}

patchesStrategicMerge:
  - patches/infra-nodes.yml

{{ if .spec.distribution.modules.policy.gatekeeper.additionalExcludedNamespaces }}
patchesJson6902:
  - target:
      group: config.gatekeeper.sh
      version: v1alpha1
      kind: Config
      name: config
    path: patches/gatekeeper-whitelist-namespace.yml
{{ end }}
