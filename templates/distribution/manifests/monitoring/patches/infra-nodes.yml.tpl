{{- $amArgs := dict "module" "monitoring" "spec" .spec "component" "alertmanager" -}}
{{- $beArgs := dict "module" "monitoring" "spec" .spec "component" "blackboxExporter" -}}
{{- $gArgs := dict "module" "monitoring" "spec" .spec "component" "grafana" -}}
{{- $ksmArgs := dict "module" "monitoring" "spec" .spec "component" "kubeStateMetrics" -}}
{{- $pArgs := dict "module" "monitoring" "spec" .spec "component" "prometheus" -}}

---
apiVersion: monitoring.coreos.com/v1
kind: Alertmanager
metadata:
  name: main
  namespace: monitoring
spec:
  nodeSelector:
    {{ template "nodeSelector" ( merge $amArgs (dict "indent" 4) ) }}
  tolerations:
    {{ template "tolerations" ( merge $amArgs (dict "indent" 4) ) }}
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
        {{ template "nodeSelector" $beArgs }}
      tolerations:
        {{ template "tolerations" $beArgs }}
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
        {{ template "nodeSelector" $gArgs }}
      tolerations:
        {{ template "tolerations" $gArgs }}
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
        {{ template "nodeSelector" $ksmArgs }}
      tolerations:
        {{ template "tolerations" $ksmArgs }}
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
        {{ template "nodeSelector" $pArgs }}
      tolerations:
        {{ template "tolerations" $pArgs }}
---
apiVersion: monitoring.coreos.com/v1
kind: Prometheus
metadata:
  name: k8s
  namespace: monitoring
spec:
  nodeSelector:
    {{ template "nodeSelector" merge $pArgs (dict "indent" 4) }}
  tolerations:
    {{ template "tolerations" merge $pArgs (dict "indent" 4) }}
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
        {{ template "nodeSelector" $pArgs }}
      tolerations:
        {{ template "tolerations" $pArgs }}
