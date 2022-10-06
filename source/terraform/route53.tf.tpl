# Create public DNS if nginx is single or dual and create is true

{{- if (.modules.ingress.dns.public.create)}}

resource "aws_route53_zone" "public" {
  name = "{{ .modules.ingress.dns.public.name }}"
}

{{- end }}

# Get public DNS as data if nginx is single or dual and create is false
{{- if (not .modules.ingress.dns.public.create) }}

data "aws_route53_zone" "public" {
  name = "{{ .modules.ingress.dns.public.name }}"
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

{{- end }}
# Get private DNS as data if nginx is dual and create is false
{{- if and (not .modules.ingress.dns.private.create) (eq .modules.ingress.nginx.type "dual") }}

data "aws_route53_zone" "private" {
  name = "{{ .modules.ingress.dns.private.name }}"
  private_zone = true
}

{{- end }}