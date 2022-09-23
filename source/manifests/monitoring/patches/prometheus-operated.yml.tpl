---
apiVersion: monitoring.coreos.com/v1
kind: Prometheus
metadata:
  name: k8s
  namespace: monitoring
spec:
  externalLabels:
    k8s_cluster: {{ .metadata.name }}
  externalUrl: https://{{ template "prometheusUrl" . }}
  resources:
    {{ .modules.monitoring.prometheus.resources | toYaml | indent 4 | trim }}
  retention: {{ .modules.monitoring.prometheus.retentionTime }}
  retentionSize: {{ .modules.monitoring.prometheus.retentionSize }}
  storage:
    volumeClaimTemplate:
      spec:
        accessModes:
          - ReadWriteOnce
        resources:
          requests:
            storage: {{ .modules.monitoring.prometheus.storageSize }}
