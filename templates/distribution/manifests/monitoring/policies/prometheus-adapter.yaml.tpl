# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# source: https://github.com/prometheus-operator/kube-prometheus/blob/main/manifests/prometheusAdapter-networkPolicy.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: prometheus-adapter
  namespace: monitoring
spec:
  egress:
  - {}
  ingress:
  - {}
  podSelector:
    matchLabels:
      app.kubernetes.io/component: metrics-adapter
      app.kubernetes.io/name: prometheus-adapter
      app.kubernetes.io/part-of: kube-prometheus
  policyTypes:
  - Egress
  - Ingress
