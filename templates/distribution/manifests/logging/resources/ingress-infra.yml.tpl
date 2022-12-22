---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    forecastle.stakater.com/expose: "true"
    forecastle.stakater.com/appName: "Cerebro"
    forecastle.stakater.com/icon: "https://github.com/stakater/ForecastleIcons/raw/master/cerebro.png"
    {{ if not .spec.distribution.modules.logging.overrides.ingresses.cerebro.disableAuth }}{{ template "ingressAuth" . }}{{ end }}
    {{ template "certManagerClusterIssuer" . }}
  name: cerebro
  namespace: logging
spec:
  ingressClassName: {{ template "ingressClass" (dict "module" "logging" "package" "cerebro" "type" "internal" "spec" .spec) }}
  rules:
    - host: {{ template "ingressHost" (dict "module" "logging" "package" "cerebro" "prefix" "cerebro.internal." "spec" .spec) }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: cerebro
                port:
                  name: http
{{- template "ingressTls" (dict "module" "logging" "package" "cerebro" "prefix" "cerebro.internal." "spec" .spec) }}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    forecastle.stakater.com/expose: "true"
    forecastle.stakater.com/appName: "Opensearch Dashboards"
    forecastle.stakater.com/icon: "https://opensearch.org/assets/brand/PNG/Mark/opensearch_mark_default.png"
    {{ if not .spec.distribution.modules.logging.overrides.ingresses.opensearchDashboards.disableAuth }}{{ template "ingressAuth" . }}{{ end }}
    {{ template "certManagerClusterIssuer" . }}
  name: opensearch-dashboards
  namespace: logging
spec:
  ingressClassName: {{ template "ingressClass" (dict "module" "logging" "package" "opensearchDashboards" "type" "internal" "spec" .spec) }}
  rules:
    - host: {{ template "ingressHost" (dict "module" "logging" "package" "opensearchDashboards" "prefix" "opensearch-dashboards.internal." "spec" .spec) }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: opensearch-dashboards
                port:
                  name: http
{{- template "ingressTls" (dict "module" "logging" "package" "opensearchDashboards" "prefix" "opensearch-dashboards.internal." "spec" .spec) }}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    forecastle.stakater.com/expose: "true"
    forecastle.stakater.com/appName: "MinIO Logging"
    forecastle.stakater.com/icon: "https://min.io/resources/img/logo/MINIO_Bird.png"
    {{ if not .spec.distribution.modules.logging.overrides.ingresses.minio.disableAuth }}{{ template "ingressAuth" . }}{{ end }}
    {{ template "certManagerClusterIssuer" . }}
  name: minio
  namespace: logging
spec:
  ingressClassName: {{ template "ingressClass" (dict "module" "logging" "package" "minio" "type" "internal" "spec" .spec) }}
  rules:
    - host: {{ template "ingressHost" (dict "module" "logging" "package" "minio" "prefix" "minio.internal." "spec" .spec) }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: minio
                port:
                  name: minio
{{- template "ingressTls" (dict "module" "logging" "package" "minio" "prefix" "minio.internal." "spec" .spec) }}
