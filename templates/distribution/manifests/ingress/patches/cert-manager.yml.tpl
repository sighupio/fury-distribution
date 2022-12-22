{{ if and (eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager") (eq .spec.distribution.modules.ingress.certManager.clusterIssuer.type "dns01") -}}
---
apiVersion: v1
kind: ServiceAccount
metadata:
  annotations:
    eks.amazonaws.com/role-arn: {{ .spec.distribution.modules.ingress.certManager.clusterIssuer.route53.iamRoleArn }}
  name: cert-manager
  namespace: cert-manager
{{- end }}
