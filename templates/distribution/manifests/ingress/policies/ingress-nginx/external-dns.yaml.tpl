# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: external-dns-egress-all
  namespace: ingress-nginx
  labels:
    cluster.kfd.sighup.io/module: ingress
    cluster.kfd.sighup.io/ingress-type: nginx
spec:
  podSelector:
    matchLabels:
      app: external-dns
  policyTypes:
  - Egress
  egress:
  - {}
---
