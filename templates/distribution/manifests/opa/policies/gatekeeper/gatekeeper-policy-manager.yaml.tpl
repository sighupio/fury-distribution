# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: gatekeeperpolicymanager-egress-kubeapiserver
  namespace: gatekeeper-system
spec:
  podSelector:
    matchLabels:
      app: gatekeeper-policy-manager
  policyTypes:
    - Egress
  egress:
  - ports:
    - port: 6443
      protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: gatekeeperpolicymanager-ingress-gatekeeper
  namespace: gatekeeper-system
spec:
  podSelector:
    matchLabels:
      app: gatekeeper-policy-manager
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          kubernetes.io/metadata.name: pomerium
      podSelector:
        matchLabels:
          app: pomerium
    ports:
    - protocol: TCP
      port: 8080
