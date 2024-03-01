{{- if (index .spec.kubernetes "encryption") }}
{{- if (index .spec.kubernetes.encryption "configuration") }}
{{- .spec.kubernetes.encryption.configuration }}
{{- end }}
{{- end }}