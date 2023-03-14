{{- $tigeraOperatorArgs := dict "module" "networking" "package" "tigeraOperator" "spec" .spec -}}

---
apiVersion: operator.tigera.io/v1
kind: Installation
metadata:
  name: default
spec:
  controlPlaneNodeSelector:
    nodeSelector:
      {{ template "nodeSelector" ( merge $alertManagerArgs (dict "indent" 6) ) }}
    tolerations:
      {{ template "tolerations" ( merge $alertManagerArgs (dict "indent" 6) ) }}