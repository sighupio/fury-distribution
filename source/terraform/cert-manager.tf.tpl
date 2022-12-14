{{- if eq .spec.distribution.modules.ingress.certManager.clusterIssuer.type "dns01" -}}
module "cert_manager_iam_role" {
  source          = "{{ print .spec.distribution.common.relativeVendorPath "/modules/ingress/modules/aws-cert-manager" }}"
  cluster_name    = "{{ .metadata.name }}"
  public_zone_id  = "{{ .spec.distribution.modules.ingress.certManager.clusterIssuer.route53.hostedZoneId }}"
}

output "cert_manager_iam_role_arn" {
  value = module.cert_manager_iam_role.cert_manager_iam_role_arn
}

{{- end }}
