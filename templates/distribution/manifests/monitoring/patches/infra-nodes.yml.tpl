# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- $alertManagerArgs := dict "module" "monitoring" "package" "alertmanager" "spec" .spec -}}
{{- $blackboxExporterArgs := dict "module" "monitoring" "package" "blackboxExporter" "spec" .spec -}}
{{- $grafanaArgs := dict "module" "monitoring" "package" "grafana" "spec" .spec -}}
{{- $kubeStateMetricsArgs := dict "module" "monitoring" "package" "kubeStateMetrics" "spec" .spec -}}
{{- $prometheusArgs := dict "module" "monitoring" "package" "prometheus" "spec" .spec -}}
{{- $x509ExporterArgs := dict "module" "monitoring" "package" "x509Exporter" "spec" .spec -}}

---
apiVersion: monitoring.coreos.com/v1
kind: Alertmanager
metadata:
  name: main
  namespace: monitoring
spec:
  nodeSelector:
    {{ template "nodeSelector" ( merge (dict "indent" 4) $alertManagerArgs ) }}
  tolerations:
    {{ template "tolerations" ( merge (dict "indent" 4) $alertManagerArgs ) }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blackbox-exporter
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $blackboxExporterArgs }}
      tolerations:
        {{ template "tolerations" $blackboxExporterArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $grafanaArgs }}
      tolerations:
        {{ template "tolerations" $grafanaArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: kube-state-metrics
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $kubeStateMetricsArgs }}
      tolerations:
        {{ template "tolerations" $kubeStateMetricsArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus-adapter
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $prometheusArgs }}
      tolerations:
        {{ template "tolerations" $prometheusArgs }}
{{- if .checks.storageClassAvailable }}
---
apiVersion: monitoring.coreos.com/v1
kind: Prometheus
metadata:
  name: k8s
  namespace: monitoring
spec:
  nodeSelector:
    {{ template "nodeSelector" merge (dict "indent" 4) $prometheusArgs }}
  tolerations:
    {{ template "tolerations" merge (dict "indent" 4) $prometheusArgs }}
{{- end }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus-operator
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $prometheusArgs }}
      tolerations:
        {{ template "tolerations" $prometheusArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: x509-certificate-exporter
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $x509ExporterArgs }}
      tolerations:
        {{ template "tolerations" $x509ExporterArgs }}
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: x509-certificate-exporter-data-plane
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $x509ExporterArgs }}
      tolerations:
        {{ template "tolerations" $x509ExporterArgs }}

{{ if eq .spec.distribution.modules.monitoring.type "mimir" -}}
{{- $mimirArgs := dict "module" "monitoring" "package" "mimir" "spec" .spec -}}
{{- if .checks.storageClassAvailable }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mimir-distributed-compactor
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $mimirArgs }}
      tolerations:
        {{ template "tolerations" $mimirArgs }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mimir-distributed-ingester
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $mimirArgs }}
      tolerations:
        {{ template "tolerations" $mimirArgs }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mimir-distributed-store-gateway
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $mimirArgs }}
      tolerations:
        {{ template "tolerations" $mimirArgs }}
{{- if eq .spec.distribution.modules.monitoring.mimir.backend "minio" }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: minio-monitoring
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $mimirArgs }}
      tolerations:
        {{ template "tolerations" $mimirArgs }}
{{- end }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mimir-distributed-continuous-test
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $mimirArgs }}
      tolerations:
        {{ template "tolerations" $mimirArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mimir-distributed-distributor
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $mimirArgs }}
      tolerations:
        {{ template "tolerations" $mimirArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mimir-distributed-gateway
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $mimirArgs }}
      tolerations:
        {{ template "tolerations" $mimirArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mimir-distributed-querier
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $mimirArgs }}
      tolerations:
        {{ template "tolerations" $mimirArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mimir-distributed-query-frontend
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $mimirArgs }}
      tolerations:
        {{ template "tolerations" $mimirArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mimir-distributed-query-scheduler
  namespace: monitoring
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $mimirArgs }}
      tolerations:
        {{ template "tolerations" $mimirArgs }}
---
{{- end }}
{{ end }}
