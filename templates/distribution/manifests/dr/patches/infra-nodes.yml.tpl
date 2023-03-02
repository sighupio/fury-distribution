{{- $veleroArgs := dict "module" "dr" "spec" .spec "component" "velero" -}}

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: velero
  namespace: kube-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $veleroArgs }}
      tolerations:
        {{ template "tolerations" $veleroArgs }}
