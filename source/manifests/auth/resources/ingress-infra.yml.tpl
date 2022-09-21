{{- define "ingressClass" }}
  {{ if .modules.auth.overrides.ingresses.dex.ingressClass -}}
    {{ .modules.auth.overrides.ingresses.dex.ingressClass }}
  {{- else -}}
    {{ template "ingressClass" . }}
  {{- end }}
{{- end -}}
{{- define "host" -}}
  {{ if .modules.auth.overrides.ingresses.dex.host -}}
    {{ .modules.auth.overrides.ingresses.dex.host }}
  {{- else -}}
    {{ print "login." .modules.ingress.baseDomain }}
  {{- end }}
{{- end -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dex
  namespace: kube-system
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-aws" # FIXME
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
  tls:
    - hosts:
      - {{ template "host" . }}
      secretName: dex-tls
