module "ebs_csi_driver_iam_role" {
  source       = "{{ print .common.relativeVendorPath "/modules/aws/iam-for-ebs-csi-driver" }}"
  cluster_name = "{{ .metadata.name }}"
}

output "ebs_csi_driver_iam_role_arn" {
  value = module.ebs_csi_driver_iam_role.ebs_csi_driver_iam_role_arn
}