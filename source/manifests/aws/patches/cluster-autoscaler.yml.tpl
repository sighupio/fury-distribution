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
        - name: cluster-autoscaler
          env:
            - name: AWS_REGION
              value: {{ .modules.aws.clusterAutoscaler.region }}
            - name: CLUSTER_NAME
              value: {{ .metadata.name }}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: {{ .modules.aws.clusterAutoscaler.iamRoleArn }}
  name: cluster-autoscaler
  namespace: kube-system
