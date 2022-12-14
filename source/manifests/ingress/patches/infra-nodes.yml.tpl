{{- define "nodeSelector" -}}
  {{ $indent := 8 -}}
  {{ if hasKey . "indent" -}}
    {{ $indent = .indent -}}
  {{- end -}}
  {{ if ne .spec.distribution.modules.ingress.overrides.nodeSelector nil -}}
    {{ .spec.distribution.modules.ingress.overrides.nodeSelector | toYaml | indent $indent | trim }}
  {{- else -}}
    {{ template "commonNodeSelector" ( dict "spec" .spec "indent" $indent ) }}
  {{- end }}
{{- end -}}
{{- define "tolerations" -}}
  {{ $indent := 8 -}}
  {{ if hasKey . "indent" -}}
    {{ $indent = .indent -}}
  {{- end -}}
  {{ if ne .spec.distribution.modules.ingress.overrides.tolerations nil -}}
    {{ .spec.distribution.modules.ingress.overrides.tolerations | toYaml | indent $indent | trim }}
  {{- else -}}
    {{ template "commonTolerations" ( dict "spec" .spec "indent" $indent ) }}
  {{- end }}
{{- end -}}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
{{- end }}