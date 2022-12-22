{{- if eq .spec.distribution.modules.auth.provider.type "basicAuth" -}}
{{- $username := .spec.distribution.modules.auth.provider.basicAuth.username -}}
{{- $password := .spec.distribution.modules.auth.provider.basicAuth.password -}}
{{- $namespaces := list "gatekeeper-system" "ingress-nginx" "logging" "monitoring" -}}
{{ range $namespace := $namespaces -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: basic-auth
  namespace: {{ $namespace }}
type: kubernetes.io/basic-auth
data:
  auth: {{ htpasswd $username $password }}
{{ end }}
{{- end -}}
