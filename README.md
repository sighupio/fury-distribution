# Fury Distribution

[![Build Status](http://ci.sighup.io/api/badges/sighupio/poc-fury-distribution/status.svg?ref=refs/heads/develop)](http://ci.sighup.io/sighupio/poc-fury-distribution)

## Information

This repository spin up a kind cluster with a custom configuration:
[katalog/tests/config/kind-config-custom](katalog/tests/config/kind-config-custom)

The configuration is almost the same configuration we do in every kubernetes cluster we create.
This way we can ensure everything works as expected including the CNI *(calico)*.

### Core Modules

- Networking
  - calico
- Monitoring
  - prometheus-operator
  - prometheus-operated
  - grafana
  - goldpinger
  - kubeadm-sm
  - kube-state-metrics
  - node-exporter
  - metrics-server
- Logging
  - elasticsearch-single
  - cerebro
  - curator
  - fluentd
  - kibana
- Ingress
  - cert-manager
  - nginx
  - forecastle
- DR
  - Velero (on prem, with Minio)
  - Velero Restic

### Tests

Smoke tests *(smoke testing)* are executed in this E2E pipeline. It checks everything is running.

## License

For license details please see [LICENSE](LICENSE)
