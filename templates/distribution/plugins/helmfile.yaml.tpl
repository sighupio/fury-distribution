{{ if and .spec.plugins.helm .spec.plugins.helm.repositories -}}
repositories:
{{- toYaml .spec.plugins.helm.repositories | nindent 2 }}
{{- end }}

{{ if or (and .spec.plugins.helm .spec.plugins.helm.releases) .spec.plugins.kustomize -}}
releases:
{{- if .spec.plugins.helm.releases -}}
{{- toYaml .spec.plugins.helm.releases | nindent 2 }}
{{- end -}}
{{- if .spec.plugins.kustomize -}}
{{ range .spec.plugins.kustomize }}
  - name: {{ .name }}
    namespace: {{ .namespace }}
    chart: {{ .folder }}
{{- end -}}
{{- end -}}
{{- end }}

helmBinary: {{ .paths.helm }}

helmDefaults:
  args:
    {{- if .paths.kubeconfig -}}
    - --kubeconfig={{ .paths.kubeconfig }}
    {{- end }}
