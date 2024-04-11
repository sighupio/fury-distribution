/**
 * Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

output "cluster_endpoint" {
  description = "The endpoint for your Kubernetes API server"
  value       = module.fury.cluster_endpoint
}

output "cluster_certificate_authority" {
  description = "The base64 encoded certificate data required to communicate with your cluster. Add this to the certificate-authority-data section of the kubeconfig file for your cluster"
  value       = module.fury.cluster_certificate_authority
}

output "operator_ssh_user" {
  description = "SSH user to access cluster nodes with ssh_public_key"
  value       = module.fury.operator_ssh_user
}

output "eks_cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = module.fury.eks_cluster_oidc_issuer_url
}

output "eks_worker_iam_role_name" {
  description = "Default IAM role name for EKS worker groups"
  value       = module.fury.eks_worker_iam_role_name
}

output "eks_workers_asg_names" {
  description = "Names of the autoscaling groups containing workers."
  value       = module.fury.eks_workers_asg_names
}

output "kubeconfig" {
  sensitive = true
  value     = <<EOT
apiVersion: v1
clusters:
- cluster:
    server: ${module.fury.cluster_endpoint}
    certificate-authority-data: ${module.fury.cluster_certificate_authority}
  name: kubernetes-${var.cluster_name}
contexts:
- context:
    cluster: kubernetes-${var.cluster_name}
    user: aws-${var.cluster_name}
  name: aws-${var.cluster_name}
current-context: aws-${var.cluster_name}
kind: Config
preferences: {}
users:
- name: aws-${var.cluster_name}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: aws
      args:
        - "eks"
        - "get-token"
        - "--cluster-name"
        - "${var.cluster_name}"
EOT
}
