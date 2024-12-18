# Kubernetes Fury Distribution Release vTBD

Welcome to KFD release `vTBD`.

The distribution is maintained with ❤️ by the team [SIGHUP](https://sighup.io/).

## New Features since `v1.30.0`

### Installer Updates

- [on-premises](https://github.com/sighupio/fury-kubernetes-on-premises) 📦 installer: [**vTBD**](https://github.com/sighupio/fury-kubernetes-on-premises/releases/tag/vTBD)
  - TBD
- [eks](https://github.com/sighupio/fury-eks-installer) 📦 installer: [**vTBD**](https://github.com/sighupio/fury-eks-installer/releases/tag/vTBD)
  - TBD

### Module updates

- [networking](https://github.com/sighupio/fury-kubernetes-networking) 📦 core module: [**vTBD**](https://github.com/sighupio/fury-kubernetes-networking/releases/tag/vTBD)
  - TBD
- [monitoring](https://github.com/sighupio/fury-kubernetes-monitoring) 📦 core module: [**vTBD**](https://github.com/sighupio/fury-kubernetes-monitoring/releases/tag/vTBD)
  - TBD
- [logging](https://github.com/sighupio/fury-kubernetes-logging) 📦 core module: [**vTBD**](https://github.com/sighupio/fury-kubernetes-logging/releases/tag/vTBD)
  - TBD
- [ingress](https://github.com/sighupio/fury-kubernetes-ingress) 📦 core module: [**vTBD**](https://github.com/sighupio/fury-kubernetes-ingress/releases/tag/vTBD)
  - TBD
- [auth](https://github.com/sighupio/fury-kubernetes-auth) 📦 core module: [**vTBD**](https://github.com/sighupio/fury-kubernetes-auth/releases/tag/vTBD)
  - TBD
- [dr](https://github.com/sighupio/fury-kubernetes-dr) 📦 core module: [**vTBD**](https://github.com/sighupio/fury-kubernetes-dr/releases/tag/vTBD)
  - TBD
- [tracing](https://github.com/sighupio/fury-kubernetes-tracing) 📦 core module: [**vTBD**](https://github.com/sighupio/fury-kubernetes-tracing/releases/tag/vTBD)
  - TBD
- [opa](https://github.com/sighupio/fury-kubernetes-opa) 📦 core module: [**vTBD**](https://github.com/sighupio/fury-kubernetes-opa/releases/tag/vTBD)
  - TBD
- [aws](https://github.com/sighupio/fury-kubernetes-aws) 📦 module: [**vTBD**](https://github.com/sighupio/fury-kubernetes-aws/releases/tag/vTBD)
  - TBD

## Breaking changes 💔

- **TBD**: TBD

## New features 🌟

- [[#320](https://github.com/sighupio/fury-distribution/pull/320)] **Custom Lables and Annotations for on-premises nodes**: the configuration file for on-premises clusters now supports specifying custom labels and annotations for the control-plane nodes and for the node groups. The labels and annotations specified will be applied to all the nodes in the group (and deleted when removed from the configuration). Usage example:

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
        labels:
          node-role.kubernetes.io/dungeon-master: ""
          dnd-enabled: "true"
        annotations:
          level: "100"
      nodes:
        - name: infra
          hosts:
            - name: infra1
              ip: 192.168.66.32
            - name: infra2
              ip: 192.168.66.33
            - name: infra3
              ip: 192.168.66.34
          taints:
            - effect: NoSchedule
              key: node.kubernetes.io/role
              value: infra
          labels:
            a-label: with-content
            empty-label: ""
            label/sighup: "with-slashes"
            node-role.kubernetes.io/wizard: ""
            dnd-enabled: "true"
          annotations:
            with-spaces: "annotation with spaces"
            without-spaces: annotation-without-spaces
            level: "20"
        - name: worker
          hosts:
            - name: worker1
              ip: 192.168.66.35
          taints: []
          labels:
            node-role.kubernetes.io/barbarian: ""
            dnd-enabled: "true"
            label-custom: "with-value"
          annotations:
            level: "10"
        - name: empty-labels-and-annotations
          hosts:
            - name: empty1
              ip: 192.168.66.50
          taints: []
          labels:
          annotations:
        - name: undefined-labels-and-annotations
          hosts:
            - name: undefined1
              ip: 192.168.66.51
          taints: []
  ...
  ```

## Fixes 🐞

- TBD
<!-- Example:
- [[#264](https://github.com/sighupio/fury-distribution/pull/264)] Hubble UI: now is shown in the right group in the Directory
-->

## Upgrade procedure

Check the [upgrade docs](https://docs.kubernetesfury.com/docs/upgrades/upgrades) for the detailed procedure.
