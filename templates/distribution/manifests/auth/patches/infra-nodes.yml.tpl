# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- $dexArgs := dict "module" "auth" "package" "dex" "spec" .spec -}}
{{- $pomeriumArgs := dict "module" "auth" "package" "pomerium" "spec" .spec -}}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dex
  namespace: kube-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $dexArgs  }}
      tolerations:
        {{ template "tolerations" $dexArgs }}
{{- if eq .spec.distribution.modules.auth.provider.type "sso" }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: pomerium
  namespace: pomerium
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $pomeriumArgs }}
      tolerations:
        {{ template "tolerations" $pomeriumArgs }}
{{- end }}
