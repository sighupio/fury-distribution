{{ define "commonNodeSelector" }}{{ .common.nodeSelector | toYaml | indent 8 | trim }}{{ end }}

{{ define "commonTolerations" }}{{ .common.tolerations | toYaml | indent 8 | trim }}{{ end }}

{{ define "ingressClassExternal" }}
{{- if eq .modules.ingress.nginx.type "single" -}}
  "nginx"
{{- else -}}
  "external"
{{- end -}}
{{ end }}

{{ define "ingressClassInternal" }}
{{- if eq .modules.ingress.nginx.type "single" -}}
  "nginx"
{{- else -}}
  "internal"
{{- end -}}
{{ end }}

{{ define "pomeriumHost" }}
  {{- if .modules.auth.overrides.ingresses.pomerium.host -}}
    {{ .modules.auth.overrides.ingresses.pomerium.host }}
  {{- else -}}
    {{ print "pomerium.internal." .modules.ingress.baseDomain }}
  {{- end -}}
{{ end }}

{{ define "ingressAuthUrl" }}
"https://{{ template "pomeriumHost" . }}/verify?uri=$scheme://$host$request_uri"
{{ end }}

{{ define "ingressAuthSignin" }}
"https://{{ template "pomeriumHost" . }}/?uri=$scheme://$host$request_uri"
{{ end }}

{{ define "ingressAuth" }}
{{- if eq .modules.auth.provider.type "sso" -}}
  nginx.ingress.kubernetes.io/auth-url: {{ template "ingressAuthUrl" . }}
  nginx.ingress.kubernetes.io/auth-signin: {{ template "ingressAuthSignin" . }}
{{- else if eq .modules.auth.provider.type "basicAuth" -}}
  nginx.ingress.kubernetes.io/auth-type: basic
  nginx.ingress.kubernetes.io/auth-secret: basic-auth
  nginx.ingress.kubernetes.io/auth-realm: 'Authentication Required'
{{- end -}}
{{ end }}

{{ define "certManagerClusterIssuer" }}
{{- if eq .modules.ingress.nginx.tls.provider "certManager" -}}
cert-manager.io/cluster-issuer: {{ .modules.ingress.certManager.clusterIssuer.name }}
{{- end -}}
{{ end }}
