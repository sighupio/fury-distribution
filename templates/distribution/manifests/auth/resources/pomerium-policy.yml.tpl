{{- if eq .spec.distribution.modules.auth.provider.type "sso" -}}
address: ":8080"
metrics_address: ":9090"
grcp_address: ":8080"

insecure_server: true
autocert: false

policy:
  - from: https://{{ template "prometheusUrl" .spec }}
    to: http://prometheus-k8s.monitoring.svc.cluster.local:9090
    allow_any_authenticated_user: true
  - from: https://{{ template "alertmanagerUrl" .spec }}
    to: http://alertmanager-main.monitoring.svc.cluster.local:9093
    allow_any_authenticated_user: true
  - from: https://{{ template "grafanaUrl" .spec }}
    to: http://grafana.monitoring.svc.cluster.local:3000
    allow_any_authenticated_user: true
  - from: https://{{ template "forecastleUrl" .spec }}
    to: http://forecastle.ingress-nginx.svc.cluster.local
    allow_any_authenticated_user: true
  - from: https://{{ template "cerebroUrl" .spec }}
    to: http://cerebro.logging.svc.cluster.local:9000
    allow_any_authenticated_user: true
  - from: https://{{ template "opensearchDashboardsUrl" .spec }}
    to: http://opensearch-dashboards.logging.svc.cluster.local:5601
    allow_any_authenticated_user: true
  - from: https://{{ template "minioUrl" .spec }}
    to: http://minio.logging.svc.cluster.local:9000
    allow_any_authenticated_user: true
  - from: https://{{ template "gpmUrl" .spec }}
    to: http://gatekeeper-policy-manager.gatekeeper-system.svc.cluster.local
    allow_any_authenticated_user: true
{{ .spec.distribution.modules.auth.pomerium.policy | indent 2 }}
{{- end }}
