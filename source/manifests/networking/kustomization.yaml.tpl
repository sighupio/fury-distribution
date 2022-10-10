---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .common.relativeVendorPath "/katalog/networking/tigera/eks-policy-only" }}

