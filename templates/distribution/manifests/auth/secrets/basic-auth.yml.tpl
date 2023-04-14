# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- if eq .spec.distribution.modules.auth.provider.type "basicAuth" -}}
{{- $username := .spec.distribution.modules.auth.provider.basicAuth.username -}}
{{- $password := .spec.distribution.modules.auth.provider.basicAuth.password -}}
{{- $namespaces := list "gatekeeper-system" "ingress-nginx" "logging" "monitoring" -}}
{{ range $namespace := $namespaces -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: basic-auth
  namespace: {{ $namespace }}
type: Opaque
stringData:
  auth: {{ htpasswd $username $password }}
{{ end }}
{{- end -}}
