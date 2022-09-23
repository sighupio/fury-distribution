---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources:
  - {{ print "../" .common.relativeVendorPath "/katalog/monitoring/alertmanager-operated" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/monitoring/blackbox-exporter" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/monitoring/eks-sm" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/monitoring/grafana" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/monitoring/kube-proxy-metrics" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/monitoring/kube-state-metrics" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/monitoring/node-exporter" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/monitoring/prometheus-adapter" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/monitoring/prometheus-operated" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/monitoring/prometheus-operator" }}
  - {{ print "../" .common.relativeVendorPath "/katalog/monitoring/x509-exporter" }} # FIXME
  - resources/ingress-infra.yml
  {{- if or .modules.monitoring.alertmanager.deadManSwitchWebhookUrl .modules.monitoring.alertmanager.slackWebhookUrl }}
  - secrets/alertmanager.yml
  {{- end }}

patchesStrategicMerge:
  - patches/alertmanager-operated.yml
  - patches/infra-nodes.yml
  - patches/prometheus-operated.yml
