# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: loki-distributed-ingress-fluentd
  namespace: logging
  labels:
    app.kubernetes.io/name: loki-distributed
spec:
  policyTypes:
    - Ingress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: loki-distributed
      app.kubernetes.io/component: gateway
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: logging
          podSelector:
            matchLabels:
              app.kubernetes.io/name: fluentd
      ports:
        - port: 8080
          protocol: TCP
        - port: 3100
          protocol: TCP

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: loki-distributed-ingress-prometheus-metrics
  namespace: logging
  labels:
    app.kubernetes.io/name: loki-distributed
spec:
  policyTypes:
    - Ingress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: loki-distributed
  ingress:
    - ports:
        - port: 3100
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
  name: loki-distributed-discovery
  namespace: logging
  labels:
    app.kubernetes.io/name: loki-distributed
spec:
  policyTypes:
    - Ingress
    - Egress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: loki-distributed
  ingress:
    - ports:
        - port: 9095
          protocol: TCP
        - port: 3100
          protocol: TCP
        - port: 7946
          protocol: TCP
      from:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: logging
          podSelector:
            matchLabels:
              app.kubernetes.io/name: loki-distributed
  egress:
    - ports:
        - port: 9095
          protocol: TCP
        - port: 3100
          protocol: TCP
        - port: 7946
          protocol: TCP
      to:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: logging
          podSelector:
            matchLabels:
              app.kubernetes.io/name: loki-distributed
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: loki-distributed-egress-minio
  namespace: logging
  labels:
    app.kubernetes.io/name: loki-distributed
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: loki-distributed
  egress:
    - to:
        - podSelector:
            matchLabels:
              app: minio
          namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: logging
      ports:
          - port: 9000
            protocol: TCP