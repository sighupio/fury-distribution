{{- $cerebroArgs := dict "module" "logging" "package" "cerebro" "spec" .spec -}}
{{- $opensearchArgs := dict "module" "logging" "package" "opensearch" "spec" .spec -}}
{{- $minioArgs := dict "module" "logging" "package" "minio" "spec" .spec -}}
{{- $banzaiArgs := dict "module" "logging" "package" "banzai" "spec" .spec -}}

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cerebro
  namespace: logging
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $cerebroArgs }}
      tolerations:
        {{ template "tolerations" $cerebroArgs }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: opensearch-cluster-master
  namespace: logging
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $opensearchArgs }}
      tolerations:
        {{ template "tolerations" $opensearchArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: opensearch-dashboards
  namespace: logging
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $opensearchArgs }}
      tolerations:
        {{ template "tolerations" $opensearchArgs }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: minio
  namespace: logging
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $minioArgs }}
      tolerations:
        {{ template "tolerations" $minioArgs }}
---
apiVersion: logging.banzaicloud.io/v1beta1
kind: Logging
metadata:
  name: infra
spec:
  fluentd:
    nodeSelector:
      {{ template "nodeSelector" $banzaiArgs }}
    tolerations:
      {{ template "tolerations" ( merge $banzaiArgs (dict "indent" 6) ) }}
