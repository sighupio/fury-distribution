{{- if .spec.distribution.modules.monitoring.alertmanager.deadManSwitchWebhookUrl -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: healthchecks-webhook
  namespace: monitoring
data:
  url: {{ .spec.distribution.modules.monitoring.alertmanager.deadManSwitchWebhookUrl | b64enc }}
{{ end -}}
{{ if .spec.distribution.modules.monitoring.alertmanager.slackWebhookUrl -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: infra-slack-webhook
  namespace: monitoring
data:
  url: {{ .spec.distribution.modules.monitoring.alertmanager.slackWebhookUrl | b64enc }}
---
apiVersion: v1
kind: Secret
metadata:
  name: k8s-slack-webhook
  namespace: monitoring
data:
  url: {{ .spec.distribution.modules.monitoring.alertmanager.slackWebhookUrl | b64enc }}
{{- end }}
