#!/usr/bin/env sh

set -e

kubectlbin="{{ .paths.kubectl }}"

$kubectlbin delete deployment ebs-csi-controller -n kube-system
$kubectlbin delete daemonset ebs-csi-node -n kube-system
