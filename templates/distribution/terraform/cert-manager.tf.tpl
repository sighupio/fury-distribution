{{- if eq .spec.distribution.modules.ingress.certManager.clusterIssuer.type "dns01" -}}
module "cert_manager_iam_role" {
  source          = "{{ print .spec.distribution.common.relativeVendorPath "/modules/ingress/modules/aws-cert-manager" }}"
  cluster_name    = "{{ .metadata.name }}"
  {{- if (.spec.distribution.modules.ingress.dns.public.create)}}
  public_zone_id  = "{{ .spec.distribution.modules.ingress.certManager.clusterIssuer.route53.hostedZoneId }}"
  {{- else }}
  public_zone_id  = data.aws_route53_zone.public.zone_id
  {{- end }}
}

output "cert_manager_iam_role_arn" {
  value = module.cert_manager_iam_role.cert_manager_iam_role_arn
}

{{- end }}
