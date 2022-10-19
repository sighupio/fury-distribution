{{- if eq .spec.distribution.modules.auth.provider.type "none" -}}
{{- else -}}
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
{{- end -}}
{{- if eq .spec.distribution.modules.auth.provider.type "sso" }}

resources:
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/auth/katalog/dex" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/auth/katalog/pomerium" }}
  - resources/ingress-infra.yml

patchesStrategicMerge:
  - patches/infra-nodes.yml
  - patches/pomerium-ingress.yml

configMapGenerator:
  - name: pomerium
    behavior: replace
    envs:
      - resources/pomerium-config.env
  - name: pomerium-policy
    behavior: replace
    files:
      - policy.yml=resources/pomerium-policy.yml

secretGenerator:
  - name: dex
    namespace: kube-system
    files:
      - config.yml=secrets/dex.yml
  - name: pomerium-env
    behavior: replace
    envs:
      - secrets/pomerium.env
{{- end -}}
{{- if eq .spec.distribution.modules.auth.provider.type "basicAuth" }}

resources:
  - secrets/basic-auth.yml
{{- end }}
