module "load_balancer_controller_iam_role" {
  source       = "{{ print .common.relativeVendorPath "/modules/aws/iam-for-load-balancer-controller" }}"
  cluster_name = "{{ .metadata.name }}"
}

output "load_balancer_controller_iam_role_arn" {
  value = module.load_balancer_controller_iam_role.load_balancer_controller_iam_role_arn
}

