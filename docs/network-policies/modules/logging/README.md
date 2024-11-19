# Logging Module Network Policies

## Components
- OpenSearch Stack
- Loki Stack

## Namespaces
- logging

## Network Policies List

### Common Policies
- deny-all
- all-egress-kube-dns
- event-tailer-egress-kube-apiserver
- fluentbit-egress-fluentd
- fluentbit-egress-kube-apiserver
- fluentbit-ingress-prometheus-metrics
- logging-operator-egress-kube-apiserver

### OpenSearch Stack
- fluentd-ingress-fluentbit
- fluentd-ingress-prometheus-metrics
- fluentd-egress-minio
- fluentd-egress-opensearch
- opensearch-discovery
- opensearch-ingress-dashboards
- opensearch-ingress-fluentd
- opensearch-ingress-prometheus-metrics
- opensearch-ingress-jobs
- opensearch-dashboards-egress-opensearch
- opensearch-dashboards-ingress-nginx
- opensearch-dashboards-ingress-jobs
- jobs-egress-opensearch

### Loki Stack
- fluentd-egress-loki
- loki-distributed-ingress-fluentd
- loki-distributed-ingress-grafana
- loki-distributed-ingress-prometheus-metrics
- loki-distributed-discovery
- loki-distributed-egress-minio

### MinIO
- minio-ingress-namespace
- minio-buckets-setup-egress-kube-apiserver
- minio-buckets-setup-egress-minio
- minio-ingress-prometheus-metrics
- minio-ingress-nginx
- minio-egress-https

## Configurations
- [OpenSearch Stack](opensearch.md)
- [Loki Stack](loki.md)

