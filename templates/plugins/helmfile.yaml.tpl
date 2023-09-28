{{ if (index .spec "plugins") -}}

{{ if (index .spec.plugins "helm") -}}
{{ if (index .spec.plugins.helm "repositories") -}}
repositories:
{{- toYaml .spec.plugins.helm.repositories | nindent 2 }}
{{- end }}
{{- end }}

{{ if or (and (index .spec.plugins "helm") (index .spec.plugins.helm "releases")) (index .spec.plugins "kustomize") -}}
releases:
{{- if (and (index .spec.plugins "helm") (index .spec.plugins.helm "releases")) -}}
{{- toYaml .spec.plugins.helm.releases | nindent 2 }}
{{- end -}}
{{- if (index .spec.plugins "kustomize") -}}
{{ range .spec.plugins.kustomize }}
  - name: {{ .name }}
    namespace: {{ .namespace }}
    chart: {{ .folder }}
{{- end -}}
{{- end -}}
{{- end }}

{{- end }}

helmBinary: {{ .paths.helm }}
### TODO, decomment when new release is released kustomizeBinary: {{ .paths.kustomize }}

helmDefaults:
  args:
    {{- if .paths.kubeconfig -}}
    - --kubeconfig={{ .paths.kubeconfig }}
    {{- end }}
