{{- if eq .spec.distribution.modules.logging.type "loki" }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: loki-distributed-ingester
  namespace: logging
spec:
  template:
    spec:
      containers:
      - name:
      {{- if hasKeyAny .spec.distribution.modules.logging.loki "resources" }}
        resources:
          {{ .spec.distribution.modules.logging.loki.resources | toYaml | indent 10 | trim }}
      {{- end }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: loki-distributed-ingester
  namespace: logging
spec:
  template:
    spec:
      containers:
      - name:
      {{- if hasKeyAny .spec.distribution.modules.logging.loki "resources" }}
        resources:
          {{ .spec.distribution.modules.logging.loki.resources | toYaml | indent 10 | trim }}
      {{- end }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: loki-distributed-compactor
  namespace: logging
spec:
  template:
    spec:
      containers:
      - name:
      {{- if hasKeyAny .spec.distribution.modules.logging.loki "resources" }}
        resources:
          {{ .spec.distribution.modules.logging.loki.resources | toYaml | indent 10 | trim }}
      {{- end }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: loki-distributed-distributor
  namespace: logging
spec:
  template:
    spec:
      containers:
      - name:
      {{- if hasKeyAny .spec.distribution.modules.logging.loki "resources" }}
        resources:
          {{ .spec.distribution.modules.logging.loki.resources | toYaml | indent 10 | trim }}
      {{- end }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: loki-distributed-gateway
  namespace: logging
spec:
  template:
    spec:
      containers:
      - name:
      {{- if hasKeyAny .spec.distribution.modules.logging.loki "resources" }}
        resources:
          {{ .spec.distribution.modules.logging.loki.resources | toYaml | indent 10 | trim }}
      {{- end }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: loki-distributed-query-frontend
  namespace: logging
spec:
  template:
    spec:
      containers:
      - name:
      {{- if hasKeyAny .spec.distribution.modules.logging.loki "resources" }}
        resources:
          {{ .spec.distribution.modules.logging.loki.resources | toYaml | indent 10 | trim }}
      {{- end }}
{{- end }}
