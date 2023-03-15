{{- $cerebroArgs := dict "module" "logging" "package" "cerebro" "spec" .spec -}}
{{- $opensearchArgs := dict "module" "logging" "package" "opensearch" "spec" .spec -}}
{{- $minioArgs := dict "module" "logging" "package" "minio" "spec" .spec -}}
{{- $operatorArgs := dict "module" "logging" "package" "operator" "spec" .spec -}}

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
      {{ template "nodeSelector" $operatorArgs }}
    tolerations:
      {{ template "tolerations" ( merge $operatorArgs (dict "indent" 6) ) }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: logging-operator
  namespace: logging
spec:
  template:
    spec:
      nodeSelector:
      {{ template "nodeSelector" $operatorArgs }}
    tolerations:
      {{ template "tolerations" $operatorArgs }}
---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: ism-policy-cronjob
  namespace: logging
spec:
  jobTemplate:
    spec:
      template:
        spec:
          nodeSelector:
            {{ template "nodeSelector" $operatorArgs }}
          tolerations:
            {{ template "tolerations" ( merge $operatorArgs (dict "indent" 12) ) }}
---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: index-patterns-cronjob
  namespace: logging
spec:
  jobTemplate:
    spec:
      template:
        spec:
          nodeSelector:
            {{ template "nodeSelector" $operatorArgs }}
          tolerations:
            {{ template "tolerations" ( merge $operatorArgs (dict "indent" 12) ) }}
---
apiVersion: logging-extensions.banzaicloud.io/v1alpha1
kind: EventTailer
metadata:
  name: kubernetes
spec:
  workloadOverrides:
    nodeSelector:
      {{ template "nodeSelector" $operatorArgs }}
    tolerations:
      {{ template "tolerations" ( merge $operatorArgs (dict "indent" 6) ) }}
