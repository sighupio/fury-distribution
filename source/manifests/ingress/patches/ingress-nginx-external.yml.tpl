{{ if eq .modules.ingress.nginx.type "dual" -}}
---
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-type: nlb
  name: ingress-nginx-external
  namespace: ingress-nginx
spec:
  type: LoadBalancer
{{- end }}
