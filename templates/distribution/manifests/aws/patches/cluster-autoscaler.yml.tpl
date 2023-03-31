# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

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
              value: {{ .spec.region }}
            - name: CLUSTER_NAME
              value: {{ .metadata.name }}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: {{ template "iamRoleArn" (dict "package" "clusterAutoscaler" "spec" .spec) }}
  name: cluster-autoscaler
  namespace: kube-system
