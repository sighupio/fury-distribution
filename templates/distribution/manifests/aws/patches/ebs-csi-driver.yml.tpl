# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: {{ template "iamRoleArn" (dict "package" "ebsCsiDriver" "spec" .spec) }}
  name: ebs-csi-controller-sa
  namespace: kube-system
