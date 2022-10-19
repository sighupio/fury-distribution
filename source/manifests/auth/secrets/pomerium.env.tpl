{{- if eq .spec.distribution.modules.auth.provider.type "sso" -}}
# COOKIE_SECRET is obtained with  `head -c32 /dev/urandom | base64` see https://www.pomerium.io/reference/#cookie-secret
COOKIE_SECRET={{ .spec.distribution.modules.auth.pomerium.secrets.COOKIE_SECRET }}
#IDP_CLIENT_SECRET is the secret configured in the pomerium Dex static client
IDP_CLIENT_SECRET={{ .spec.distribution.modules.auth.pomerium.secrets.IDP_CLIENT_SECRET }}
# SHARED_SECRET is obtained with  `head -c32 /dev/urandom | base64` see https://www.pomerium.io/reference/#shared-secret
SHARED_SECRET={{ .spec.distribution.modules.auth.pomerium.secrets.SHARED_SECRET }}
{{- end }}
