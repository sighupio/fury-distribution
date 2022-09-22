{{ if eq .modules.ingress.nginx.tls.provider "secret" -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: ingress-nginx-global-tls-cert
  namespace: ingress-nginx
type: kubernetes.io/tls
data:
  ca.crt: {{ .modules.ingress.nginx.tls.secret.ca | b64enc }}
  tls.crt: {{ .modules.ingress.nginx.tls.secret.cert | b64enc }}
  tls.key: {{ .modules.ingress.nginx.tls.secret.key | b64enc }}
{{- end }}
