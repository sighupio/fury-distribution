# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

{{- if eq .spec.distribution.modules.auth.provider.type "sso" }}
resources:
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/auth/katalog/dex" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/auth/katalog/pomerium" }}
{{- if .spec.distribution.modules.auth.oidcKubernetesAuth.enabled }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/auth/katalog/gangway" }}
{{- end }}
{{- if ne .spec.distribution.modules.ingress.nginx.type "none" }}
  - resources/ingress-infra.yml
{{- end }}

patchesStrategicMerge:
  - patches/infra-nodes.yml
  - patches/pomerium-ingress.yml

configMapGenerator:
  - name: pomerium
    behavior: replace
    envs:
      - resources/pomerium-config.env
  - name: pomerium-policy
    behavior: replace
    files:
      - policy.yml=resources/pomerium-policy.yml

secretGenerator:
  - name: dex
    namespace: kube-system
    files:
      - config.yml=secrets/dex.yml
  - name: pomerium-env
    behavior: replace
    envs:
      - secrets/pomerium.env
{{- if .spec.distribution.modules.auth.oidcKubernetesAuth.enabled }}
  - name: gangway
    namespace: kube-system
    files:
      - gangway.yml=secrets/gangway.yml
{{- end }}
{{- end }}



{{- if eq .spec.distribution.modules.auth.provider.type "basicAuth" }}

resources:
  - secrets/basic-auth.yml
{{- if .spec.distribution.modules.auth.oidcKubernetesAuth.enabled }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/auth/katalog/dex" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/auth/katalog/gangway" }}
  - resources/ingress-infra.yml
{{- end }}

{{- if .spec.distribution.modules.auth.oidcKubernetesAuth.enabled }}
secretGenerator:
  - name: dex
    namespace: kube-system
    files:
      - config.yml=secrets/dex.yml
  - name: gangway
    namespace: kube-system
    files:
      - gangway.yml=secrets/gangway.yml

patchesStrategicMerge:
  - patches/infra-nodes.yml
{{- end }}

{{- end }}

{{- if eq .spec.distribution.modules.auth.provider.type "none" }}

{{- if .spec.distribution.modules.auth.oidcKubernetesAuth.enabled }}
resources:
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/auth/katalog/dex" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/auth/katalog/gangway" }}
  - resources/ingress-infra.yml
{{- end }}

{{- if .spec.distribution.modules.auth.oidcKubernetesAuth.enabled }}
secretGenerator:
  - name: dex
    namespace: kube-system
    files:
      - config.yml=secrets/dex.yml
  - name: gangway
    namespace: kube-system
    files:
      - gangway.yml=secrets/gangway.yml

patchesStrategicMerge:
  - patches/infra-nodes.yml
{{- end }}

{{- end }}


