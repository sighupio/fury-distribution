{{- define "pomeriumHost" -}}
  {{ if .modules.auth.overrides.ingresses.pomerium.host -}}
    {{ .modules.auth.overrides.ingresses.pomerium.host }}
  {{- else -}}
    {{ print "pomerium.internal." .modules.ingress.baseDomain }}
  {{- end }}
{{- end -}}
{{- define "dexHost" -}}
  {{ if .modules.auth.overrides.ingresses.dex.host -}}
    {{ print "https://" .modules.auth.overrides.ingresses.dex.host }}
  {{- else -}}
    {{ print "https://login" .modules.ingress.baseDomain }}
  {{- end }}
{{- end -}}
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
