---
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: {{ template "iamRoleArn" (dict "package" "ebsCsiDriver" "spec" .spec) }}
  name: ebs-csi-controller-sa
  namespace: kube-system
