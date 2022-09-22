{{ if eq .modules.ingress.nginx.tls.provider "certManager" -}}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .modules.ingress.certManager.clusterIssuer.name }}
spec:
  acme:
    email: {{ .modules.ingress.certManager.clusterIssuer.email }}
    privateKeySecretRef:
      name: {{ .modules.ingress.certManager.clusterIssuer.name }}
    server: https://acme-v02.api.letsencrypt.org/directory
    solvers:
{{- if eq .modules.ingress.certManager.clusterIssuer.type "dns01" }}
    - dns01:
        route53:
          region: {{ .modules.ingress.certManager.clusterIssuer.route53.region }}
          hostedZoneID: {{ .modules.ingress.certManager.clusterIssuer.route53.hostedZoneId }}
{{ else if eq .modules.ingress.certManager.clusterIssuer.type "http01" }}
    - http01:
        ingress:
          class: {{ template "ingressClassExternal" . }}
{{- end -}}
{{- end -}}
