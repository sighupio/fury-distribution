{{ if eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager" -}}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .spec.distribution.modules.ingress.certManager.clusterIssuer.name }}
spec:
  acme:
    email: {{ .spec.distribution.modules.ingress.certManager.clusterIssuer.email }}
    privateKeySecretRef:
      name: {{ .spec.distribution.modules.ingress.certManager.clusterIssuer.name }}
    server: https://acme-v02.api.letsencrypt.org/directory
    solvers:
{{- if eq .spec.distribution.modules.ingress.certManager.clusterIssuer.type "dns01" }}
    - dns01:
        route53:
          region: {{ .spec.distribution.modules.ingress.certManager.clusterIssuer.route53.region }}
          hostedZoneID: {{ .spec.distribution.modules.ingress.certManager.clusterIssuer.route53.hostedZoneId }}
{{ else if eq .spec.distribution.modules.ingress.certManager.clusterIssuer.type "http01" }}
    - http01:
        ingress:
          class: {{ template "globalIngressClass" (dict "type" "external" "spec" .spec) }}
{{- end -}}
{{- end -}}
