# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{ if eq .spec.distribution.modules.auth.provider.type "sso" }}
address: ":8080"
metrics_address: ":9090"

insecure_server: true
autocert: false

routes:
  - from: https://{{ template "prometheusUrl" .spec }}
    to: http://prometheus-k8s.monitoring.svc.cluster.local:9090
    policy:
      - allow:
          and:
            - authenticated_user: true
  - from: https://{{ template "alertmanagerUrl" .spec }}
    to: http://alertmanager-main.monitoring.svc.cluster.local:9093
    policy:
      - allow:
          and:
            - authenticated_user: true
  - from: https://{{ template "grafanaUrl" .spec }}
    to: http://grafana.monitoring.svc.cluster.local:3000
    allow_websockets: true
    host_rewrite_header: true
    preserve_host_header: true
    policy:
      - allow:
          and:
            - authenticated_user: true
  - from: https://{{ template "forecastleUrl" .spec }}
    to: http://forecastle.ingress-nginx.svc.cluster.local
    policy:
      - allow:
          and:
            - authenticated_user: true
  - from: https://{{ template "opensearchDashboardsUrl" .spec }}
    to: http://opensearch-dashboards.logging.svc.cluster.local:5601
    policy:
      - allow:
          and:
            - authenticated_user: true
  - from: https://{{ template "minioLoggingUrl" .spec }}
    to: http://minio-logging-console.logging.svc.cluster.local:9001
    allow_websockets: true
    preserve_host_header: true
    policy:
      - allow:
          and:
            - authenticated_user: true
  - from: https://{{ template "minioTracingUrl" .spec }}
    to: http://minio-tracing-console.tracing.svc.cluster.local:9001
    allow_websockets: true
    preserve_host_header: true
    policy:
      - allow:
          and:
            - authenticated_user: true
  - from: https://{{ template "minioMonitoringUrl" .spec }}
    to: http://minio-monitoring-console.monitoring.svc.cluster.local:9001
    allow_websockets: true
    preserve_host_header: true
    policy:
      - allow:
          and:
            - authenticated_user: true
  - from: https://{{ template "gpmUrl" .spec }}
    to: http://gatekeeper-policy-manager.gatekeeper-system.svc.cluster.local
    policy:
      - allow:
          and:
            - authenticated_user: true
{{ .spec.distribution.modules.auth.pomerium.policy | indent 2 }}
{{ end }}
