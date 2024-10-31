# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: event-tailer-egress-apiserver
  namespace: logging
  labels:
    app.kubernetes.io/name: event-tailer
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app.kubernetes.io/name: event-tailer
  egress:
  - ports:
    - port: 6443
      protocol: TCP
---
