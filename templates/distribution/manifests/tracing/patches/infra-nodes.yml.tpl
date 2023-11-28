# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- $minioArgs := dict "module" "tracing" "package" "minio" "spec" .spec -}}
{{- $tempoArgs := dict "module" "tracing" "package" "tempo" "spec" .spec -}}

{{- if eq .spec.distribution.modules.tracing.type "tempo" }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: tempo-distributed-ingester
  namespace: tracing
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $tempoArgs }}
      tolerations:
        {{ template "tolerations" $tempoArgs }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: tempo-distributed-memcached
  namespace: tracing
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $tempoArgs }}
      tolerations:
        {{ template "tolerations" $tempoArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tempo-distributed-compactor
  namespace: tracing
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $tempoArgs }}
      tolerations:
        {{ template "tolerations" $tempoArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tempo-distributed-distributor
  namespace: tracing
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $tempoArgs }}
      tolerations:
        {{ template "tolerations" $tempoArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tempo-distributed-gateway
  namespace: tracing
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $tempoArgs }}
      tolerations:
        {{ template "tolerations" $tempoArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tempo-distributed-querier
  namespace: tracing
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $tempoArgs }}
      tolerations:
        {{ template "tolerations" $tempoArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tempo-distributed-query-frontend
  namespace: tracing
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $tempoArgs }}
      tolerations:
        {{ template "tolerations" $tempoArgs }}

{{- end }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: minio-tracing
  namespace: tracing
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $minioArgs }}
      tolerations:
        {{ template "tolerations" $minioArgs }}
---
apiVersion: batch/v1
kind: Job
metadata:
  name: minio-tracing-buckets-setup
  namespace: tracing
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $minioArgs }}
      tolerations:
        {{ template "tolerations" $minioArgs }}
