{{- define "ingressClass" -}}
  {{ if .modules.ingress.overrides.ingresses.forecastle.ingressClass -}}
    {{ .modules.ingress.overrides.ingresses.forecastle.ingressClass }}
  {{- else -}}
    {{ template "ingressClassInternal" . }}
  {{- end }}
{{- end -}}
{{- define "host" -}}
  {{ if .modules.ingress.overrides.ingresses.forecastle.host -}}
    {{ .modules.ingress.overrides.ingresses.forecastle.host }}
  {{- else -}}
    {{ print "directory." .modules.ingress.baseDomain }}
  {{- end }}
{{- end -}}
{{- define "tls" -}}
  {{ if eq .modules.ingress.nginx.tls.provider "none" -}}
  {{ else }}
  tls:
  - hosts:
    - {{ template "host" . }}
  {{ if eq .modules.ingress.nginx.tls.provider "certManager" -}}
    secretName: directory-tls
  {{- end }}
  {{- end }}
{{- end -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    forecastle.stakater.com/expose: "true"
    forecastle.stakater.com/appName: "Forecastle"
    forecastle.stakater.com/icon: "https://raw.githubusercontent.com/stakater/Forecastle/master/assets/web/forecastle-round-100px.png"
    {{ if not .modules.ingress.overrides.ingresses.forecastle.disableAuth }}{{ template "ingressAuth" . }}{{ end }}
    {{ template "certManagerClusterIssuer" . }}
  name: forecastle
  namespace: ingress-nginx
spec:
  ingressClassName: {{ template "ingressClass" . }}
  rules:
  - host: {{ template "host" . }}
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: forecastle
            port:
              name: http
{{- template "tls" . }}
