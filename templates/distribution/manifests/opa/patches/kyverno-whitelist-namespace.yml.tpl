# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- $newWebhook := dict "key" "kubernetes.io/metadata.name" "operator" "NotIn" "values" (list "kube-system" "kyverno" "logging" "monitoring" "ingress-nginx" "cert-manager" "tigera-operator" "calico-system" "calico-api" "vmware-system-csi" "pomerium" "tracing") }}
{{- range $webhook := .spec.distribution.modules.policy.kyverno.additionalExcludedNamespaces }}
  {{- append $newWebhook.values $webhook }}
{{- end }}
{{- $kwhitelist :=  dict "matchExpressions" (list $newWebhook) }}
{{- $kwhitelist :=  dict "namespaceSelector" $kwhitelist | toJson }}
{{- $kwhitelist :=  list $kwhitelist | quote }}


---
apiVersion: v1
kind: ConfigMap
metadata:
  name: kyverno
  namespace: kyverno
data:
  webhooks: {{ $kwhitelist  }}