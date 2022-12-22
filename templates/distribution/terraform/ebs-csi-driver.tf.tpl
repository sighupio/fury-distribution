module "ebs_csi_driver_iam_role" {
  source       = "{{ print .spec.distribution.common.relativeVendorPath "/modules/aws/modules/iam-for-ebs-csi-driver" }}"
  cluster_name = "{{ .metadata.name }}"
}

output "ebs_csi_driver_iam_role_arn" {
  value = module.ebs_csi_driver_iam_role.ebs_csi_driver_iam_role_arn
}