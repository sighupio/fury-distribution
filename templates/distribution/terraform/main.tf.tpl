terraform {
  backend "s3" {
    bucket = "{{ .spec.toolsConfiguration.terraform.state.s3.bucketName }}"
    key    = "{{ .spec.toolsConfiguration.terraform.state.s3.keyPrefix }}/distribution.json"
    region = "{{ .spec.toolsConfiguration.terraform.state.s3.region }}"
  }
}

provider "aws" {
  region = "{{ .spec.region }}"
  default_tags {
    tags = {
      {{- range $k, $v := .spec.tags }}
      {{ $k }} = "{{ $v }}"
      {{- end}}
    }
  }
}

provider "aws" {
  alias = "velero"
  region = "{{ .spec.distribution.modules.dr.velero.eks.region }}"
  default_tags {
     tags = {
       {{- range $k, $v := .spec.tags }}
       {{ $k }} = "{{ $v }}"
       {{- end}}
     }
   }
}

data "aws_eks_cluster" "this" {
  name = "{{ .metadata.name }}"
}
