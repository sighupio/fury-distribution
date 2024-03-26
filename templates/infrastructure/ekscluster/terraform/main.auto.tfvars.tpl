/**
 * Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
 * Use of this source code is governed by a BSD-style
 * license that can be found in the LICENSE file.
 */

name = {{ .metadata.name | quote }}
{{- if and .spec.infrastructure (index .spec.infrastructure "vpc") }}
vpc_enabled = true
cidr = {{ .spec.infrastructure.vpc.network.cidr | quote }}
vpc_public_subnetwork_cidrs = {{ toJson .spec.infrastructure.vpc.network.subnetsCidrs.public }}
vpc_private_subnetwork_cidrs = {{ toJson .spec.infrastructure.vpc.network.subnetsCidrs.private }}
{{- else }}
vpc_enabled = false
{{- end }}
{{- if and .spec.infrastructure (index .spec.infrastructure "vpn") ((hasKeyAny .spec.infrastructure.vpn "instances") | ternary (and (index .spec.infrastructure.vpn "instances") (gt .spec.infrastructure.vpn.instances 0)) true) }}
vpn_enabled = true
vpn_subnetwork_cidr = {{ .spec.infrastructure.vpn.vpnClientsSubnetCidr | quote }}
{{- if index .spec.infrastructure.vpn "vpcId" }}
vpn_vpc_id = {{ .spec.infrastructure.vpn.vpcId | quote }}
{{- end }}
{{- if index .spec.infrastructure.vpn "instances" }}
vpn_instances = {{ .spec.infrastructure.vpn.instances }}
{{- end }}
{{- if and (index .spec.infrastructure.vpn "port") (ne .spec.infrastructure.vpn.port 0) }}
vpn_port = {{ .spec.infrastructure.vpn.port }}
{{- end }}
{{- if and (index .spec.infrastructure.vpn "instanceType") (ne .spec.infrastructure.vpn.instanceType "") }}
vpn_instance_type = {{ .spec.infrastructure.vpn.instanceType | quote }}
{{- end }}
{{- if and (index .spec.infrastructure.vpn "diskSize") (ne .spec.infrastructure.vpn.diskSize 0) }}
vpn_instance_disk_size = {{ .spec.infrastructure.vpn.diskSize }}
{{- end }}
{{- if and (index .spec.infrastructure.vpn "operatorName") (ne .spec.infrastructure.vpn.operatorName "") }}
vpn_operator_name = {{ .spec.infrastructure.vpn.operatorName | quote }}
{{- end }}
{{- if and (index .spec.infrastructure.vpn "dhParamsBits") (ne .spec.infrastructure.vpn.dhParamsBits 0) }}
vpn_dhparams_bits = {{ .spec.infrastructure.vpn.dhParamsBits }}
{{- end }}
{{- if and (index .spec.infrastructure.vpn "bucketNamePrefix") (ne .spec.infrastructure.vpn.bucketNamePrefix "") }}
vpn_bucket_name_prefix = {{ .spec.infrastructure.vpn.bucketNamePrefix | quote }}
{{- end }}
{{- if gt (len .spec.infrastructure.vpn.ssh.allowedFromCidrs) 0 }}
vpn_operator_cidrs = {{ toJson (.spec.infrastructure.vpn.ssh.allowedFromCidrs | uniq) }}
{{- end }}
{{- if gt (len .spec.infrastructure.vpn.ssh.githubUsersName) 0 }}
vpn_ssh_users = {{ toJson .spec.infrastructure.vpn.ssh.githubUsersName }}
{{- end }}
{{- else }}
vpn_enabled = false
{{- end }}
