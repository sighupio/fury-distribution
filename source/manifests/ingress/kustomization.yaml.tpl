---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
{{- if eq .modules.ingress.nginx.type "dual" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/ingress/dual-nginx" }}
{{- else if eq .modules.ingress.nginx.type "single" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/ingress/nginx" }}
{{- end }}
  - {{ print "../" .common.relativeVendorPath "/katalog/ingress/forecastle" }}
{{- if eq .modules.ingress.nginx.tls.provider "certManager" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/ingress/cert-manager" }}
  - resources/cert-manager-clusterissuer.yml
{{- end }}
  - resources/ingress-infra.yml

patchesStrategicMerge:
{{- if and (eq .modules.ingress.nginx.tls.provider "certManager") (eq .modules.ingress.certManager.clusterIssuer.type "dns01") }}
  - patches/cert-manager.yml
{{- end }}
  - patches/infra-nodes.yml
{{- if eq .modules.ingress.nginx.type "dual" }}
  - patches/ingress-nginx-external.yml
  - patches/ingress-nginx-internal.yml
{{- else if eq .modules.ingress.nginx.type "single" }}
  - patches/ingress-nginx.yml
{{- end }}

{{ if eq .modules.ingress.nginx.tls.provider "certManager" -}}
patchesJson6902:
  - target:
      group: apps
      version: v1
      kind: Deployment
      name: cert-manager
      namespace: cert-manager
    patch: |-
      - op: add
        path: /spec/template/spec/containers/0/args/-
        value: "--dns01-recursive-nameservers-only"
      - op: add
        path: /spec/template/spec/containers/0/args/-
        value: "--dns01-recursive-nameservers=8.8.8.8:53,1.1.1.1:53"
{{- end }}
{{ if eq .modules.ingress.nginx.tls.provider "secret" -}}
patchesJson6902:
  {{- if eq .modules.ingress.nginx.type "dual" -}}
  - target:
      group: apps
      version: v1
      kind: DaemonSet
      name: nginx-ingress-controller-external
      namespace: ingress-nginx
    path: patchesJson/ingress-nginx.yml
  - target:
      group: apps
      version: v1
      kind: DaemonSet
      name: nginx-ingress-controller-internal
      namespace: ingress-nginx
    path: patchesJson/ingress-nginx.yml
  {{- else if .modules.ingress.nginx.type "single" -}}
  - target:
      group: apps
      version: v1
      kind: DaemonSet
      name: nginx-ingress-controller
      namespace: ingress-nginx
    path: patchesJson/ingress-nginx.yml
  {{- end -}}
{{- end }}
