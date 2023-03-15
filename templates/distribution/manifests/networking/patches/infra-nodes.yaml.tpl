{{- $tigeraOperatorArgs := dict "module" "networking" "package" "tigeraOperator" "spec" .spec -}}

---
apiVersion: operator.tigera.io/v1
kind: Installation
metadata:
  name: default
spec:
  controlPlaneNodeSelector:
    nodeSelector:
      {{ template "nodeSelector" ( merge (dict "indent" 6) $tigeraOperatorArgs ) }}
    tolerations:
      {{ template "tolerations" ( merge (dict "indent" 6) $tigeraOperatorArgs ) }}
