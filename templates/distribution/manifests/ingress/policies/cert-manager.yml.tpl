# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: cert-manager-deny-all
  namespace: cert-manager
spec:
  podSelector: {}
  policyTypes:
  - Egress
  - Ingress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: egress-cert-manager-allow-all
  namespace: cert-manager
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: controller
  policyTypes:
  - Egress
  egress: 
    - {}
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: cert-manager-webhook-allow-all
  namespace: cert-manager
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: webhook
  policyTypes:
  - Ingress
  - Egress
  ingress: 
    - from:
      - ipBlock:
          cidr: 0.0.0.0/0
  egress:
    - {}
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: egress-cert-manager-cainjector-allow-all
  namespace: cert-manager
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: cainjector
  policyTypes:
  - Egress
  egress: 
    - {}