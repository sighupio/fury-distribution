{{- $cArgs := dict "module" "logging" "spec" .spec "component" "cerebro" -}}
{{- $osArgs := dict "module" "logging" "spec" .spec "component" "opensearch" -}}
{{- $mArgs := dict "module" "logging" "spec" .spec "component" "minio" -}}
{{- $bArgs := dict "module" "logging" "spec" .spec "component" "banzai" -}}

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
        {{ template "nodeSelector" $cArgs }}
      tolerations:
        {{ template "tolerations" $cArgs }}
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
        {{ template "nodeSelector" $osArgs }}
      tolerations:
        {{ template "tolerations" $osArgs }}
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
        {{ template "nodeSelector" $osArgs }}
      tolerations:
        {{ template "tolerations" $osArgs }}
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
        {{ template "nodeSelector" $mArgs }}
      tolerations:
        {{ template "tolerations" $mArgs }}
---
apiVersion: logging.banzaicloud.io/v1beta1
kind: Logging
metadata:
  name: infra
spec:
  fluentd:
    nodeSelector:
      {{ template "nodeSelector" $bArgs }}
    tolerations:
      {{ template "tolerations" ( merge $bArgs (dict "indent" 6) ) }}
