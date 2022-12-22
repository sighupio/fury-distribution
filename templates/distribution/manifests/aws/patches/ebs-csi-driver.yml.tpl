apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: {{ .spec.distribution.modules.aws.ebsCsiDriver.iamRoleArn }}
  name: ebs-csi-controller-sa
  namespace: kube-system
