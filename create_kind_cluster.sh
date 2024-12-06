#!/bin/bash

cat <<EOF > kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
networking:
  disableDefaultCNI: true
nodes:
  - role: control-plane
  - role: worker
EOF

kind create cluster --name local-testing --image registry.sighup.io/fury/kindest/node:v1.28.0 --config kind-config.yaml