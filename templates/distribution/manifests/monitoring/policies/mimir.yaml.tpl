# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: mimir-distributed-ingress-prometheus-metrics
  namespace: monitoring
  labels:
    app.kubernetes.io/name: mimir
spec:
  policyTypes:
    - Ingress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: mimir
  ingress:
    - ports:
        - port: 8080
          protocol: TCP
      from:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: monitoring
          podSelector:
            matchLabels:
              app.kubernetes.io/name: prometheus

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: mimir-distributed-discovery
  namespace: monitoring
  labels:
    app.kubernetes.io/name: mimir
spec:
  policyTypes:
    - Ingress
    - Egress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: mimir
  ingress:
    - ports:
        - port: 9095
          protocol: TCP
        - port: 7946
          protocol: TCP
        - port: 8080
          protocol: TCP
      from:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: monitoring
          podSelector:
            matchLabels:
              app.kubernetes.io/name: mimir
  egress:
    - ports:
        - port: 9095
          protocol: TCP
        - port: 7946
          protocol: TCP
        - port: 8080
          protocol: TCP
      to:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: monitoring
          podSelector:
            matchLabels:
              app.kubernetes.io/name: mimir
{{- if eq .spec.distribution.modules.monitoring.mimir.backend "minio" }}
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: mimir-distributed-egress-minio
  namespace: monitoring
  labels:
    app.kubernetes.io/name: mimir
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: mimir
  egress:
    - to:
        - podSelector:
            matchLabels:
              app: minio
          namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: monitoring
      ports:
          - port: 9000
            protocol: TCP
{{- end }}
