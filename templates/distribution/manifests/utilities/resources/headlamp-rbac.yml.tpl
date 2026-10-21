# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- $enabled := and (eq .spec.distribution.common.provider.type "none" "immutable") (hasKeyAny .spec "kubernetes") (eq (.spec | digAny "distribution" "modules" "utilities" "headlamp" "type" "none") "sso") }}
{{- if $enabled }}

{{- /* The API server prefixes the OIDC groups, so the bindings must use the prefixed name. Same */}}
{{- /* precedence as oidc_groups_prefix in kubernetes/{onpremises,immutable}/hosts.yaml.tpl: */}}
{{- /* groups_prefix, then the deprecated group_prefix, then the installer default "oidc:". */}}
{{- $groupsPrefix := or (.spec | digAny "kubernetes" "advanced" "oidc" "groups_prefix" "") (.spec | digAny "kubernetes" "advanced" "oidc" "group_prefix" "") "oidc:" }}
{{- $group := print $groupsPrefix .spec.distribution.modules.utilities.headlamp.oidcGroup }}

---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: sd-ui-reader
  namespace: headlamp
rules:
  - apiGroups: [""]
    resources: ["configmaps"]
    # The distribution summary every SD plugin reads.
    resourceNames: ["sd-spec"]
    verbs: ["get", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: sd-ui-reader
  namespace: headlamp
subjects:
  - kind: Group
    name: {{ $group | quote }}
    apiGroup: rbac.authorization.k8s.io
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: sd-ui-reader
{{- end }}
