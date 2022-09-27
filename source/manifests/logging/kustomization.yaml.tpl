---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .common.relativeVendorPath "/katalog/logging/cerebro" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/logging/configs" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/logging/logging-operated" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/logging/logging-operator" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/logging/opensearch-dashboards" }}
{{- if eq .modules.logging.opensearch.type "single" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/logging/opensearch-single" }}
{{- else if eq .modules.logging.opensearch.type "triple" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/logging/opensearch-triple" }}
{{- end }}
  - resources/ingress-infra.yml

patchesStrategicMerge:
  - patches/opensearch.yml
  - patches/infra-nodes.yml

{{ if eq .modules.ingress.nginx.type "single" -}}
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
