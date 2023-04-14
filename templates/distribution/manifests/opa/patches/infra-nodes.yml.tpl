# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- $gatekeeperArgs := dict "module" "policy" "package" "gatekeeper" "spec" .spec -}}

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
        {{ template "nodeSelector" $gatekeeperArgs }}
      tolerations:
        {{ template "tolerations" $gatekeeperArgs }}
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
        {{ template "nodeSelector" $gatekeeperArgs }}
      tolerations:
        {{ template "tolerations" $gatekeeperArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: gatekeeper-policy-manager
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $gatekeeperArgs }}
      tolerations:
        {{ template "tolerations" $gatekeeperArgs }}
