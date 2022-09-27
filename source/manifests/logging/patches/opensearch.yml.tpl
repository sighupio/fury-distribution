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
          {{ .modules.logging.opensearch.resources | toYaml | indent 4 | trim }}
  volumeClaimTemplates:
  - metadata:
      name: es-data
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: {{ .modules.logging.opensearch.storageSize }}
