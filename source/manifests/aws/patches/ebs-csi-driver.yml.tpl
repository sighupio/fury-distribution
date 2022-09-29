apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: {{ .modules.aws.ebsCsiDriver.iamRoleArn }}
  name: ebs-csi-controller-sa
  namespace: kube-system
