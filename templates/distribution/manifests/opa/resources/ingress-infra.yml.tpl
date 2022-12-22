---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    forecastle.stakater.com/expose: "true"
    forecastle.stakater.com/appName: "Gatekeeper Policy Manager"
    forecastle.stakater.com/icon: "https://raw.githubusercontent.com/sighupio/gatekeeper-policy-manager/master/app/static-content/logo.svg"
    {{ if not .spec.distribution.modules.policy.overrides.ingresses.gpm.disableAuth }}{{ template "ingressAuth" . }}{{ end }}
    {{ template "certManagerClusterIssuer" . }}
  name: gpm
  namespace: gatekeeper-system
spec:
  ingressClassName: {{ template "ingressClass" (dict "module" "policy" "package" "gpm" "type" "internal" "spec" .spec) }}
  rules:
    - host: {{ template "ingressHost" (dict "module" "policy" "package" "gpm" "prefix" "gpm.internal." "spec" .spec) }}
      http:
        paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: gatekeeper-policy-manager
              port:
                name: http
{{- template "ingressTls" (dict "module" "policy" "package" "gpm" "prefix" "gpm.internal." "spec" .spec) }}
