---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/dr/katalog/velero/velero-aws" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/dr/katalog/velero/velero-schedules" }}
  - resources/velero-backupstoragelocation.yml
  - resources/velero-volumesnapshotlocation.yml

patchesStrategicMerge:
  - patches/infra-nodes.yml
  - patches/velero.yml
