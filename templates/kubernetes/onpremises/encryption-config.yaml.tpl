{{- if (index .spec.kubernetes "advanced") }}
{{- if (index .spec.kubernetes.advanced "encryption") }}
{{- if (index .spec.kubernetes.advanced.encryption "configuration") }}
{{- .spec.kubernetes.advanced.encryption.configuration }}
{{- end }}
{{- end }}
{{- end }}
