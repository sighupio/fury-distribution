---
apiVersion: monitoring.coreos.com/v1
kind: Prometheus
metadata:
  name: k8s
  namespace: monitoring
spec:
  externalLabels:
    k8s_cluster: {{ .metadata.name }}
  externalUrl: https://{{ template "prometheusUrl" .spec }}
  {{- if hasKeyAny .spec.distribution.modules.monitoring.prometheus "resources" }}
  resources:
    {{ .spec.distribution.modules.monitoring.prometheus.resources | toYaml | indent 4 | trim }}
  {{- end }}
  retention: {{ .spec.distribution.modules.monitoring.prometheus.retentionTime }}
  retentionSize: {{ .spec.distribution.modules.monitoring.prometheus.retentionSize }}
  storage:
    volumeClaimTemplate:
      spec:
        accessModes:
          - ReadWriteOnce
        resources:
          requests:
            storage: {{ .spec.distribution.modules.monitoring.prometheus.storageSize }}
