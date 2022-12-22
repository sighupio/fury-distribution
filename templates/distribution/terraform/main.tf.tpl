terraform {
  backend "s3" {
    bucket = "{{ .spec.toolsConfiguration.terraform.state.s3.bucketName }}"
    key    = "{{ .spec.toolsConfiguration.terraform.state.s3.keyPrefix }}/distribution.json"
    region = "{{ .spec.toolsConfiguration.terraform.state.s3.region }}"
  }
}

provider "aws" {
  region = "{{ .spec.toolsConfiguration.terraform.state.s3.region }}" # FIXME
}

data "aws_eks_cluster" "this" {
  name = "{{ .metadata.name }}"
}
