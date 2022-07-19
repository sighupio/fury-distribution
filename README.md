<!-- markdownlint-disable MD033 -->
<h1 align="center">
  <img src="docs/assets/fury-epta-white.png" width="200px"/><br/>
  Kubernetes Fury Distribution
</h1>

<p align="center">Kubernetes Fury Distribution (KFD) is a certified battle-tested Kubernetes distribution based purely on upstream Kubernetes.</p>
<!-- markdownlint-enable MD033 -->

[![Build Status](http://ci.sighup.io/api/badges/sighupio/fury-distribution/status.svg?ref=refs/tags/v1.23.2)](http://ci.sighup.io/sighupio/fury-distribution)
[![Release](https://img.shields.io/badge/release-v1.23.2-blue?label=FuryDistributionRelease)](https://github.com/sighupio/fury-distribution/releases/latest)
[![Slack](https://img.shields.io/badge/slack-@kubernetes/fury-yellow.svg?logo=slack)](https://kubernetes.slack.com/archives/C0154HYTAQH)
[![License](https://img.shields.io/github/license/sighupio/fury-distribution)](https://github.com/sighupio/fury-distribution/blob/master/LICENSE)

## Overview

Kubernetes Fury Distribution (KFD) is a [CNCF certified](https://landscape.cncf.io/?selected=fury-distribution) battle-tested Kubernetes distribution based purely on upstream Kubernetes.

It is developed and maintained by [SIGHUP](https://sighup.io/) and the community, and it is fully open source.

> 🎯 The goal of Fury is to turn any standard Kubernetes cluster into a fully-configured production-grade cluster.

## Un-distribution model 🧬

KFD uses an **un-distribution model**. This means that we:

- Rely only on open source solutions.
- Are free from vendor lock-in.
- Stay close to upstream Kubernetes and the cloud native landscape.
- Choose and configure a set of battle-tested open source tools.

## Architecture 🏗

Kubernetes Fury Distribution is structured on modules, and each module has a set of packages.

- A package is a single unit of functionality.
- A module groups packages that are functionally related together.

> All modules are open source, widely used, easily customizable, and pre-configured with sane defaults.

The standard way to deploy KFD is to:

- Deploy all the [Core Modules](#core-modules) of the distribution
- Deploy (if needed) any of the [Addon modules](#addon-modules)

### Core Modules 📦

Core modules provides essential functionality to the distribution.

<!-- markdownlint-disable MD033 -->
<p align="center">
  <img src="docs/assets/fury-core-modules.png" width="400px"/>
</p>
<!-- markdownlint-enable MD033 -->

| Module                          | Included Release               | Description                                                                               |
| ------------------------------- | ------------------------------ | ----------------------------------------------------------------------------------------- |
| [Networking][networking-module] | ![Version][networking-version] | Networking functionality via Calico CNI                                                   |
| [Ingress][ingress-module]       | ![Version][ingress-version]    | Fast and reliable Ingress Controller and TLS certificate management                       |
| [Logging][logging-module]       | ![Version][logging-version]    | A centralized logging solution based on the EFK stack (Elastic, Fluentd and Kibana)       |
| [Monitoring][monitoring-module] | ![Version][monitoring-version] | Monitoring and alerting functionality based on Prometheus, AlertManager and Grafana       |
| [Disaster Recovery][dr-module]  | ![Version][dr-version]         | Backup and disaster recovery solution using Velero                                        |
| [OPA][opa-module]               | ![Version][opa-version]        | Policy and Governance for your cluster using OPA Gatekeeper and Gatekeeper Policy Manager |

### Add-on Modules 📦

Add-on modules provide additional functionality to the distribution.

| Module                              | Latest Release                   | Description                                                                  |
| ----------------------------------- | -------------------------------- | ---------------------------------------------------------------------------- |
| [Kong][kong-module]                 | ![Version][kong-version]         | Add Kong API Gateway for Kubernetes applications via Kong Ingress Controller |
| [Service Mesh][service-mesh-module] | ![Version][service-mesh-version] | Deploy a service mesh on top of KFD                                          |
| [Registry][registry-module]         | ![Version][registry-version]     | Integrate a Container Registry solution                                      |

## Get started with KFD 🚀

To get started with KFD, please head to the [quickstart guides on the documentation site](https://docs.kubernetesfury.com/docs/distribution/#%EF%B8%8F-how-do-i-get-started).

## Issues 🐛

In case you experience any issues feel free to [open a new issue](https://github.com/sighupio/fury-distribution/issues/new/choose).

If the problem is related to a specific module, open the issue in the module repository.

## Commercial Support 🛟

If you are looking to run KFD in production and would like to learn more, SIGHUP (the company behind the Fury ecosystem) can help. Feel free to [email us](mailto:sales@sighup.io) or check out [our website](https://sighup.io).

## Compatibility

| Kubernetes Version |   Compatibility    | Notes           |
| ------------------ | :----------------: | --------------- |
| `1.23.x`           | :white_check_mark: | No known issues |

Check the [compatibility matrix][compatibility-matrix] for additional information about previous releases of the Distribution.

Also, check the [versioning documentation file][versioning] to know more about the versioning scheme of the distribution and the upgrade path.

## Contributing 🤝

If you wish to contribute please read the [Contributing Guidelines](docs/CONTRIBUTING.md).

## CNCF Certified 🎓

Kubernetes Fury Distribution has been certified by the [CNCF] *(Cloud Native Computing foundation)* as a *Certified Kubernetes Distribution*. Certified solutions are validated to ensure a set of guarantees as consistency, timely updates and confirmability.

<!-- markdownlint-disable MD033 -->
<center>
    <a href="https://github.com/cncf/k8s-conformance/pull/1280">
        <img src="https://github.com/cncf/artwork/raw/master/projects/kubernetes/certified-kubernetes/1.20/color/certified-kubernetes-1.20-color.png" width="100" />
    </a>
    <a href="https://github.com/cncf/k8s-conformance/pull/1495">
        <img src="https://github.com/cncf/artwork/raw/master/projects/kubernetes/certified-kubernetes/1.21/color/certified-kubernetes-1.21-color.png" width="100" />
    </a>
    <a href="https://github.com/cncf/k8s-conformance/pull/1602">
        <img src="https://github.com/cncf/artwork/raw/master/projects/kubernetes/certified-kubernetes/1.22/color/certified-kubernetes-1.22-color.png" width="100" />
    </a>
    <a href="https://github.com/cncf/k8s-conformance/pull/1788">
        <img src="https://github.com/cncf/artwork/raw/master/projects/kubernetes/certified-kubernetes/1.23/color/certified-kubernetes-1.23-color.png" width="100" />
    </a>
</center>
<!-- markdownlint-enable MD033 -->

## License

KFD is open-source software and it's released under the following [LICENSE](LICENSE)

<!-- Core Modules -->
[networking-module]: https://github.com/sighupio/fury-kubernetes-networking
[ingress-module]: https://github.com/sighupio/fury-kubernetes-ingress
[logging-module]: https://github.com/sighupio/fury-kubernetes-logging
[monitoring-module]: https://github.com/sighupio/fury-kubernetes-monitoring
[dr-module]: https://github.com/sighupio/fury-kubernetes-dr
[opa-module]: https://github.com/sighupio/fury-kubernetes-opa

[networking-version]: https://img.shields.io/badge/release-v1.9.0-blue
[ingress-version]: https://img.shields.io/badge/release-v1.12.2-blue
[logging-version]: https://img.shields.io/badge/release-v1.10.3-blue
[monitoring-version]: https://img.shields.io/badge/release-v1.14.2-blue
[dr-version]: https://img.shields.io/badge/release-v1.9.2-blue
[opa-version]: https://img.shields.io/badge/release-v1.6.2-blue
[compatibility-matrix]: https://github.com/sighupio/fury-distribution/blob/master/docs/COMPATIBILITY_MATRIX.md
[versioning]: https://github.com/sighupio/fury-distribution/blob/master/docs/VERSIONING.md

<!-- Addon Modules -->
[kong-module]: https://github.com/sighupio/fury-kubernetes-kong
[service-mesh-module]: https://github.com/sighupio/fury-kubernetes-service-mesh
[registry-module]: https://github.com/sighupio/fury-kubernetes-registry

[kong-version]: https://img.shields.io/github/v/release/sighupio/fury-kubernetes-kong
[service-mesh-version]: https://img.shields.io/github/v/release/sighupio/fury-kubernetes-service-mesh
[registry-version]: https://img.shields.io/github/v/release/sighupio/fury-kubernetes-registry

<!-- Misc -->
[sighup-site]: https:sighup.io
[CNCF]: https://landscape.cncf.io/card-mode?category=certified-kubernetes-distribution&grouping=category&organization=sighup
