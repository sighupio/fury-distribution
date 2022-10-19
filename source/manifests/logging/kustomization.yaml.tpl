---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/cerebro" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/configs" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/logging-operated" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/logging-operator" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/opensearch-dashboards" }}
{{- if eq .spec.distribution.modules.logging.opensearch.type "single" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/opensearch-single" }}
{{- else if eq .spec.distribution.modules.logging.opensearch.type "triple" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/opensearch-triple" }}
{{- end }}
  - resources/ingress-infra.yml

patchesStrategicMerge:
  - patches/opensearch.yml
  - patches/infra-nodes.yml

{{ if eq .spec.distribution.modules.ingress.nginx.type "single" -}}
secretGenerator:
  - name: kubernetes-index-template
    behavior: replace
    files:
      - kubernetes-index-template=patches/kubernetes-index-template.json
  - name: events-index-template
    behavior: replace
    files:
      - events-index-template=patches/events-index-template.json
  - name: ingress-controller-index-template
    behavior: replace
    files:
      - ingress-controller-index-template=patches/ingress-controller-index-template.json
  - name: systemd-index-template
    behavior: replace
    files:
      - systemd-index-template=patches/systemd-index-template.json
{{- end }}
