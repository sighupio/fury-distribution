terraform {
  backend "s3" {
    bucket = "{{ .toolsConfiguration.terraform.state.s3.bucketName }}"
    key    = "{{ .toolsConfiguration.terraform.state.s3.keyPrefix }}/distribution.json"
    region = "{{ .toolsConfiguration.terraform.state.s3.region }}"
  }
}

provider "aws" {
  region = "{{ .toolsConfiguration.terraform.state.s3.region }}" # FIXME
}

data "aws_eks_cluster" "this" {
  name = "{{ .metadata.name }}"
}
