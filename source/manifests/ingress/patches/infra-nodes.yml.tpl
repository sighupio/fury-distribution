{{- define "nodeSelector" -}}
  {{ if ne .modules.ingress.overrides.nodeSelector nil -}}
    {{ .modules.ingress.overrides.nodeSelector | toYaml | indent 8 | trim }}
  {{- else -}}
    {{ template "commonNodeSelector" . }}
  {{- end }}
{{- end -}}
{{- define "tolerations" -}}
  {{ if ne .modules.ingress.overrides.tolerations nil -}}
    {{ .modules.ingress.overrides.tolerations | toYaml | indent 8 | trim }}
  {{- else -}}
    {{ template "commonTolerations" . }}
  {{- end }}
{{- end -}}
{{ if eq .modules.ingress.nginx.tls.provider "certManager" -}}
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
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
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
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
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
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
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
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
{{ if eq .modules.ingress.nginx.type "dual" -}}
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
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
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
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
{{- else if eq .modules.ingress.nginx.type "single" -}}
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
        {{ template "nodeSelector" . }}
      tolerations:
        {{ template "tolerations" . }}
{{- end }}
