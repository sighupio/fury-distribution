# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: kyvernoadmission-egress-kubeapiserver
  namespace: kyverno
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: admission-controller
  policyTypes:
  - Egress
  egress:
  - ports:
    - protocol: TCP
      port: 6443
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: kyvernoadmission-ingress-nodes
  namespace: kyverno
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: admission-controller
  policyTypes:
  - Ingress
  ingress:
  - ports:
    - protocol: TCP
      port: 9443
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: kyvernobackground-egress-kubeapiserver
  namespace: kyverno
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: background-controller
  policyTypes:
  - Egress
  egress:
  - ports:
    - protocol: TCP
      port: 6443
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: kyvernoreports-egress-kubeapiserver
  namespace: kyverno
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: reports-controller
  policyTypes:
  - Egress
  egress:
  - ports:
    - protocol: TCP
      port: 6443
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: kyvernocleanup-egress-kubeapiserver
  namespace: kyverno
spec:
  podSelector:
    matchLabels:
      app.kubernetes.io/component: cleanup-controller
  policyTypes:
  - Egress
  egress:
  - ports:
    - protocol: TCP
      port: 6443
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: kyvernocleanupreports-egress-kubeapiserver
  namespace: kyverno
spec:
  podSelector:
    matchExpressions: 
      - { key: "batch.kubernetes.io/job-name", operator: "Exists" }
  policyTypes:
  - Egress
  egress:
  - ports:
    - protocol: TCP
      port: 6443
