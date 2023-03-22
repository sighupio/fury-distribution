variable "kubectl_path" {
  type        = string
  description = "The path to the kubectl binary. By default, the one present in PATH is used"
  default = "kubectl"
}

