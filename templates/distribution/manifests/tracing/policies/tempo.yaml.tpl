apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: tempo-distributed-discovery
  namespace: tracing
  labels:
    app.kubernetes.io/name: tempo
spec:
  policyTypes:
    - Ingress
    - Egress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: tempo
  ingress:
    - ports:
        - port: 9095
          protocol: TCP
        - port: 7946
          protocol: TCP
      from:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: tracing
          podSelector:
            matchLabels:
              app.kubernetes.io/name: tempo
  egress:
    - ports:
        - port: 9095
          protocol: TCP
        - port: 7946
          protocol: TCP
      to:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: tracing
          podSelector:
            matchLabels:
              app.kubernetes.io/name: tempo
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: tempo-distributed-ingress-prometheus-metrics
  namespace: tracing
  labels:
    app.kubernetes.io/name: tempo
spec:
  policyTypes:
    - Ingress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: tempo
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
{{- if eq .spec.distribution.modules.tracing.tempo.backend "minio" }}
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: tempo-distributed-egress-minio
  namespace: tracing
  labels:
    app.kubernetes.io/name: tempo
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: tempo
  egress:
    - to:
        - podSelector:
            matchLabels:
              app: minio
          namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: tracing
      ports:
          - port: 9000
            protocol: TCP
{{- end }}
