module "cluster_autoscaler_iam_role" {
  source       = "{{ print .common.relativeVendorPath "/modules/aws/iam-for-cluster-autoscaler" }}"
  cluster_name = "{{ .metadata.name }}"
  region       = "{{ .toolsConfiguration.terraform.state.s3.region }}"
}
