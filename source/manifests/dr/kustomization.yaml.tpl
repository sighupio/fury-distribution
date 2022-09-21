---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .common.relativeVendorPath "/katalog/dr/velero/velero-aws" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/dr/velero/velero-schedules" }}
  - resources/velero-backupstoragelocation.yml
  - resources/velero-volumesnapshotlocation.yml

patchesStrategicMerge:
  - patches/infra-nodes.yml
  - patches/velero.yml
