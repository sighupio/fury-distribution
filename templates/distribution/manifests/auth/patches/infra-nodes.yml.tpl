{{- $dexArgs := dict "module" "auth" "spec" .spec "package" "dex" -}}
{{- $pomeriumArgs := dict "module" "auth" "spec" .spec "package" "pomerium" -}}

{{- if eq .spec.distribution.modules.auth.provider.type "sso" -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dex
  namespace: kube-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $dexArgs  }}
      tolerations:
        {{ template "tolerations" $dexArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pomerium
  namespace: pomerium
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $pomeriumArgs }}
      tolerations:
        {{ template "tolerations" $pomeriumArgs }}
{{- end }}
