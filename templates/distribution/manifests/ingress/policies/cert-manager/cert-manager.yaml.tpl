# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# https://cert-manager.io/docs/installation/best-practice/#network-requirements
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: certmanager-egress-kubeapiserver
  namespace: cert-manager
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/instance: cert-manager
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
  name: certmanagerwebhook-ingress-kubeapiserver
  namespace: cert-manager
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: webhook
      app.kubernetes.io/instance: cert-manager
  policyTypes:
    - Ingress
  ingress:
    - ports:
      - port: 10250
        protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: certmanager-egress-https
  namespace: cert-manager
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: controller
      app.kubernetes.io/instance: cert-manager
  policyTypes:
    - Egress
  egress:
    - ports:
      - port: 443
        protocol: TCP
      - port: 80
        protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: acmehttpsolver-ingress-letsencrypt
  namespace: pomerium
spec:
  podSelector:
    matchLabels:
      app: cert-manager
  policyTypes:
    - Ingress
  ingress:
    - ports:
        - port: 8089
          protocol: TCP
---
