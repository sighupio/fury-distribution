#!/usr/bin/env sh

set -e

## aggiornamento master TODO UNO ALLA VOLTA
{{- range $h := .spec.kubernetes.masters.hosts }}
ansible-playbook 55.upgrade-control-plane.yml --limit "{{ $h.name }}" --become
{{- end }}

{{- range $n := .spec.kubernetes.nodes }}
    {{- range $h := $n.hosts }}
ansible-playbook 56.upgrade-worker-nodes.yml --limit "{{ $h.name }}"
    {{- end }}
{{- end }}
