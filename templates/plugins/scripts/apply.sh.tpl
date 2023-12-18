#!/usr/bin/env sh

set -e

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"

{{ if (index .spec "plugins") -}}
{{ if (index .spec.plugins "kustomize") -}}
{{- if (index .spec.plugins "kustomize") -}}

{{ range .spec.plugins.kustomize }}

$kustomizebin build --load_restrictor LoadRestrictionsNone {{ .folder }} > out.yaml

output=$(cat out.yaml | $yqbin 'select(.kind == "CustomResourceDefinition")')

if [ -n "$output" ]; then
  < out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin apply -f - --server-side --force-conflicts
  < out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlbin wait --for condition=established --timeout=60s -f -
  < out.yaml $kubectlbin apply -f - --server-side --force-conflicts
else
  < out.yaml $kubectlbin apply -f - --server-side --force-conflicts
fi

{{- end -}}

{{- end -}}
{{- end }}
{{- end }}
