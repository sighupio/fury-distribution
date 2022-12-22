---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cluster-autoscaler
  namespace: kube-system
spec:
  template:
    spec:
      containers:
        - name: aws-cluster-autoscaler
          env:
            - name: AWS_REGION
              value: {{ .spec.distribution.modules.aws.clusterAutoscaler.region }}
            - name: CLUSTER_NAME
              value: {{ .metadata.name }}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: {{ .spec.distribution.modules.aws.clusterAutoscaler.iamRoleArn }}
  name: cluster-autoscaler
  namespace: kube-system
