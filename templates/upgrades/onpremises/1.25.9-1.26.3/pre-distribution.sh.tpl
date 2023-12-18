#!/usr/bin/env sh

set -e

kubectlbin="{{ .paths.kubectl }}"

{{- if eq .spec.distribution.modules.policy.type "gatekeeper" }}
$kubectlbin delete validatingwebhookconfiguration gatekeeper-validating-webhook-configuration
{{- end }}
