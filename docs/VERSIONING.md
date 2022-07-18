# Versioning

KFD follows [semantic versioning][semver] for identifying its releases, in particular, it follows closely Kubernetes versioning.

Starting from the 1.21.0 KFD release, the versioning scheme has changed.

We are now versioning KFD using the same minor version than the supported Kubernetes version.
This means that each KFD version will have a 1:1 compatibility with a specific Kubernetes version.

For example:

- KFD 1.22.0 is compatible with Kubernetes 1.22.x
- KFD 1.22.5 is compatible with Kubernetes 1.22.x
- KFD 1.23.0 is compatible with Kubernetes 1.23.x
- KFD 1.23.1 is compatible with Kubernetes 1.23.x
- KFD 1.23.2 is compatible with Kubernetes 1.23.x
- KFD 1.24.0 is compatible with Kubernetes 1.24.x

## Upgrades

Each KFD version will be compatible with the X-1 Kubernetes version during upgrades.
For example, the 1.23.0 KFD version will be compatible with Kubernetes 1.22.X during upgrades.

The only supported upgrade path is:

- Upgrade KFD to the next version
- Upgrade Kubernetes to the version supported by KFD

<!--  Links -->
[semver]: https://semver.org/

