---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dex
  namespace: kube-system
  annotations:
    cert-manager.io/cluster-issuer: "letsencrypt-aws" # FIXME
spec:
  # Needs to be externally available in order to act as callback from GitHub.
  ingressClassName: {{ if .modules.auth.overrides.ingresses.dex.ingressClass }} {{ .modules.auth.overrides.ingresses.dex.ingressClass }} {{ else }} {{ if eq .modules.ingress.nginx.type "single" }} "nginx" {{ else }} "external" {{ end }} {{ end }}
  rules:
    - host: {{ if .modules.auth.overrides.ingresses.dex.host }} {{ .modules.auth.overrides.ingresses.dex.host }} {{ else }} {{ print "login" .modules.ingress.baseDomaim }} {{ end }}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: dex
                port:
                  name: http
  tls:
    - hosts:
      - {{ if .modules.auth.overrides.ingresses.dex.host }} {{ .modules.auth.overrides.ingresses.dex.host }} {{ else }} {{ print "login" .modules.ingress.baseDomaim }} {{ end }}
      secretName: dex-tls
