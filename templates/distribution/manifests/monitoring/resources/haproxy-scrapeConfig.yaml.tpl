
{{- if and (eq .spec.distribution.common.provider.type "none") }}
{{- if hasKeyAny .spec "kubernetes" }}
{{- if .spec.kubernetes.loadBalancers.enabled }}
---
apiVersion: monitoring.coreos.com/v1alpha1
kind: ScrapeConfig
metadata:
  name: haproxy-lb
  namespace: monitoring
  labels:
    prometheus: k8s
spec:
  staticConfigs:
    - labels:
        job: prometheus
      targets:
        {{- range $lb := .spec.kubernetes.loadBalancers.hosts }}
        - {{ $lb.ip }}:8405
        {{- end }}
{{- end }}
{{- end }}
{{- end }}
