---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/opa/katalog/gatekeeper/core" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/opa/katalog/gatekeeper/gpm" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/opa/katalog/gatekeeper/rules" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/opa/katalog/gatekeeper/monitoring" }}
  - resources/ingress-infra.yml

patchesStrategicMerge:
  - patches/infra-nodes.yml

{{ if .spec.distribution.modules.policy.gatekeeper.additionalExcludedNamespaces }}
patchesJson6902:
  - target:
      group: config.gatekeeper.sh
      version: v1alpha1
      kind: Config
      name: config
    path: patches/gatekeeper-whitelist-namespace.yml
{{ end }}