{{ if eq .spec.distribution.modules.ingress.nginx.type "single" -}}
---
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: nlb
  name: ingress-nginx
  namespace: ingress-nginx
spec:
  type: LoadBalancer
{{- end }}
