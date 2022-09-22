{{- define "ingressClass" -}}
  {{ if .modules.auth.overrides.ingresses.dex.ingressClass -}}
    {{ .modules.auth.overrides.ingresses.dex.ingressClass }}
  {{- else -}}
    {{ template "ingressClassExternal" . }}
  {{- end }}
{{- end -}}
{{- define "host" -}}
  {{ if .modules.auth.overrides.ingresses.dex.host -}}
    {{ .modules.auth.overrides.ingresses.dex.host }}
  {{- else -}}
    {{ print "login." .modules.ingress.baseDomain }}
  {{- end }}
{{- end -}}
{{- define "tls" -}}
  {{ if eq .modules.ingress.nginx.tls.provider "none" -}}
  {{ else }}
  tls:
  - hosts:
    - {{ template "host" . }}
  {{ if eq .modules.ingress.nginx.tls.provider "certManager" -}}
    secretName: dex-tls
  {{- end }}
  {{- end }}
{{- end -}}
{{- if eq .modules.auth.provider.type "sso" -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dex
  namespace: kube-system
  {{- if eq .modules.ingress.nginx.tls.provider "certManager" }}
  annotations:
    {{ template "certManagerClusterIssuer" . }}
  {{- end }}
spec:
  # Needs to be externally available in order to act as callback from GitHub.
  ingressClassName: {{ template "ingressClass" . }}
  rules:
    - host: {{ template "host" . }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: dex
                port:
                  name: http
{{- template "tls" . }}
{{- end }}
