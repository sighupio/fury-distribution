{{ define "commonNodeSelector" }}
  {{- $indent := .indent | default 8 -}}
  {{ .spec.distribution.common.nodeSelector | toYaml | indent $indent | trim }}
{{- end -}}

{{ define "commonTolerations" }}
  {{- $indent := .indent | default 8 -}}
  {{ .spec.distribution.common.tolerations | toYaml | indent $indent | trim }}
{{- end -}}

{{ define "globalIngressClass" }}
  {{- if eq .spec.distribution.modules.ingress.nginx.type "single" -}}
    "nginx"
  {{- else -}}
    {{ .type }}
  {{- end -}}
{{ end }}

{{/* ingressClass { module: <module>, package: <package>, type: "internal|external", spec: "." } */}}
{{ define "ingressClass" }}
  {{- $module := index .spec.distribution.modules .module -}}
  {{- $package := index $module.overrides.ingresses .package -}}
  {{- $ingressClass := $package.ingressClass -}}
  {{- if $ingressClass -}}
    {{ $ingressClass }}
  {{- else -}}
    {{ template "globalIngressClass" (dict "spec" .spec "type" .type) }}
  {{- end -}}
{{ end }}

{{/* ingressHost { module: <module>, package: <package>, prefix: <prefix>, spec: "." } */}}
{{ define "ingressHost" }}
  {{- $module := index .spec.distribution.modules .module -}}
  {{- $package := index $module.overrides.ingresses .package -}}
  {{- $host := $package.host -}}
  {{- if $host -}}
    {{ $host }}
  {{- else -}}
    {{ print .prefix .spec.distribution.modules.ingress.baseDomain }}
  {{- end -}}
{{ end }}

{{/* ingressTls { module: <module>, package: <package>, prefix: <prefix>, spec: "." } */}}
{{- define "ingressTls" -}}
{{ if eq .spec.distribution.modules.ingress.nginx.tls.provider "none" -}}
  {{ else }}
  tls:
    - hosts:
      - {{ template "ingressHost" . }}
    {{- if eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager" }}
      secretName: {{ lower .package }}-tls
    {{- end }}
{{- end }}
{{- end -}}

{{ define "pomeriumHost" }}
  {{- template "ingressHost" (dict "module" "auth" "package" "pomerium" "prefix" "pomerium.internal." "spec" .spec) -}}
{{ end }}

{{ define "ingressAuthUrl" -}}
"https://{{ template "pomeriumHost" . }}/verify?uri=$scheme://$host$request_uri"
{{- end }}

{{ define "ingressAuthSignin" -}}
"https://{{ template "pomeriumHost" . }}/?uri=$scheme://$host$request_uri"
{{- end }}

{{ define "ingressAuth" }}
{{- if eq .spec.distribution.modules.auth.provider.type "sso" -}}
    nginx.ingress.kubernetes.io/auth-url: {{ template "ingressAuthUrl" . }}
    nginx.ingress.kubernetes.io/auth-signin: {{ template "ingressAuthSignin" . }}
{{- else if eq .spec.distribution.modules.auth.provider.type "basicAuth" -}}
    nginx.ingress.kubernetes.io/auth-type: basic
    nginx.ingress.kubernetes.io/auth-secret: basic-auth
    nginx.ingress.kubernetes.io/auth-realm: 'Authentication Required'
{{- end -}}
{{ end }}

{{ define "certManagerClusterIssuer" }}
{{- if eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager" -}}
cert-manager.io/cluster-issuer: {{ .spec.distribution.modules.ingress.certManager.clusterIssuer.name }}
{{- end -}}
{{ end }}

{{ define "alertmanagerUrl" }}
  {{- template "ingressHost" (dict "module" "monitoring" "package" "alertmanager" "prefix" "alertmanager.internal." "spec" .) -}}
{{ end }}

{{ define "prometheusUrl" }}
  {{- template "ingressHost" (dict "module" "monitoring" "package" "prometheus" "prefix" "prometheus.internal." "spec" .) -}}
{{ end }}
