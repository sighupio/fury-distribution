# POC Fury Distribution

[![Build Status](http://ci.sighup.io/api/badges/sighupio/poc-fury-distribution/status.svg?ref=refs/heads/develop)](http://ci.sighup.io/sighupio/poc-fury-distribution)

This POC spin up a kind cluster with a custom configuration:
[katalog/tests/config/kind-config-custom](katalog/tests/config/kind-config-custom)

This configuration is the most similar configuration to every kubernetes cluster we create.
This way we can ensure everything works as expected including the CNI *(calico)*.

## Core Modules

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

## Tests

Smoke tests *(smoke testing)* are executed in an E2E pipeline. It checks everything is running.
We should define the test we should pass here as every module has to have it's own tests.

## Pending work

- Add more core modules
  - Create more tests
- Certified everything is working
- Document it
- Document how to extend it
- Make a binary to orchestrate the installation
  - Opcional CNI as we can install this distribution on top of Cloud Providers
  - Optional HA ElasticSearch deployment
  - Optional Dual Ingress
    - Be careful with the cert-manager cluster-issuer
