{{ define "commonNodeSelector" }}{{ .common.nodeSelector | toYaml | indent 8 | trim }}{{ end }}

{{ define "commonTolerations" }}{{ .common.tolerations | toYaml | indent 8 | trim }}{{ end }}

{{ define "ingressClass" }}{{- if eq .modules.ingress.nginx.type "single" -}} "nginx" {{- else -}} "internal" {{- end -}}{{ end }}
