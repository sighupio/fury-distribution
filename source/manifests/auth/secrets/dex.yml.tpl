{{- define "dexHost" -}}
  {{ if .modules.auth.overrides.ingresses.dex.host -}}
    {{ print "https://" .modules.auth.overrides.ingresses.dex.host }}
  {{- else -}}
    {{ print "https://login." .modules.ingress.baseDomain }}
  {{- end }}
{{- end -}}
{{- define "pomeriumHost" }}
  {{- if .modules.auth.overrides.ingresses.pomerium.host -}}
    {{ print "https://" .modules.auth.overrides.ingresses.pomerium.host "/oauth2/callback" }}
  {{- else -}}
    {{ print "https://pomerium.internal." .modules.ingress.baseDomain "/oauth2/callback" }}
  {{- end }}
{{- end -}}
issuer: {{ template "dexHost" . }}
storage:
  type: kubernetes
  config:
    inCluster: true
web:
  http: 0.0.0.0:5556
telemetry:
  http: 0.0.0.0:5558
connectors:
{{ .modules.auth.dex.connectors | toYaml | indent 2 }}
oauth2:
  skipApprovalScreen: true
staticClients:
- id: pomerium
  redirectURIs:
  - {{ template "pomeriumHost" . }}
  name: 'Pomerium in-cluster SSO'
  secret: {{ .modules.auth.pomerium.secrets.IDP_CLIENT_SECRET }}
enablePasswordDB: false
