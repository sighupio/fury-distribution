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

{{ if (index .spec "plugins") -}}
{{ if (index .spec.plugins "kustomize") -}}
{{- if (index .spec.plugins "kustomize") -}}

{{ range .spec.plugins.kustomize }}

$kustomizebin build --load_restrictor LoadRestrictionsNone {{ .folder }} > out.yaml

if [ "$dryrun" != "" ]; then
  exit 0
fi

if [[ $(< out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")') ]]; then
   < out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd apply -f - --server-side --force-conflicts
   < out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd wait --for condition=established --timeout=60s -f -
fi

< out.yaml $kubectlcmd apply -f - --server-side --force-conflicts

{{- end -}}

{{- end -}}
{{- end }}
{{- end }}
