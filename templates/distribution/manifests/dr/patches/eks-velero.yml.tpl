# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- if eq .spec.distribution.common.provider.type "eks" }}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: {{ .spec.distribution.modules.dr.velero.eks.iamRoleArn }}
  name: velero
  namespace: kube-system
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: velero
  namespace: kube-system
spec:
  template:
    spec:
      containers:
      - name: velero
        volumeMounts:
        - name: cloud-credentials
          mountPath: /credentials
          $patch: delete
      volumes:
      - name: cloud-credentials
        $patch: delete
{{- end }}
