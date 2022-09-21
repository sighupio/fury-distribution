{{- if eq .modules.auth.provider.type "sso" -}}
---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .common.relativeVendorPath "/katalog/auth/dex" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/auth/pomerium" }}
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
{{- end }}
