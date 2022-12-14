{{- if eq .spec.distribution.modules.auth.provider.type "sso" -}}
{{ .spec.distribution.modules.auth.pomerium.policy }}
{{- end }}
