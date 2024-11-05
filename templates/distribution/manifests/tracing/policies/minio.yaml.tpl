apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: minio-ingress-namespace
  namespace: tracing
  labels:
    app: minio
spec:
  policyTypes:
    - Ingress
    - Egress
  podSelector:
    matchLabels:
      app: minio
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: tracing
      ports:
      - port: 9000
        protocol: TCP
  egress:
    - to:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: tracing
          podSelector:
            matchLabels:
              app: minio
      ports:
      - port: 9000
        protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: minio-buckets-setup-egress-apiserver
  namespace: tracing
  labels:
    app: minio-tracing-buckets-setup
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app: minio-tracing-buckets-setup
  egress:
    - ports:
      - port: 6443
        protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: minio-buckets-setup-egress-minio
  namespace: tracing
  labels:
    app: minio-tracing-buckets-setup
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app: minio-tracing-buckets-setup
  egress:
    - ports:
      - port: 9000
        protocol: TCP
      to:
      - podSelector:
            matchLabels:
              app: minio
        namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: tracing
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: minio-ingress-prometheus-metrics
  namespace: tracing
  labels:
    app: minio
spec:
  policyTypes:
    - Ingress
  podSelector:
    matchLabels:
      app: minio
  ingress:
    - ports:
        - port: 9000
          protocol: TCP
      from:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: monitoring
          podSelector:
            matchLabels:
              app.kubernetes.io/name: prometheus
