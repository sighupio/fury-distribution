# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: ingress-forecastle-allow-from-ingress-nginx
  namespace: ingress-nginx
spec:
  podSelector: 
    matchLabels:
      app: forecastle
  policyTypes:
  - Ingress
  ingress:
  - ports:
    - port: 3000
      protocol: TCP 
    from:
    - podSelector:
        matchLabels:
          app: ingress-nginx
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: egress-forecastle-allow-all
  namespace: ingress-nginx
spec:
  podSelector:
    matchLabels:
      app: forecastle
  policyTypes:
  - Egress
  egress:
    - {}
---