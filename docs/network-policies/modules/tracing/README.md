# Tracing Module Network Policies

## Components
- Tempo

## Namespaces
- tracing

## Network Policies List
- deny-all
- all-egress-kube-dns
- tempo-distributed-discovery
- tempo-distributed-ingress-prometheus-metrics
- tempo-gateway-ingress-grafana
- all-egress-tempo-distributor
- tempo-distributor-ingress-traces
- tempo-components-egress-memcached
- memcached-ingress-querier
- tempo-components-egress-https
- tempo-distributed-egress-minio (when using MinIO)
- tempo-distributed-egress-all (when not using MinIO)

### MinIO
- minio-ingress-namespace
- minio-buckets-setup-egress-kube-apiserver
- minio-buckets-setup-egress-minio
- minio-ingress-prometheus-metrics
- minio-ingress-pomerium
- minio-egress-https

## Configurations
- [Tempo](tempo.md)
