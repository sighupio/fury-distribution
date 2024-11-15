# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: pomerium-ingress-nginx
  namespace: pomerium
  labels:
    cluster.kfd.sighup.io/module: auth
    cluster.kfd.sighup.io/auth-provider-type: sso
spec:
  policyTypes:
    - Ingress
  podSelector:
    matchLabels:
      app: pomerium
  ingress:
    - from:
      - namespaceSelector:
          matchLabels:
            kubernetes.io/metadata.name: ingress-nginx
        podSelector:
          matchLabels:
            app: ingress-nginx
      ports:
        - port: 8080
          protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: pomerium-egress-https
  namespace: pomerium
  labels:
    cluster.kfd.sighup.io/module: auth
    cluster.kfd.sighup.io/auth-provider-type: sso
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app: pomerium
  egress:
  - ports: 
    - port: 443
      protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: pomerium-egress-grafana
  namespace: pomerium
  labels:
    cluster.kfd.sighup.io/module: auth
    cluster.kfd.sighup.io/auth-provider-type: sso
spec:
 policyTypes:
   - Egress
 podSelector:
   matchLabels:
     app: pomerium
 egress:
   - to:
       - namespaceSelector:
           matchLabels:
             kubernetes.io/metadata.name: monitoring
         podSelector:
           matchLabels:
             app.kubernetes.io/component: grafana
     ports:
       - port: 3000
         protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: pomerium-egress-prometheus
  namespace: pomerium
  labels:
    cluster.kfd.sighup.io/module: auth
    cluster.kfd.sighup.io/auth-provider-type: sso
spec:
 policyTypes:
   - Egress
 podSelector:
   matchLabels:
     app: pomerium
 egress:
   - to:
       - namespaceSelector:
           matchLabels:
             kubernetes.io/metadata.name: monitoring
         podSelector:
           matchLabels:
             app.kubernetes.io/name: prometheus
     ports:
       - port: 9090
         protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: pomerium-egress-alert-manager
  namespace: pomerium
  labels:
    cluster.kfd.sighup.io/module: auth
    cluster.kfd.sighup.io/auth-provider-type: sso
spec:
 policyTypes:
   - Egress
 podSelector:
   matchLabels:
     app: pomerium
 egress:
   - to:
       - namespaceSelector:
           matchLabels:
             kubernetes.io/metadata.name: monitoring
         podSelector:
           matchLabels:
             alertmanager: main
     ports:
       - port: 9093
         protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: pomerium-egress-forecastle
  namespace: pomerium
  labels:
    cluster.kfd.sighup.io/module: auth
    cluster.kfd.sighup.io/auth-provider-type: sso
spec:
 policyTypes:
   - Egress
 podSelector:
   matchLabels:
     app: pomerium
 egress:
   - to:
       - namespaceSelector:
           matchLabels:
             kubernetes.io/metadata.name: ingress-nginx
         podSelector:
           matchLabels:
             app: forecastle
     ports:
       - port: 3000
         protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: pomerium-egress-gpm
  namespace: pomerium
  labels:
    cluster.kfd.sighup.io/module: auth
    cluster.kfd.sighup.io/auth-provider-type: sso
spec:
 policyTypes:
   - Egress
 podSelector:
   matchLabels:
     app: pomerium
 egress:
   - to:
       - namespaceSelector:
           matchLabels:
             kubernetes.io/metadata.name: gatekeeper-system
         podSelector:
           matchLabels:
             app: gatekeeper-policy-manager
     ports:
       - port: 8080
         protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: pomerium-egress-hubble-ui
  namespace: pomerium
  labels:
    cluster.kfd.sighup.io/module: auth
    cluster.kfd.sighup.io/auth-provider-type: sso
spec:
 policyTypes:
   - Egress
 podSelector:
   matchLabels:
     app: pomerium
 egress:
   - to:
       - namespaceSelector:
           matchLabels:
             kubernetes.io/metadata.name: kube-system
         podSelector:
           matchLabels:
             app.kubernetes.io/name: hubble-ui
     ports:
       - port: 8081
         protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: pomerium-egress-opensearch-dashboard
  namespace: pomerium
  labels:
    cluster.kfd.sighup.io/module: auth
    cluster.kfd.sighup.io/auth-provider-type: sso
    cluster.kfd.sighup.io/logging-type: opensearch
spec:
 policyTypes:
   - Egress
 podSelector:
   matchLabels:
     app: pomerium
 egress:
   - to:
       - namespaceSelector:
           matchLabels:
             kubernetes.io/metadata.name: logging
         podSelector:
           matchLabels:
             app: opensearch-dashboards
     ports:
       - port: 9200
         protocol: TCP
       - port: 5601
         protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: pomerium-egress-minio-logging
  namespace: pomerium
  labels:
    cluster.kfd.sighup.io/module: auth
    cluster.kfd.sighup.io/auth-provider-type: sso
    cluster.kfd.sighup.io/logging-backend: minio
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app: pomerium
  egress:
    - to:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: logging
          podSelector:
            matchLabels:
              app: minio
      ports:
        - port: 9001
          protocol: TCP
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: pomerium-egress-minio-tracing
  namespace: pomerium
  labels:
    cluster.kfd.sighup.io/module: auth
    cluster.kfd.sighup.io/auth-provider-type: sso
spec:
  policyTypes:
    - Egress
  podSelector:
    matchLabels:
      app: pomerium
  egress:
    - to:
        - namespaceSelector:
            matchLabels:
              kubernetes.io/metadata.name: tracing
          podSelector:
            matchLabels:
              app: minio
      ports:
        - port: 9001
          protocol: TCP
---
