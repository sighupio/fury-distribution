{{- if eq .spec.distribution.modules.auth.provider.type "sso" -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  {{- if eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager" }}
  annotations:
    {{ template "certManagerClusterIssuer" . }}
  {{- end }}
  name: dex
  namespace: kube-system
spec:
  # Needs to be externally available in order to act as callback from GitHub.
  ingressClassName: {{ template "ingressClass" (dict "module" "auth" "package" "dex" "type" "external" "spec" .spec) }}
  rules:
    - host: {{ template "dexUrl" .spec }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: dex
                port:
                  name: http
{{- template "ingressTlsAuth" (dict "module" "auth" "package" "dex" "prefix" "login." "spec" .spec) }}
{{- end }}
