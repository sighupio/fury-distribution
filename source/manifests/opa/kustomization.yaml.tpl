---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .common.relativeVendorPath "/katalog/opa/gatekeeper/core" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/opa/gatekeeper/gpm" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/opa/gatekeeper/rules" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/opa/gatekeeper/monitoring" }}
  - resources/ingress-infra.yml

patchesStrategicMerge:
  - patches/infra-nodes.yml

{{ if .modules.policy.gatekeeper.additionalExcludedNamespaces }}
patchesJson6902:
  - target:
      group: config.gatekeeper.sh
      version: v1alpha1
      kind: Config
      name: config
    path: patches/gatekeeper-whitelist-namespace.yml
{{ end }}