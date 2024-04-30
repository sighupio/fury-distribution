# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

{{- if eq .spec.distribution.modules.dr.type "eks" }}

module "velero" {
  providers = {
    aws = aws.velero
  }

  source             = "{{ print .spec.distribution.common.relativeVendorPath "/modules/dr/modules/aws-velero" }}"
  backup_bucket_name = "{{ .spec.distribution.modules.dr.velero.eks.bucketName }}"
  oidc_provider_url  = replace(data.aws_eks_cluster.this.identity.0.oidc.0.issuer, "https://", "")
}

output "velero_iam_role_arn" {
  value = module.velero.velero_iam_role_arn
}

{{- end }}
