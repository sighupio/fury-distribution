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
    eks.amazonaws.com/role-arn: {{ template "iamRoleArn" (dict "package" "loadBalancerController" "spec" .spec) }}
  name: aws-load-balancer-controller
  namespace: kube-system
