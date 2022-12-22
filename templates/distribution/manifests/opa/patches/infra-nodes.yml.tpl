{{- define "nodeSelector" -}}
  {{ $indent := 8 -}}
  {{ if hasKey . "indent" -}}
    {{ $indent = .indent -}}
  {{- end -}}
  {{ if ne .spec.distribution.modules.policy.overrides.nodeSelector nil -}}
    {{ .spec.distribution.modules.policy.overrides.nodeSelector | toYaml | indent $indent | trim }}
  {{- else -}}
    {{ template "commonNodeSelector" ( dict "spec" .spec "indent" $indent ) }}
  {{- end }}
{{- end -}}
{{- define "tolerations" -}}
  {{ $indent := 8 -}}
  {{ if hasKey . "indent" -}}
    {{ $indent = .indent -}}
  {{- end -}}
  {{ if ne .spec.distribution.modules.policy.overrides.tolerations nil -}}
    {{ .spec.distribution.modules.policy.overrides.tolerations | toYaml | indent $indent | trim }}
  {{- else -}}
    {{ template "commonTolerations" ( dict "spec" .spec "indent" $indent ) }}
  {{- end }}
{{- end -}}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
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
        {{ template "nodeSelector" ( dict "spec" .spec ) }}
      tolerations:
        {{ template "tolerations" ( dict "spec" .spec ) }}
