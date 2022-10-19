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
      - name: elasticsearch
        resources:
          {{ .spec.distribution.modules.logging.opensearch.resources | toYaml | indent 10 | trim }}
  volumeClaimTemplates:
  - metadata:
      name: es-data
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: {{ .spec.distribution.modules.logging.opensearch.storageSize }}
