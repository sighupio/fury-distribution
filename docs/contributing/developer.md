---
title: "📒 Developer Guide"
id: "development"
---

There is a lot of room of improvement over at Kubernetes Fury
Distribution (KFD). We welcome all contributors who would like to get their
hands dirty, we promise to guide you well through the journey.

## Get an understanding of the core concepts of Fury Distribution

We have a great documentation about the core concepts of KFD over [here](../02-core-concepts/00-principles.md).
We recommend you go through it to understand the base principles on how our
distribution works, and what makes it easy to use and configure.
If you have any questions or doubts, please feel free to quickly drop our engineers
a message at [our Slack or via e-mail](index.md#get-in-touch-with-us).

You can also open a `Question` issue over at Github.

## Understand our tooling and distribution methods

We use a lot of popular package management and infra configuration tools for the
distribution of KFD. We recommend you get them installed and get a basic
understanding on how to use them:

* `kubectl` >= 1.20.0
* `kustomize` >= 3.3.0
* `terraform` == 0.15.4
* [furyctl](../02-core-concepts/03-furyctl.md) >= 0.6.0

Basic working knowledge of Kuberentes is required.

## Explore our repos

Having said that, finding your way around our repos can be a bit of a hassle.
Due to the modular nature of our distro, the parts comprising our module
is rather spreading around. So here is a quick gist of our most
important repos:

| Repo Name/URL                                                      | Description                     |
|--------------------------------------------------------------------|---------------------------------|
| [Fury-Distribution](https://github.com/sighupio/fury-distribution) | This is the base repo of `KFD`. |

### Core Modules

| Module                          | Description                                                                               |
|---------------------------------|-------------------------------------------------------------------------------------------|
| [Networking][networking-module] | Networking functionality via Calico CNI                                                   |
| [Ingress][ingress-module]       | Fast and reliable Ingress Controller and TLS certificate management                       |
| [Logging][logging-module]       | A centralized logging solution based on the EFK stack (Elastic, Fluentd and Kibana)       |
| [Monitoring][monitoring-module] | Monitoring and alerting functionality based on Prometheus, AlertManager and Grafana       |
| [Disaster Recovery][dr-module]  | Backup and disaster recovery solution using Velero                                        |
| [OPA][opa-module]               | Policy and Governance for your cluster using OPA Gatekeeper and Gatekeeper Policy Manager |

### Add-on Modules

| Module                              | Description                                                                  |
|-------------------------------------|------------------------------------------------------------------------------|
| [Kong][kong-module]                 | Add Kong API Gateway for Kubernetes applications via Kong Ingress Controller |
| [Service Mesh][service-mesh-module] | Deploy a service mesh on top of KFD                                          |
| [Registry][registry-module]         | Comprehensive Container Registry solution                                    |

## Testing Fury out

The best way to get started with Fury is to start testing it on your favorite
cloud provider. We have a very well explained documentation about how to set it
up with a step by step guide over [here](../03-quickstart/1-fury-on-eks.mdx). If
you are stuck, you know [where to get help](index.md#get-in-touch-with-us).

## Contributing

If you can think of a feature that might work great with Fury by you can't find
it, please open an issue in the
[`fury-distribution`](https://github.com/sighupio/fury-distribution) repo under
the `Enhancements` template and ask us to add it. Make sure the following
information is clear while opening the issue:

* Describe the feature in a couple of lines.
* Give us a quick description of the environment where the need arises
* Describe any available alternative out there

We will review the issue and le you know if it works for us to implement it.

## Hands on

In case someone at SIGHUP reviewed the issue and validated the idea, you will need to
[fork the repository](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/working-with-forks)
and create a new branch with a self-descriptive name. For example `git checkout -b add-envoy-rate-limit`.

You should work in your branch until you reach a stable enough feature.

> Remember that you will have an engineer at SIGHUP who will help you if you have doubts about the feature.

Once you feel it's the right moment to open a pull request, do it against a new branch SIGHUP engineer should open
*(ask for it)*.

This PR will be reviewed by the Product Team at SIGHUP. Once the Product Team approves the change, it will be
merged into our repository and we will run E2E validation tests.

SIGHUP's Product Team is responsible for the releases so the new feature will be released when the Product Team thinks
it's the right moment.

<!-- Links -->
<!-- Core Modules -->
[networking-module]: https://github.com/sighupio/fury-kubernetes-networking
[ingress-module]: https://github.com/sighupio/fury-kubernetes-ingress
[logging-module]: https://github.com/sighupio/fury-kubernetes-logging
[monitoring-module]: https://github.com/sighupio/fury-kubernetes-monitoring
[dr-module]: https://github.com/sighupio/fury-kubernetes-dr
[opa-module]: https://github.com/sighupio/fury-kubernetes-opa

<!-- Addon Modules -->
[kong-module]: https://github.com/sighupio/fury-kubernetes-kong
[service-mesh-module]: https://github.com/sighupio/fury-kubernetes-service-mesh
[registry-module]: https://github.com/sighupio/fury-kubernetes-registry
