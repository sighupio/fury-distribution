# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{ if eq .spec.distribution.modules.ingress.nginx.tls.provider "secret" -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: ingress-nginx-global-tls-cert
  namespace: ingress-nginx
type: kubernetes.io/tls
data:
  ca.crt: {{ .spec.distribution.modules.ingress.nginx.tls.secret.ca | b64enc }}
  tls.crt: {{ .spec.distribution.modules.ingress.nginx.tls.secret.cert | b64enc }}
  tls.key: {{ .spec.distribution.modules.ingress.nginx.tls.secret.key | b64enc }}
{{- end }}
