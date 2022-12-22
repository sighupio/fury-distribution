{{ if eq .spec.distribution.modules.ingress.nginx.tls.provider "secret" -}}
- op: add
  path: /spec/template/spec/containers/0/args/-
  value: "--default-ssl-certificate=ingress-nginx/ingress-nginx-global-tls-cert"
{{ end }}