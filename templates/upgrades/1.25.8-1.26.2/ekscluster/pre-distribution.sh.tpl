#!/usr/bin/env sh

set -e

kubectlbin="{{ .paths.kubectl }}"
kubeconfig="{{ .paths.kubeconfig }}"

if [ -n "$kubeconfig" ]; then
  kubeconfigcmd="--kubeconfig=$kubeconfig"
else
  kubeconfigcmd=""
fi

kubectlcmd="$kubectlbin $kubeconfigcmd"

$kubectlcmd delete deployment ebs-csi-controller -n kube-system
$kubectlcmd delete daemonset ebs-csi-node -n kube-system
