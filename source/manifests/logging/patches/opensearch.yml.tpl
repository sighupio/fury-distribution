---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: opensearch-cluster-master
  namespace: logging
spec:
  template:
    spec:
      containers:
      - name: opensearch
      {{- if hasKeyAny .spec.distribution.modules.logging.opensearch "resources" }}
        resources:
          {{ .spec.distribution.modules.logging.opensearch.resources | toYaml | indent 10 | trim }}
      {{- end }}
  volumeClaimTemplates:
  - metadata:
      name: opensearch-cluster-master
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: {{ .spec.distribution.modules.logging.opensearch.storageSize }}
