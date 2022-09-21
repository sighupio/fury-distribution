{{- if eq .modules.auth.provider.type "sso" -}}
{{ .modules.auth.pomerium.policy }}
{{- end }}
