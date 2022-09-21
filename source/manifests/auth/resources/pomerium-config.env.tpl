FORWARD_AUTH_HOST={{ if .modules.auth.overrides.ingresses.pomerium.host }} {{ .modules.auth.overrides.ingresses.pomerium.host }} {{ else }} {{ print "pomerium.internal." .modules.ingress.baseDomaim }} {{ end }}
AUTHENTICATE_SERVICE_HOST={{ if .modules.auth.overrides.ingresses.pomerium.host }} {{ .modules.auth.overrides.ingresses.pomerium.host }} {{ else }} {{ print "pomerium.internal." .modules.ingress.baseDomaim }} {{ end }}
FORWARD_AUTH_URL=https://$(FORWARD_AUTH_HOST)
AUTHENTICATE_SERVICE_URL=https://$(AUTHENTICATE_SERVICE_HOST)
# See https://docs.pomerium.io/configuration/#identity-provider-name
#######IDP_PROVIDER=github
AUTOCERT=false
# used by `ingress.yaml` by default.
#######IDP_CLIENT_ID=d83664cbf3d554b7bcc1
#IDP_SCOPES=openid profile email
POMERIUM_DEBUG=true
LOG_LEVEL=debug

# DEX settings
IDP_CLIENT_ID=pomerium
# See https://docs.pomerium.io/configuration/#identity-provider-name
IDP_PROVIDER=oidc
# IDP_PROVIDER_URL is the url of dex ingress
IDP_PROVIDER_URL={{ if .modules.auth.overrides.ingresses.dex.host }} {{ print "https://" .modules.auth.overrides.ingresses.dex.host }} {{ else }} {{ print "https://login" .modules.ingress.baseDomaim }} {{ end }}
IDP_SCOPES=openid profile email groups
