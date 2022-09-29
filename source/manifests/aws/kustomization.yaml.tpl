---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

{{- $version := semver .metadata.distrobutionVersion }}

resources:
  - {{ print "../" .common.relativeVendorPath "/katalog/aws/cluster-autoscaler/v" $version.Major "." $version.Minor ".x" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/aws/ebs-csi-driver" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/aws/load-balancer-controller" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/aws/node-termination-handler" }}
  - resources/sc.yml

patchesStrategicMerge:
  - patches/cluster-autoscaler.yml
  - patches/ebs-csi-driver.yml
  - patches/infra-nodes.yml
  - patches/load-balancer-controller.yml
