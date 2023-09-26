# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
{{- if or (ne .spec.distribution.modules.auth.provider.type "none") .spec.distribution.modules.auth.oidcKubernetesAuth.enabled -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  {{- if eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager" }}
  annotations:
    {{ template "certManagerClusterIssuer" . }}
  {{- end }}
  name: dex
  namespace: kube-system
spec:
  # Needs to be externally available in order to act as callback from GitHub.
  ingressClassName: {{ template "ingressClass" (dict "module" "auth" "package" "dex" "type" "external" "spec" .spec) }}
  rules:
    - host: {{ template "dexUrl" .spec }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: dex
                port:
                  name: http
{{- template "ingressTlsAuth" (dict "module" "auth" "package" "dex" "prefix" "login." "spec" .spec) }}
{{- end }}

{{- if .spec.distribution.modules.auth.oidcKubernetesAuth.enabled }}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  {{- if eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager" }}
  annotations:
    {{ template "certManagerClusterIssuer" . }}
  {{- end }}
  name: gangway
  namespace: kube-system
spec:
  # Needs to be externally available in order to act as callback from GitHub.
  ingressClassName: {{ template "ingressClass" (dict "module" "auth" "package" "gangway" "type" "external" "spec" .spec) }}
  rules:
    - host: {{ template "gangwayUrl" .spec }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: gangway-svc
                port:
                  name: http
{{- template "ingressTlsAuth" (dict "module" "auth" "package" "gangway" "prefix" "gangway." "spec" .spec) }}
{{- end }}