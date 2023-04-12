# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- define "pomeriumHost" -}}
  {{ if .spec.distribution.modules.auth.overrides.ingresses.pomerium.host -}}
    {{ .spec.distribution.modules.auth.overrides.ingresses.pomerium.host }}
  {{- else -}}
    {{ print "pomerium." .spec.distribution.modules.auth.baseDomain }}
  {{- end }}
{{- end -}}
{{- define "dexHost" -}}
  {{ if .spec.distribution.modules.auth.overrides.ingresses.dex.host -}}
    {{ print "https://" .spec.distribution.modules.auth.overrides.ingresses.dex.host }}
  {{- else -}}
    {{ print "https://login." .spec.distribution.modules.auth.baseDomain }}
  {{- end }}
{{- end -}}
{{ if eq .spec.distribution.modules.auth.provider.type "sso" }}
FORWARD_AUTH_HOST={{ template "pomeriumHost" . }}
AUTHENTICATE_SERVICE_HOST={{ template "pomeriumHost" . }}
FORWARD_AUTH_URL=https://$(FORWARD_AUTH_HOST)
AUTHENTICATE_SERVICE_URL=https://$(AUTHENTICATE_SERVICE_HOST)
AUTOCERT=false
POMERIUM_DEBUG=true
LOG_LEVEL=debug

# DEX settings
IDP_CLIENT_ID=pomerium
# See https://docs.pomerium.io/configuration/#identity-provider-name
IDP_PROVIDER=oidc
# IDP_PROVIDER_URL is the url of dex ingress
IDP_PROVIDER_URL={{ template "dexHost" . }}
IDP_SCOPES=openid profile email groups
{{ end }}
