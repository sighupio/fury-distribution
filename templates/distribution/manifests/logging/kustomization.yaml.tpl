---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:


  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/logging-operated" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/logging-operator" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/minio-ha" }}
{{- if eq .spec.distribution.modules.logging.type "opensearch" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/cerebro" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/configs" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/opensearch-dashboards" }}
{{- if eq .spec.distribution.modules.logging.opensearch.type "single" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/opensearch-single" }}
{{- else if eq .spec.distribution.modules.logging.opensearch.type "triple" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/opensearch-triple" }}
{{- end }}
{{- end }}
{{- if eq .spec.distribution.modules.logging.type "opensearch" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/loki-configs" }}
  - {{ print "../" .spec.distribution.common.relativeVendorPath "/modules/logging/katalog/loki-distributed" }}
{{- end }}
  - resources/ingress-infra.yml

patchesStrategicMerge:
{{- if eq .spec.distribution.modules.logging.type "opensearch" }}
  - patches/opensearch.yml
{{- end }}
{{- if eq .spec.distribution.modules.logging.type "loki" }}
  - patches/loki.yml
{{- end }}
  - patches/infra-nodes.yml

