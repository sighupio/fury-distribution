{{- $certManagerArgs := dict "module" "package" "certManager" "ingress" "spec" .spec -}}
{{- $nginxArgs := dict "module" "package" "nginx" "ingress" "spec" .spec -}}
{{- $dnsArgs := dict "module" "package" "dns" "ingress" "spec" .spec -}}
{{- $forecastleArgs := dict "module" "package" "forecastle" "ingress" "spec" .spec -}}

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
        {{ template "nodeSelector" $certManagerArgs }}
      tolerations:
        {{ template "tolerations" $certManagerArgs }}
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
        {{ template "nodeSelector" $certManagerArgs }}
      tolerations:
        {{ template "tolerations" $certManagerArgs }}
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
        {{ template "nodeSelector" $certManagerArgs }}
      tolerations:
        {{ template "tolerations" $certManagerArgs }}
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
        {{ template "nodeSelector" $forecastleArgs }}
      tolerations:
        {{ template "tolerations" $forecastleArgs }}
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
        {{ template "nodeSelector" $nginxArgs }}
      tolerations:
        {{ template "tolerations" $nginxArgs }}
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
        {{ template "nodeSelector" $nginxArgs }}
      tolerations:
        {{ template "tolerations" $nginxArgs }}
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
        {{ template "nodeSelector" $nginxArgs }}
      tolerations:
        {{ template "tolerations" $nginxArgs }}
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
        {{ template "nodeSelector" $dnsArgs }}
      tolerations:
        {{ template "tolerations" $dnsArgs }}
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
        {{ template "nodeSelector" $dnsArgs }}
      tolerations:
        {{ template "tolerations" $dnsArgs }}
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
        {{ template "nodeSelector" $dnsArgs }}
      tolerations:
        {{ template "tolerations" $dnsArgs }}
{{- end }}
