#!/usr/bin/env sh

set -e

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"

if [ "$1" = "true" ]; then
  dryrun="--dry-run=server"
else
  dryrun=""
fi

if [ -n "$2" ]; then
  kubeconfig="--kubeconfig=$2"
else
  kubeconfig=""
fi

kubectlcmd="$kubectlbin $dryrun $kubeconfig"

if [ "$dryrun" != "" ]; then
  exit 0
fi

{{ if (index .spec "plugins") -}}
{{ if (index .spec.plugins "kustomize") -}}
{{- if (index .spec.plugins "kustomize") -}}

{{ range .spec.plugins.kustomize }}

$kustomizebin build --load_restrictor LoadRestrictionsNone {{ .folder }} > out.yaml

output=$(cat out.yaml | $yqbin 'select(.kind == "CustomResourceDefinition")')

if [ -n "$output" ]; then
  < out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd apply -f - --server-side --force-conflicts
  < out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd wait --for condition=established --timeout=60s -f -
  < out.yaml $kubectlcmd apply -f - --server-side --force-conflicts
else
  < out.yaml $kubectlcmd apply -f - --server-side --force-conflicts
fi


{{- end -}}

{{- end -}}
{{- end }}
{{- end }}
