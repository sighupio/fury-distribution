---
apiVersion: velero.io/v1
kind: BackupStorageLocation
metadata:
  name: default
  namespace: kube-system
spec:
  provider: velero.io/aws
  objectStorage:
    bucket: {{ .spec.distribution.modules.dr.velero.eks.bucket }}
  config:
    region: {{ .spec.distribution.modules.dr.velero.eks.region }}
