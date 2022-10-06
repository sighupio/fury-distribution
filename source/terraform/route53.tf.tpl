# Create public DNS if nginx is single or dual and create is true

{{- if (.modules.ingress.dns.public.create)}}

resource "aws_route53_zone" "public" {
  name = "{{ .modules.ingress.dns.public.name }}"
}

output "aws_route53_zone_public_id" {
  value = aws_route53_zone.public.zone_id
}

output "aws_route53_zone_public_name_servers" {
  value = aws_route53_zone.public.name_servers
}

{{- end }}

# Get public DNS as data if nginx is single or dual and create is false
{{- if (not .modules.ingress.dns.public.create) }}

data "aws_route53_zone" "public" {
  name = "{{ .modules.ingress.dns.public.name }}"
}

output "aws_route53_zone_public_id" {
  value = data.aws_route53_zone.public.zone_id
}

{{- end }}

# Create private DNS if nginx is dual and create is true
{{- if and (.modules.ingress.dns.private.create) (eq .modules.ingress.nginx.type "dual") }}

resource "aws_route53_zone" "private" {
  name = "{{ .modules.ingress.dns.private.name }}"
  vpc {
    vpc_id = "{ .modules.ingress.dns.private.vpcId }"
  }
}

output "aws_route53_zone_private_id" {
  value = aws_route53_zone.private.zone_id
}

{{- end }}
# Get private DNS as data if nginx is dual and create is false
{{- if and (not .modules.ingress.dns.private.create) (eq .modules.ingress.nginx.type "dual") }}

data "aws_route53_zone" "private" {
  name = "{{ .modules.ingress.dns.private.name }}"
  vpc_id = "{ .modules.ingress.dns.private.vpcId }"
}

output "aws_route53_zone_private_id" {
  value = data.aws_route53_zone.private.zone_id
}

{{- end }}