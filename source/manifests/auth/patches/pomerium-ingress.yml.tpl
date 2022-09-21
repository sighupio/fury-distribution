---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: pomerium
  namespace: pomerium
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-aws" # FIXME
spec:
  ingressClassName: {{ if .modules.auth.overrides.ingresses.pomerium.ingressClass }} {{ .modules.auth.overrides.ingresses.pomerium.ingressClass }} {{ else }} {{ if eq .modules.ingress.nginx.type "single" }} "nginx" {{ else }} "internal" {{ end }} {{ end }}
  rules:
    - host: {{ if .modules.auth.overrides.ingresses.pomerium.host }} {{ .modules.auth.overrides.ingresses.pomerium.host }} {{ else }} {{ print "pomerium.internal." .modules.ingress.baseDomaim }} {{ end }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: pomerium
                port:
                  number: 80
  tls:
    - hosts:
        - {{ if .modules.auth.overrides.ingresses.pomerium.host }} {{ .modules.auth.overrides.ingresses.pomerium.host }} {{ else }} {{ print "pomerium.internal." .modules.ingress.baseDomaim }} {{ end }}
      secretName: pomerium-tls
