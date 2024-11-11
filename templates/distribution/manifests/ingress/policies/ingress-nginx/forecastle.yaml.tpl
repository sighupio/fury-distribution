# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: forecastle-ingress-nginxingresscontroller
  namespace: ingress-nginx
spec:
  podSelector:
    matchLabels:
      app: forecastle
  policyTypes:
    - Ingress
  ingress:
    - from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: ingress-nginx
        podSelector:
          matchLabels:
{{- if eq .spec.distribution.modules.ingress.nginx.type "dual" }}
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
  name: forecastle-egress-kubeapiserver
  namespace: ingress-nginx
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