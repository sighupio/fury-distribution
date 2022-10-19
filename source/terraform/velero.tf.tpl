module "velero" {
  source             = "{{ print .spec.distribution.common.relativeVendorPath "/modules/dr/modules/aws-velero" }}"
  backup_bucket_name = "{{ .metadata.name }}-velero"
  oidc_provider_url  = replace(data.aws_eks_cluster.this.identity.0.oidc.0.issuer, "https://", "")
}

output "velero_iam_role_arn" {
  value = module.velero.velero_iam_role_arn
}