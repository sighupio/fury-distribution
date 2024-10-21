# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- if eq .spec.distribution.modules.auth.provider.type "basicAuth" -}}
{{- $username := .spec.distribution.modules.auth.provider.basicAuth.username -}}
{{- $password := .spec.distribution.modules.auth.provider.basicAuth.password -}}

{{- if eq .spec.distribution.modules.policy.type "gatekeeper" }}
---
apiVersion: v1
kind: Secret
metadata:
  name: basic-auth
  namespace: gatekeeper-system
type: Opaque
stringData:
  auth: {{ htpasswd $username $password }}
{{- end }}
{{- if ne .spec.distribution.modules.ingress.nginx.type "none" }}
---
apiVersion: v1
kind: Secret
metadata:
  name: basic-auth
  namespace: ingress-nginx
type: Opaque
stringData:
  auth: {{ htpasswd $username $password }}
{{- end }}
{{- if ne .spec.distribution.modules.logging.type "none" }}
{{- if .checks.storageClassAvailable }}
---
apiVersion: v1
kind: Secret
metadata:
  name: basic-auth
  namespace: logging
type: Opaque
stringData:
  auth: {{ htpasswd $username $password }}
{{- end }}
{{- end }}
{{- if ne .spec.distribution.modules.monitoring.type "none" }}
---
apiVersion: v1
kind: Secret
metadata:
  name: basic-auth
  namespace: monitoring
type: Opaque
stringData:
  auth: {{ htpasswd $username $password }}
{{- end }}
{{ if eq .spec.distribution.modules.networking.type "cilium" }}
---
apiVersion: v1
kind: Secret
metadata:
  name: basic-auth
  namespace: kube-system
type: Opaque
stringData:
  auth: {{ htpasswd $username $password }}
{{- end }}
{{- end -}}
