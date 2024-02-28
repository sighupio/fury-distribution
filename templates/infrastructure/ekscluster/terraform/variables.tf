/**
 * Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

variable "name" {
  description = "Name of the resources. Used as cluster name"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_enabled" {
  description = "Enable VPC creation"
  type        = bool
  default     = true
}

variable "vpc_public_subnetwork_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "vpc_private_subnetwork_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = []
}

variable "vpn_enabled" {
  description = "Enable VPN"
  type        = bool
  default     = true
}

variable "vpn_vpc_id" {
  description = "ID of the VPC"
  type        = string
  default     = ""
}

variable "vpn_public_subnets" {
  description = "Enable VPC"
  type        = list(string)
  default     = []
}

variable "vpn_subnetwork_cidr" {
  description = "CIDR used to assign VPN clients IP addresses, should be different from the network_cidr"
  type        = string
  default     = "192.168.200.0/24"
}

variable "vpn_instances" {
  description = "VPN Servers"
  type        = number
  default     = 1
}

variable "vpn_port" {
  description = "VPN Server Port"
  type        = number
  default     = 1194
}

variable "vpn_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "vpn_instance_disk_size" {
  description = "VPN main disk size"
  type        = number
  default     = 50
}

variable "vpn_operator_name" {
  description = "VPN operator name. Used to log into the instance via SSH"
  type        = string
  default     = "sighup"
}

variable "vpn_dhparams_bits" {
  description = "Diffie-Hellman (D-H) key size in bytes"
  type        = number
  default     = 2048
}

variable "vpn_operator_cidrs" {
  description = "VPN Operator cidrs. Used to log into the instance via SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vpn_ssh_users" {
  description = "GitHub users to sync public keys for SSH access"
  type        = list(string)
  default     = []
}

variable "vpn_bucket_name_prefix" {
  type        = string
  description = "Bucket name prefix for VPN configuration files"
  default     = ""
}
