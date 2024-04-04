# KFD Roadmap

The overall objective of the roadmap and the KFD product is to support the latest three versions of Kubernetes -1. For example, if the latest Kubernetes version is 1.25, we aim to support 1.24, 1.23 and 1.22.

From 2024, development will focus on hardening the distribution security-wise, providing a series of opt-in features that implement security best practices on the cluster.

## Q1 2024

- KFD 1.28.x release and release of the latest supported patch version for 1.27.x and 1.26.x, drop support for 1.25.x
- furyctl 0.28.x release
- Feature: Additional encryption parameters for ETCD on the OnPremises provider
- New project release: Gangplank, a forked and updated version of Gangway

## Q2 2024

- KFD 1.29.x release and release of the latest supported patch version for 1.28.x and 1.27.x, drop support for 1.26.x
- furyctl 0.29.x release
- Feature: Improved hardening for all the images used in the KFD distribution by default
- Feature: Improved network policies for the KFD infrastructural components

## H2 2024

- KFD 1.30.x release and release of the latest supported patch version for 1.29.x and 1.28.x, drop support for 1.27.x
- furyctl 0.30.x release
- Feature: Add support for secured container runtimes
- Feature: Track dependencies provenance and dependencies signing
