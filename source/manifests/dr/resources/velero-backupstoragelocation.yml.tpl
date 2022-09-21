---
apiVersion: velero.io/v1
kind: BackupStorageLocation
metadata:
  name: default
  namespace: kube-system
spec:
  provider: velero.io/aws
  objectStorage:
    bucket: {{ .modules.dr.velero.eks.bucket }}
  config:
    region: {{ .modules.dr.velero.eks.region }}
