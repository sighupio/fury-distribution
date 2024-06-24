# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- define "dexHost" -}}
  {{ if .spec.distribution.modules.auth.overrides.ingresses.dex.host -}}
    {{ print "https://" .spec.distribution.modules.auth.overrides.ingresses.dex.host }}
  {{- else -}}
    {{ print "https://login." .spec.distribution.modules.auth.baseDomain }}
  {{- end }}
{{- end -}}
{{- define "pomeriumHost" }}
  {{- if .spec.distribution.modules.auth.overrides.ingresses.pomerium.host -}}
    {{ print "https://" .spec.distribution.modules.auth.overrides.ingresses.pomerium.host "/oauth2/callback" }}
  {{- else -}}
    {{ print "https://pomerium." .spec.distribution.modules.auth.baseDomain "/oauth2/callback" }}
  {{- end }}
{{- end -}}
{{- define "gangplankHost" -}}
  {{ if .spec.distribution.modules.auth.overrides.ingresses.gangplank.host -}}
    {{ print "https://" .spec.distribution.modules.auth.overrides.ingresses.gangplank.host }}
  {{- else -}}
    {{ print "https://gangplank." .spec.distribution.modules.auth.baseDomain }}
  {{- end }}
{{- end }}
issuer: {{ template "dexHost" . }}
frontend:
  dir: /app/web
  theme: dark
storage:
  type: kubernetes
  config:
    inCluster: true
web:
  http: 0.0.0.0:5556
telemetry:
  http: 0.0.0.0:5558
connectors:
{{ .spec.distribution.modules.auth.dex.connectors | toYaml | indent 2 }}
oauth2:
  skipApprovalScreen: true
enablePasswordDB: false
staticClients:
{{- if eq .spec.distribution.modules.auth.provider.type "sso" }}
- id: pomerium
  redirectURIs:
  - {{ template "pomeriumHost" . }}
  name: 'Pomerium in-cluster SSO'
  secret: {{ .spec.distribution.modules.auth.pomerium.secrets.IDP_CLIENT_SECRET }}
{{- end }}
{{- if .spec.distribution.modules.auth.oidcKubernetesAuth.enabled }}
- id: {{ .spec.distribution.modules.auth.oidcKubernetesAuth.clientID }}
  redirectURIs:
  - {{ template "gangplankHost" . }}/callback
  name: 'In cluster LOGIN'
  secret: {{ .spec.distribution.modules.auth.oidcKubernetesAuth.clientSecret }}
{{- end }}
{{- if .spec.distribution.modules.auth.dex.additionalStaticClients }}
{{ .spec.distribution.modules.auth.dex.additionalStaticClients | toYaml }}
{{- end }}