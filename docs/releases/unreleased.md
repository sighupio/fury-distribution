# SIGHUP Distribution Release vTBD

Welcome to SD release `vTBD`.

The distribution is maintained with ❤️ by the team [SIGHUP](https://sighup.io/).

## New Features since `v1.31.0`

### Installer Updates

- TBD

### Module updates

- TBD

## Breaking changes 💔

- [[#358](https://github.com/sighupio/fury-distribution/pull/358)] **Upgrade kustomize to version 5.6.0**: plugins that used old deprecated constructs in their `kustomization.yaml` may not work anymore. Please refer to the release notes of `kustomize` version [4.0.0](https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv4.0.0) and version [5.0.0](https://github.com/kubernetes-sigs/kustomize/releases/tag/kustomize%2Fv5.0.0) for breaking changes that might affect your plugins.

## New features 🌟

- [[#355](https://github.com/sighupio/fury-distribution/pull/355)] **Support for etcd cluster on dedicated nodes**: adding support for deploying etcd on dedicated nodes instead of control plane nodes to the OnPremises provider. For the new clusters, users can define specific hosts for etcd, each with a name and IP. If the etcd key is omitted, etcd will be provisioned on control plane nodes. No migration paths are supported.

To make use of this new feature, you need to define the hosts where etcd will be deployed in your configuration file using the `.spec.kubernetes.etcd` key, for example:



  ```yaml
  ...
  spec:
    kubernetes:
      masters:
        hosts:
          - name: master1
            ip: 192.168.66.29
          - name: master2
            ip: 192.168.66.30
          - name: master3
            ip: 192.168.66.31
      etcd:
        hosts:
          - name: etcd1
            ip: 192.168.66.39
          - name: etcd2
            ip: 192.168.66.40
          - name: etcd3
            ip: 192.168.66.41
      nodes:
        - name: worker
          hosts:
            - name: worker1
              ip: 192.168.66.49
  ...
  ```

## Fixes 🐞

- [[#334](https://github.com/sighupio/fury-distribution/pull/334)] **Fix to policy module templates**: setting the policy module type to `gatekeeper` and the `additionalExcludedNamespaces` option for Kyverno at the same time resulted in an error do to an bug in the templates logic, this has been fixed.
- [[#336](https://github.com/sighupio/fury-distribution/pull/336)] **Fix race condition when deleting Kyverno**: changing the policy module type from `kyverno` to `none` could, sometimes, end up in a race condition where the API for ClusterPolicy CRD is unregistered before the deletion of the ClusterPolicy objects, resulting in an error in the deletion command execution. The deletion command has been tweaked to avoid this condition.
- [[#344](https://github.com/sighupio/fury-distribution/pull/344)] **Fix Cidr Block additional firewall rule in EKS Cluster**: remove the limitation to have a single CIDR Block additional firewall rule as the EKS installer supports a list.
- [[#348](https://github.com/sighupio/fury-distribution/pull/348)] **Fix `Get previous cluster configuration` failure on first apply**: fixed an issue on `furyctl apply` for on-premises clusters that made it fail with an `ansible-playbook create-playbook.yaml: command failed - exit status 2` error on the very first time it was executed.

## Upgrade procedure

Check the [upgrade docs](https://docs.kubernetesfury.com/docs/installation/upgrades) for the detailed procedure.
