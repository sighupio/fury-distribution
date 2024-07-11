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

{{- if eq .spec.distribution.common.provider.type "none" }}
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-agent
  namespace: kube-system
spec:
  template:
    spec:
      tolerations:
        {{ template "tolerations" $veleroArgs }}

{{- end }}

{{- if eq .spec.distribution.modules.dr.velero.backend "minio" }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: minio
  namespace: kube-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $veleroArgs }}
      tolerations:
        {{ template "tolerations" $veleroArgs }}

---
apiVersion: batch/v1
kind: Job
metadata:
  name: minio-setup
  labels:
    k8s-app: minio-setup
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $veleroArgs }}
      tolerations:
        {{ template "tolerations" $veleroArgs }}

{{- end }}
