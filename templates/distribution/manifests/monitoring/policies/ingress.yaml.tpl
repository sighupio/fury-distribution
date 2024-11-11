# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: grafana-ingress-nginxingresscontroller
  namespace: monitoring
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: grafana
      app.kubernetes.io/name: grafana
      app.kubernetes.io/part-of: kube-prometheus
  policyTypes:
    - Ingress
  ingress:
# single nginx, no sso
{{if and (eq .spec.distribution.modules.ingress.nginx.type "single") (ne .spec.distribution.modules.auth.provider.type "sso") }}
    - from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: ingress-nginx
        podSelector:
          matchLabels:
            app: ingress-nginx
# dual nginx, no sso
{{ else if and (eq .spec.distribution.modules.ingress.nginx.type "dual") (ne .spec.distribution.modules.auth.provider.type "sso") }}
    - from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: ingress-nginx
        podSelector:
          matchLabels:
            app: ingress
# sso
{{ else if (eq .spec.distribution.modules.auth.provider.type "sso") }}
    - from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: pomerium
        podSelector:
          matchLabels:
            app: pomerium
{{ end }}
      ports:
        - port: 3000
          protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: prometheus-ingress-nginxingresscontroller
  namespace: monitoring
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: prometheus
      app.kubernetes.io/instance: k8s
      app.kubernetes.io/name: prometheus
      app.kubernetes.io/part-of: kube-prometheus
  policyTypes:
    - Ingress
  ingress:
# single nginx, no sso
{{if and (eq .spec.distribution.modules.ingress.nginx.type "single") (ne .spec.distribution.modules.auth.provider.type "sso") }}
    - from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: ingress-nginx
        podSelector:
          matchLabels:
            app: ingress-nginx
# dual nginx, no sso
{{ else if and (eq .spec.distribution.modules.ingress.nginx.type "dual") (ne .spec.distribution.modules.auth.provider.type "sso") }}
    - from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: ingress-nginx
        podSelector:
          matchLabels:
            app: ingress
# sso
{{ else if (eq .spec.distribution.modules.auth.provider.type "sso") }}
    - from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: pomerium
        podSelector:
          matchLabels:
            app: pomerium
{{ end }}
      ports:
        - port: 9090
          protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: alertmanager-ingress-nginxingresscontroller
  namespace: monitoring
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: alert-router
      app.kubernetes.io/instance: main
      app.kubernetes.io/name: alertmanager
      app.kubernetes.io/part-of: kube-prometheus
  policyTypes:
    - Ingress
  ingress:
# single nginx, no sso
{{if and (eq .spec.distribution.modules.ingress.nginx.type "single") (ne .spec.distribution.modules.auth.provider.type "sso") }}
    - from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: ingress-nginx
        podSelector:
          matchLabels:
            app: ingress-nginx
# dual nginx, no sso
{{ else if and (eq .spec.distribution.modules.ingress.nginx.type "dual") (ne .spec.distribution.modules.auth.provider.type "sso") }}
    - from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: ingress-nginx
        podSelector:
          matchLabels:
            app: ingress
# sso
{{ else if (eq .spec.distribution.modules.auth.provider.type "sso") }}
    - from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: pomerium
        podSelector:
          matchLabels:
            app: pomerium
{{ end }}
      ports:
        - port: 9093
          protocol: TCP
---
