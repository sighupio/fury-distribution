# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

resources: 
{{ if (index .spec "plugins") -}}
{{ if (index .spec.plugins "kustomize") -}}
{{- if (index .spec.plugins "kustomize") -}}
{{ range .spec.plugins.kustomize }}
  - {{ .folder }}
{{- end -}}
{{- end -}}
{{- end }}

{{- end }}

