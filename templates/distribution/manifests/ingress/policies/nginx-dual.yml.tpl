# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: nginx-allow-all
  namespace: ingress-nginx
spec:
  podSelector:
    matchLabels:
      app: ingress
  policyTypes:
  - Egress
  - Ingress
  ingress:
    - {}
  egress: 
    - {}