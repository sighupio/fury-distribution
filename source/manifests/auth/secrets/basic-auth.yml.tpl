{{- if eq .modules.auth.provider.type "basicAuth" -}}
{{- $username := .modules.auth.provider.basicAuth.username -}}
{{- $password := .modules.auth.provider.basicAuth.password -}}
{{- $namespaces := list "gatekeeper-system" "ingress-nginx" "logging" "monitoring" -}}
{{ range $namespace := $namespaces -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: basic-auth
  namespace: {{ $namespace }}
data:
  auth: {{ htpasswd $username $password }}
{{ end }}
{{- end -}}
