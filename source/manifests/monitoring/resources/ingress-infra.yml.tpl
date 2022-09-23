---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    forecastle.stakater.com/expose: "true"
    forecastle.stakater.com/appName: "Alertmanager"
    forecastle.stakater.com/icon: "https://github.com/stakater/ForecastleIcons/raw/master/alert-manager.png"
    {{ if not .modules.ingress.overrides.ingresses.forecastle.disableAuth }}{{ template "ingressAuth" . }}{{ end }}
    {{ template "certManagerClusterIssuer" . }}
  name: alertmanager
  namespace: monitoring
spec:
  ingressClassName: {{ template "ingressClass" (dict "module" "monitoring" "package" "alertmanager" "type" "internal" "spec" .) }}
  rules:
    - host: {{ template "alertmanagerUrl" . }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: alertmanager-main
                port:
                  name: web
{{- template "ingressTls" (dict "module" "monitoring" "package" "alertmanager" "prefix" "alertmanager.internal." "spec" .) }}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    forecastle.stakater.com/expose: "true"
    forecastle.stakater.com/appName: "Grafana"
    forecastle.stakater.com/icon: "https://github.com/stakater/ForecastleIcons/raw/master/grafana.png"
    {{ if not .modules.ingress.overrides.ingresses.forecastle.disableAuth }}{{ template "ingressAuth" . }}{{ end }}
    {{ template "certManagerClusterIssuer" . }}
  name: grafana
  namespace: monitoring
spec:
  ingressClassName: {{ template "ingressClass" (dict "module" "monitoring" "package" "grafana" "type" "internal" "spec" .) }}
  rules:
    - host: {{ template "ingressHost" (dict "module" "monitoring" "package" "grafana" "prefix" "grafana.internal." "spec" .) }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: grafana
                port:
                  name: http
{{- template "ingressTls" (dict "module" "monitoring" "package" "grafana" "prefix" "grafana.internal." "spec" .) }}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    forecastle.stakater.com/expose: "true"
    forecastle.stakater.com/appName: "Prometheus"
    forecastle.stakater.com/icon: "https://github.com/stakater/ForecastleIcons/raw/master/prometheus.png"
    {{ if not .modules.ingress.overrides.ingresses.forecastle.disableAuth }}{{ template "ingressAuth" . }}{{ end }}
    {{ template "certManagerClusterIssuer" . }}
  name: prometheus
  namespace: monitoring
spec:
  ingressClassName: {{ template "ingressClass" (dict "module" "monitoring" "package" "prometheus" "type" "internal" "spec" .) }}
  rules:
    - host: {{ template "prometheusUrl" . }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: prometheus-k8s
                port:
                  name: web
{{- template "ingressTls" (dict "module" "monitoring" "package" "prometheus" "prefix" "prometheus.internal." "spec" .) }}
