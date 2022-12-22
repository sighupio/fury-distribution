---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
{{- if eq .spec.distribution.modules.ingress.nginx.type "dual" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/ingress/katalog/dual-nginx" }}
{{- else if eq .spec.distribution.modules.ingress.nginx.type "single" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/ingress/katalog/nginx" }}
{{- end }}
{{- if eq .spec.distribution.modules.ingress.nginx.type "dual" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/ingress/katalog/external-dns/private" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/ingress/katalog/external-dns/public" }}
{{- else if eq .spec.distribution.modules.ingress.nginx.type "single" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/ingress/katalog/external-dns/public" }}
{{- end }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/ingress/katalog/forecastle" }}
{{- if eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/ingress/katalog/cert-manager" }}
  - resources/cert-manager-clusterissuer.yml
{{- end }}
  - resources/ingress-infra.yml

patchesStrategicMerge:
{{- if and (eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager") (eq .spec.distribution.modules.ingress.certManager.clusterIssuer.type "dns01") }}
  - patches/cert-manager.yml
{{- end }}
  - patches/infra-nodes.yml
{{- if eq .spec.distribution.modules.ingress.nginx.type "dual" }}
  - patches/ingress-nginx-external.yml
  - patches/ingress-nginx-internal.yml
{{- else if eq .spec.distribution.modules.ingress.nginx.type "single" }}
  - patches/ingress-nginx.yml
{{- end }}
  - patches/external-dns.yml

{{ if eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager" -}}
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
{{ if eq .spec.distribution.modules.ingress.nginx.tls.provider "secret" -}}
patchesJson6902:
  {{- if eq .spec.distribution.modules.ingress.nginx.type "dual" -}}
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
  {{- else if .spec.distribution.modules.ingress.nginx.type "single" -}}
  - target:
      group: apps
      version: v1
      kind: DaemonSet
      name: nginx-ingress-controller
      namespace: ingress-nginx
    path: patchesJson/ingress-nginx.yml
  {{- end -}}
{{- end }}
