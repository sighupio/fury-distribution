{{- $tigeraOperatorArgs := dict "module" "networking" "package" "tigeraOperator" "spec" .spec -}}

---
apiVersion: operator.tigera.io/v1
kind: Installation
metadata:
  name: default
spec:
  controlPlaneNodeSelector:
    {{ template "nodeSelector" ( merge (dict "indent" 4) $tigeraOperatorArgs ) }}
  controlPlaneTolerations:
    {{ template "tolerations" ( merge (dict "indent" 4) $tigeraOperatorArgs ) }}
  typhaDeployment:
    spec:
      template:
        spec:
          nodeSelector:
            {{ template "nodeSelector" ( merge (dict "indent" 12) $tigeraOperatorArgs ) }}
          tolerations:
            {{ template "tolerations" ( merge (dict "indent" 12) $tigeraOperatorArgs ) }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: tigera-operator
  namespace: tigera-operator
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $tigeraOperatorArgs }}
      tolerations:
        {{ template "tolerations" $tigeraOperatorArgs }}
