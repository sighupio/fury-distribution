# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- $veleroArgs := dict "module" "dr" "package" "velero" "spec" .spec -}}

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: velero
  namespace: kube-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $veleroArgs }}
      tolerations:
        {{ template "tolerations" $veleroArgs }}
