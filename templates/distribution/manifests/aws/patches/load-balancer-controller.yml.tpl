{{- $module := index .spec.distribution.modules "aws" -}}

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: aws-load-balancer-controller
  namespace: kube-system
spec:
  template:
    spec:
      containers:
        - name: controller
          env:
            - name: CLUSTER_NAME
              value: {{ .metadata.name }}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    {{- if $module -}}
    eks.amazonaws.com/role-arn: {{ $module.loadBalancerController.iamRoleArn }}
    {{- end -}}
  name: aws-load-balancer-controller
  namespace: kube-system
