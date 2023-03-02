{{- $gArgs := dict "module" "policy" "spec" .spec "component" "gatekeeper" -}}

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: gatekeeper-audit
  namespace: gatekeeper-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $gArgs }}
      tolerations:
        {{ template "tolerations" $gArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: gatekeeper-controller-manager
  namespace: gatekeeper-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $gArgs }}
      tolerations:
        {{ template "tolerations" $gArgs }}
