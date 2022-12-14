{{- define "nodeSelector" -}}
  {{ $indent := 8 -}}
  {{ if hasKey . "indent" -}}
    {{ $indent = .indent -}}
  {{- end -}}
  {{ if ne .spec.distribution.modules.dr.overrides.nodeSelector nil -}}
    {{ .spec.distribution.modules.dr.overrides.nodeSelector | toYaml | indent $indent | trim }}
  {{- else -}}
    {{ template "commonNodeSelector" ( dict "spec" .spec "indent" $indent ) }}
  {{- end }}
{{- end -}}
{{- define "tolerations" -}}
  {{ $indent := 8 -}}
  {{ if hasKey . "indent" -}}
    {{ $indent = .indent -}}
  {{- end -}}
  {{ if ne .spec.distribution.modules.dr.overrides.tolerations nil -}}
    {{ .spec.distribution.modules.dr.overrides.tolerations | toYaml | indent $indent | trim }}
  {{- else -}}
    {{ template "commonTolerations" ( dict "spec" .spec "indent" $indent ) }}
  {{- end }}
{{- end -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: velero
  namespace: kube-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
