{{ if .spec.distribution.modules.policy.gatekeeper.additionalExcludedNamespaces }}
---
{{ range .spec.distribution.modules.policy.gatekeeper.additionalExcludedNamespaces }}
- op: "add"
  path: "/spec/match/0/excludedNamespaces/-"
  value: {{ . }}
{{ end }}
{{ end }}
