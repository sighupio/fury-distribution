---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

{{- $version := semver .spec.distributionVersion }}

resources:
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/aws/katalog/cluster-autoscaler/v" $version.Major "." $version.Minor ".x" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/aws/katalog/ebs-csi-driver" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/aws/katalog/load-balancer-controller" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/aws/katalog/node-termination-handler" }}
  - resources/sc.yml

patchesStrategicMerge:
  - patches/cluster-autoscaler.yml
  - patches/ebs-csi-driver.yml
  - patches/infra-nodes.yml
  - patches/load-balancer-controller.yml
