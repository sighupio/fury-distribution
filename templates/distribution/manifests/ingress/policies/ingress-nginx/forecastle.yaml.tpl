# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: forecastle-ingress-nginx
  namespace: ingress-nginx
  labels:
    cluster.kfd.sighup.io/ingress-type: nginx
spec:
  podSelector:
    matchLabels:
      app: forecastle
  policyTypes:
    - Ingress
  ingress:
    - from:
      - namespaceSelector:
{{- if (eq .spec.distribution.modules.auth.provider.type "sso") }}
          matchLabels:
            kubernetes.io/metadata.name: pomerium
{{ else }}
          matchLabels:
            kubernetes.io/metadata.name: ingress-nginx
{{- end }}
        podSelector:
          matchLabels:
{{- if (eq .spec.distribution.modules.auth.provider.type "sso") }}
            app: pomerium
{{- else if eq .spec.distribution.modules.ingress.nginx.type "dual" }}
            app: ingress
{{- else if eq .spec.distribution.modules.ingress.nginx.type "single" }}
            app: ingress-nginx
{{- end }}
      ports:
        - port: 3000
          protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: forecastle-egress-kube-apiserver
  namespace: ingress-nginx
  labels:
    cluster.kfd.sighup.io/ingress-type: nginx
spec:
  podSelector:
    matchLabels:
      app: forecastle
  policyTypes:
    - Egress
  egress:
  - ports:
    - port: 6443
      protocol: TCP