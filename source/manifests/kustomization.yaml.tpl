---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
{{- if ne .spec.distribution.modules.auth.provider.type "none" }}
  - auth
{{- end }}
{{- if eq .kind "EKSCluster" }}
  - aws
{{- end }}
  - dr
  - ingress
  - logging
  - monitoring
  - networking
  - opa
