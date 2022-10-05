module "velero" {
  source             = "{{ print .common.relativeVendorPath "/modules/dr/aws-velero" }}"
  backup_bucket_name = "{{ .metadata.name }}-velero"
  oidc_provider_url  = replace(data.aws_eks_cluster.this.identity.0.oidc.0.issuer, "https://", "")
}
