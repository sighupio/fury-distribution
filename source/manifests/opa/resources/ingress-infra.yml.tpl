{{- define "ingressClass" -}}
  {{ if .modules.policy.overrides.ingresses.gpm.ingressClass -}}
    {{ .modules.policy.overrides.ingresses.gpm.ingressClass }}
  {{- else -}}
    {{ template "ingressClassInternal" . }}
  {{- end }}
{{- end -}}
{{- define "host" -}}
  {{ if .modules.policy.overrides.ingresses.gpm.host -}}
    {{ .modules.policy.overrides.ingresses.gpm.host }}
  {{- else -}}
    {{ print "gpm." .modules.ingress.baseDomain }}
  {{- end }}
{{- end -}}
{{- define "tls" -}}
  {{ if eq .modules.ingress.nginx.tls.provider "none" -}}
  {{ else }}
  tls:
  - hosts:
    - {{ template "host" . }}
  {{ if eq .modules.ingress.nginx.tls.provider "certManager" -}}
    secretName: gpm-tls
  {{- end }}
  {{- end }}
{{- end -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    forecastle.stakater.com/expose: "true"
    forecastle.stakater.com/appName: "Gatekeeper Policy Manager"
    forecastle.stakater.com/icon: "https://raw.githubusercontent.com/sighupio/gatekeeper-policy-manager/master/app/static-content/logo.svg"
    {{ if not .modules.policy.overrides.ingresses.gpm.disableAuth }}{{ template "ingressAuth" . }}{{ end }}
    {{ template "certManagerClusterIssuer" . }}
  name: gpm
  namespace: gatekeeper-system
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
            name: gatekeeper-policy-manager
            port:
              name: http
{{- template "tls" . }}
