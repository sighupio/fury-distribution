# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
{{- if .spec.distribution.modules.oidcKubernetesAuth.enabled }}
clusterName: "{{ .metadata.name }}"
apiServerURL: "https://{{ .spec.kubernetes.controlPlaneAddress }}"
authorizeURL: "https://{{ template "dexUrl" .spec }}/auth"
{{- if index .spec.distribution.modules.oidcKubernetesAuth "trustedCAPath" }}
trustedCAPath: "/tls/ca.crt"
{{- end }}
tokenURL: "https://{{ template "dexUrl" .spec }}/token"
clientID: "{{ .spec.distribution.modules.oidcKubernetesAuth.clientID }}"
clientSecret: "{{ .spec.distribution.modules.oidcKubernetesAuth.clientSecret }}"
redirectURL: "https://{{ template "gangwayUrl" .spec }}/callback"
{{- if index .spec.distribution.modules.oidcKubernetesAuth "scopes" }}
scopes: 
{{ .spec.distribution.modules.oidcKubernetesAuth.scopes | toYaml | indent 10 }}
{{-else }}
scopes: ["openid", "profile", "email", "offline_access", "groups"]
{{- end }}
usernameClaim: "{{ .spec.distribution.modules.oidcKubernetesAuth.usernameClaim | email }}"
emailClaim: "{{ .spec.distribution.modules.oidcKubernetesAuth.emailClaim | email }}"
sessionSecurityKey: "{{ .spec.distribution.modules.oidcKubernetesAuth.sessionSecurityKey }}"
{{- end }}