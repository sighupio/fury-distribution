{{- if eq .modules.ingress.certManager.clusterIssuer.type "dns01" -}}
module "cert_manager_iam_role" {
  source          = "{{ print .common.relativeVendorPath "/modules/ingress/iam-for-cert-manager" }}"
  cluster_name    = "{{ .metadata.name }}"
  public_zone_id  = "{{ .modules.ingress.certManager.clusterIssuer.route53.hostedZoneId }}"
}

output "cert_manager_iam_role_arn" {
  value = module.cert_manager_iam_role.cert_manager_iam_role_arn
}

{{- end }}
