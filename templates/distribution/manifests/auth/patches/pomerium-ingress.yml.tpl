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
  # Needs to be externally available if the user wants to protect other applications in the cluster
  ingressClassName: {{ template "ingressClass" (dict "module" "auth" "package" "pomerium" "type" "external" "spec" .spec) }}
  rules:
    - host: {{ template "pomeriumUrl" .spec }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: pomerium
                port:
                  number: 80
{{- template "ingressTlsAuth" (dict "module" "auth" "package" "pomerium" "prefix" "pomerium." "spec" .spec) }}
{{- end }}
