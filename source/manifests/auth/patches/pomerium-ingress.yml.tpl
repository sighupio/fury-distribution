{{- define "ingressClass" -}}
  {{ if .modules.auth.overrides.ingresses.pomerium.ingressClass -}}
    {{ .modules.auth.overrides.ingresses.pomerium.ingressClass }}
  {{- else -}}
    {{ template "ingressClassInternal" . }}
  {{- end }}
{{- end -}}
{{- if eq .modules.auth.provider.type "sso" -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: pomerium
  namespace: pomerium
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-aws" # FIXME
spec:
  ingressClassName: {{ template "ingressClass" . }}
  rules:
    - host: {{ template "pomeriumHost" . }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: pomerium
                port:
                  number: 80
  tls:
    - hosts:
        - {{ template "pomeriumHost" . }}
      secretName: pomerium-tls
{{- end }}
