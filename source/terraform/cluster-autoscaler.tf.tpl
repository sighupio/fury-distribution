module "cluster_autoscaler_iam_role" {
  source       = "{{ print .spec.distribution.common.relativeVendorPath "/modules/aws/modules/iam-for-cluster-autoscaler" }}"
  cluster_name = "{{ .metadata.name }}"
  region       = "{{ .spec.toolsConfiguration.terraform.state.s3.region }}"
}

output "cluster_autoscaler_iam_role_arn" {
  value = module.cluster_autoscaler_iam_role.cluster_autoscaler_iam_role_arn
}