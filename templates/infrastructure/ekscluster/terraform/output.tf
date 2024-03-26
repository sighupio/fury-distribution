/**
 * Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

output "vpc_id" {
  description = "The ID of the VPC"
  value       = one(module.vpc[*].vpc_id)
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = one(module.vpc[*].vpc_cidr_block)
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = one(module.vpc[*].public_subnets)
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = one(module.vpc[*].public_subnets_cidr_blocks)
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = one(module.vpc[*].private_subnets)
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = one(module.vpc[*].private_subnets_cidr_blocks)
}

output "furyagent" {
  description = "furyagent.yml used by the vpn instance and ready to use to create a vpn profile"
  sensitive   = true
  value       = var.vpn_enabled ? one(module.vpn[*].furyagent) : null
}

output "vpn_ip" {
  description = "VPN instance IPs"
  value       = var.vpn_enabled ? one(module.vpn[*].vpn_ip) : null
}
