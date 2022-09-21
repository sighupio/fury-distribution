---
apiVersion: velero.io/v1
kind: VolumeSnapshotLocation
metadata:
  name: default
  namespace: kube-system
spec:
  provider: velero.io/aws
  config:
    region: {{ .modules.dr.velero.eks.region }}
