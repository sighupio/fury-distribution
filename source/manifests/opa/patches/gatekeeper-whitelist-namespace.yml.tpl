{{ if .modules.policy.gatekeeper.additionalExcludedNamespaces }}
---
{{ range .modules.policy.gatekeeper.additionalExcludedNamespaces }}
- op: "add"
  path: "/spec/match/0/excludedNamespaces/-"
  value: {{ . }}
{{ end }}
{{ end }}
