{{- if eq .spec.distribution.modules.auth.provider.type "sso" -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  {{- if eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager" }}
  annotations:
    {{ template "certManagerClusterIssuer" . }}
  {{- end }}
  name: pomerium
  namespace: pomerium
spec:
  ingressClassName: {{ template "ingressClass" (dict "module" "auth" "package" "pomerium" "type" "internal" "spec" .spec) }}
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
{{- template "ingressTls" (dict "module" "auth" "package" "pomerium" "prefix" "pomerium.internal." "spec" .spec) }}
{{- end }}
