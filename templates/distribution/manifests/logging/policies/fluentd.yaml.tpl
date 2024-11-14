# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fluentd-ingress-fluentbit
  namespace: logging
  labels:
    cluster.kfd.sighup.io/module: logging
spec:
  policyTypes:
    - Ingress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: fluentd
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app.kubernetes.io/name: fluentbit
          namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: logging
      ports:
          - port: 24240
            protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fluentd-egress-minio
  namespace: logging
  labels:
    cluster.kfd.sighup.io/module: logging
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: fluentd
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
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fluentd-ingress-prometheus-metrics
  namespace: logging
  labels:
    cluster.kfd.sighup.io/module: logging
spec:
  policyTypes:
    - Ingress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: fluentd
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app.kubernetes.io/name: prometheus
          namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: monitoring
      ports:
          - port: 24231
            protocol: TCP
---
{{- if eq .spec.distribution.modules.logging.type "opensearch" }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fluentd-egress-opensearch
  namespace: logging
  labels:
    cluster.kfd.sighup.io/module: logging
    cluster.kfd.sighup.io/logging-type: opensearch
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: fluentd
  egress:
    - to:
        - podSelector:
            matchLabels:
              app.kubernetes.io/name: opensearch
      ports:
          - port: 9200
            protocol: TCP
---
{{- end }}
{{- if eq .spec.distribution.modules.logging.type "loki" }}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: fluentd-egress-loki
  namespace: logging
  labels:
    cluster.kfd.sighup.io/module: logging
    cluster.kfd.sighup.io/logging-type: loki
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: fluentd
  egress:
    - to:
        - podSelector:
            matchLabels:
              app.kubernetes.io/name: loki-distributed
              app.kubernetes.io/component: gateway
      ports:
          - port: 8080
            protocol: TCP
---
{{- end }}
