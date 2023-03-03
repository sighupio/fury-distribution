{{- $gatekeeperArgs := dict "module" "policy" "package" "gatekeeper" "spec" .spec -}}

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
        {{ template "nodeSelector" $gatekeeperArgs }}
      tolerations:
        {{ template "tolerations" $gatekeeperArgs }}
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
        {{ template "nodeSelector" $gatekeeperArgs }}
      tolerations:
        {{ template "tolerations" $gatekeeperArgs }}
