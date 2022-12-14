---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    forecastle.stakater.com/expose: "true"
    forecastle.stakater.com/appName: "Forecastle"
    forecastle.stakater.com/icon: "https://raw.githubusercontent.com/stakater/Forecastle/master/assets/web/forecastle-round-100px.png"
    {{ if not .spec.distribution.modules.ingress.overrides.ingresses.forecastle.disableAuth }}{{ template "ingressAuth" . }}{{ end }}
    {{ template "certManagerClusterIssuer" . }}
  name: forecastle
  namespace: ingress-nginx
spec:
  ingressClassName: {{ template "ingressClass" (dict "module" "ingress" "package" "forecastle" "type" "internal" "spec" .spec) }}
  rules:
    - host: {{ template "ingressHost" (dict "module" "ingress" "package" "forecastle" "prefix" "directory.internal." "spec" .spec) }}
      http:
        paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: forecastle
              port:
                name: http
{{- template "ingressTls" (dict "module" "ingress" "package" "forecastle" "prefix" "directory.internal." "spec" .spec) }}
