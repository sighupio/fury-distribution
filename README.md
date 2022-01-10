<h1 align="center">
  <img src="docs/assets/fury-epta-white.png" width="200px"/><br/>
  Kubernetes Fury Distribution
</h1>

<p align="center">Kubernetes Fury Distribution (KFD) is a certified battle-tested Kubernetes distribution based purely on upstream Kubernetes.</p>

[![Build Status](http://ci.sighup.io/api/badges/sighupio/fury-distribution/status.svg?ref=refs/tags/v1.6.0)](http://ci.sighup.io/sighupio/fury-distribution)
[![Release](https://img.shields.io/github/v/release/sighupio/fury-distribution?label=FuryDistributionRelease)]()
[![Slack](https://img.shields.io/badge/slack-@kubernetes/fury-yellow.svg?logo=slack)]()
[![License](https://img.shields.io/github/license/sighupio/fury-distribution)]()

## Overview

## Architecture

Kubernetes Fury Distribution was designed as a modular Kubernetes distribution.
This modular design makes it possible to extend the distribution with new features.

### Core Modules

The core modules provides essential functionality to the distribution.

<p align="center">
  <img src="docs/assets/fury-core-modules.png" width="400px"/>
</p>

|             Module              |         Latest Release         |                                        Description                                        |
| ------------------------------- | ------------------------------ | ----------------------------------------------------------------------------------------- |
| [Networking][networking-module] | ![Version][networking-version] | Networking functionality via Calico CNI                                                   |
| [Ingress][ingress-module]       | ![Version][ingress-version]    | Fast and reliable Ingress Controller and TLS certificate management                       |
| [Logging][logging-module]       | ![Version][logging-version]    | A centralized logging solution based on the EFK stack (Elastic + Fluentd + Kibana)        |
| [Monitoring][monitoring-module] | ![Version][monitoring-version] | Monitoring and alerting functionality based on Prometheus, AlertManager and Grafana       |
| [Disaster Recovery][dr-module]  | ![Version][dr-version]         | Backup and disaster recovery solution using Velero                                        |
| [OPA][opa-module]               | ![Version][opa-version]        | Policy and Governance for your cluster using OPA Gatekeeper and Gatekeeper Policy Manager |

### Addons Modules

## Features

## Contributing

If you wish to contribute please read the [Contributing Guidelines][docs/CONTRIBUTING.md].

## License

KFD is open-source software and it's released under the following [LICENSE](LICENSE)

[networking-module]: https://github.com/sighupio/fury-kubernetes-networking
[ingress-module]: https://github.com/sighupio/fury-kubernetes-ingress
[logging-module]: https://github.com/sighupio/fury-kubernetes-logging
[monitoring-module]: https://github.com/sighupio/fury-kubernetes-monitoring
[dr-module]: https://github.com/sighupio/fury-kubernetes-dr
[opa-module]: https://github.com/sighupio/fury-kubernetes-opa

[networking-version]: https://img.shields.io/github/v/release/sighupio/fury-kubernetes-networking
[ingress-version]: https://img.shields.io/github/v/release/sighupio/fury-kubernetes-ingress
[logging-version]: https://img.shields.io/github/v/release/sighupio/fury-kubernetes-logging
[monitoring-version]: https://img.shields.io/github/v/release/sighupio/fury-kubernetes-monitoring
[dr-version]: https://img.shields.io/github/v/release/sighupio/fury-kubernetes-dr
[opa-version]: https://img.shields.io/github/v/release/sighupio/fury-kubernetes-opa
