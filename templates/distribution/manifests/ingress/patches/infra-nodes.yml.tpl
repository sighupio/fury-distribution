{{- $cmArgs := dict "module" "ingress" "spec" .spec "package" "certManager" -}}
{{- $nArgs := dict "module" "ingress" "spec" .spec "package" "nginx" -}}
{{- $dArgs := dict "module" "ingress" "spec" .spec "package" "dns" -}}
{{- $fArgs := dict "module" "ingress" "spec" .spec "package" "forecastle" -}}

{{ if eq .spec.distribution.modules.ingress.nginx.tls.provider "certManager" -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cert-manager
  namespace: cert-manager
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $cmArgs }}
      tolerations:
        {{ template "tolerations" $cmArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cert-manager-cainjector
  namespace: cert-manager
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $cmArgs }}
      tolerations:
        {{ template "tolerations" $cmArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cert-manager-webhook
  namespace: cert-manager
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $cmArgs }}
      tolerations:
        {{ template "tolerations" $cmArgs }}
{{- end }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: forecastle
  namespace: ingress-nginx
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $fArgs }}
      tolerations:
        {{ template "tolerations" $fArgs }}
{{ if eq .spec.distribution.modules.ingress.nginx.type "dual" -}}
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: nginx-ingress-controller-external
  namespace: ingress-nginx
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $nArgs }}
      tolerations:
        {{ template "tolerations" $nArgs }}
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: nginx-ingress-controller-internal
  namespace: ingress-nginx
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $nArgs }}
      tolerations:
        {{ template "tolerations" $nArgs }}
{{- else if eq .spec.distribution.modules.ingress.nginx.type "single" -}}
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: nginx-ingress-controller
  namespace: ingress-nginx
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $nArgs }}
      tolerations:
        {{ template "tolerations" $nArgs }}
{{- end }}

{{ if eq .spec.distribution.modules.ingress.nginx.type "dual" -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: external-dns-public
  namespace: ingress-nginx
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $dArgs }}
      tolerations:
        {{ template "tolerations" $dArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: external-dns-private
  namespace: ingress-nginx
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $dArgs }}
      tolerations:
        {{ template "tolerations" $dArgs }}
{{- else if eq .spec.distribution.modules.ingress.nginx.type "single" -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: external-dns-public
  namespace: ingress-nginx
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $dArgs }}
      tolerations:
        {{ template "tolerations" $dArgs }}
{{- end }}
