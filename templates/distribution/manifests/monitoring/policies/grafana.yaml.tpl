# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- $monitoringType := .spec.distribution.modules.monitoring.type }}

# source: https://github.com/prometheus-operator/kube-prometheus/blob/main/manifests/grafana-networkPolicy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: grafana
  namespace: monitoring
  labels:
    cluster.kfd.sighup.io/module: monitoring
spec:
  egress:
  - {}
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: prometheus
    ports:
    - port: 3000
      protocol: TCP
  podSelector:
    matchLabels:
      app.kubernetes.io/component: grafana
      app.kubernetes.io/name: grafana
      app.kubernetes.io/part-of: kube-prometheus
  policyTypes:
  - Egress
  - Ingress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: grafana-egress-tempo-gateway
  namespace: monitoring
  labels:
    cluster.kfd.sighup.io/module: monitoring
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: grafana
  egress:
    - to:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: tracing
          podSelector:
            matchLabels:
              app.kubernetes.io/name: tempo
              app.kubernetes.io/component: gateway
      ports:
        - port: 8080
          protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: grafana-ingress-nginx
  namespace: monitoring
  labels:
    cluster.kfd.sighup.io/module: monitoring
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
