{{- $module := index .spec.distribution.modules "aws" -}}

---
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    {{- if $module -}}
    eks.amazonaws.com/role-arn: {{ $module.ebsCsiDriver.iamRoleArn }}
    {{- end -}}
  name: ebs-csi-controller-sa
  namespace: kube-system
