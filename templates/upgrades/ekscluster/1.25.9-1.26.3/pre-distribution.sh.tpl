#!/usr/bin/env sh

set -e

kubectlbin="{{ .paths.kubectl }}"

$kubectlbin delete deployment ebs-csi-controller -n kube-system
$kubectlbin delete daemonset ebs-csi-node -n kube-system

{{- if eq .spec.distribution.modules.policy.type "gatekeeper" }}
$kubectlbin delete validatingwebhookconfiguration gatekeeper-validating-webhook-configuration
{{- end }}
