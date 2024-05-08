#!/usr/bin/env sh

set -e

kustomizebin="{{ .paths.kustomize }}"
kappbin="{{ .paths.kapp }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"

{{ if (index .spec "plugins") -}}
{{ if (index .spec.plugins "kustomize") -}}
{{- if (index .spec.plugins "kustomize") -}}

{{ range .spec.plugins.kustomize }}

$kustomizebin build --load_restrictor LoadRestrictionsNone {{ .folder }} > out.yaml

$kappbin deploy -a kfd-plugin-{{ .name }} -n kube-system -f out.yaml --allow-all-ns -y --default-label-scoping-rules=false

{{- end -}}

{{- end -}}
{{- end }}
{{- end }}
