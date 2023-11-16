#!/usr/bin/env sh

set -e

terraformbin="{{ .paths.terraform }}"

{{ $hasVpnEnabled := (
    and
        (index .spec.infrastructure "vpn")
        (
            or
                (not (index .spec.infrastructure.vpn "instances"))
                (gt (index .spec.infrastructure.vpn "instances") 0)
        )
) }}

{{- if $hasVpnEnabled }}
TF_STATE=$($terraformbin -chdir=terraform state list)

if [ ! $(echo "${TF_STATE}" | grep -F 'module.vpn[0].aws_s3_bucket_ownership_controls.furyagent') ]; then
    $terraformbin -chdir=terraform import \
        module.vpn[0].aws_s3_bucket_ownership_controls.furyagent \
        "{{ .spec.toolsConfiguration.terraform.state.s3.bucketName }}"
fi

if [ ! $(echo "${TF_STATE}" | grep -F 'module.vpn[0].aws_s3_bucket_server_side_encryption_configuration.furyagent') ]; then
    $terraformbin -chdir=terraform import \
        module.vpn[0].aws_s3_bucket_server_side_encryption_configuration.furyagent \
        "{{ .spec.toolsConfiguration.terraform.state.s3.bucketName }}"
fi

if [ ! $(echo "${TF_STATE}" | grep -F 'module.vpn[0].aws_s3_bucket_versioning.furyagent') ]; then
    $terraformbin -chdir=terraform import \
        module.vpn[0].aws_s3_bucket_versioning.furyagent \
        "{{ .spec.toolsConfiguration.terraform.state.s3.bucketName }}"
fi
{{- end -}}
