# EKSCluster - EKS Cluster Schema

This document explains the full schema for the `kind: EKSCluster` for the `furyctl.yaml` file used by `furyctl`. This configuration file will be used to deploy a Kubernetes Fury Cluster deployed through AWS's Elastic Kubernetes Service.

An example file can be found [here](https://github.com/sighupio/fury-distribution/blob/feature/schema-docs/templates/config/ekscluster-kfd-v1alpha2.yaml.tpl).

## Properties

| Property                  | Type     | Required |
|:--------------------------|:---------|:---------|
| [apiVersion](#apiversion) | `string` | Required |
| [kind](#kind)             | `string` | Required |
| [metadata](#metadata)     | `object` | Required |
| [spec](#spec)             | `object` | Required |

## .apiVersion

### Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^kfd\.sighup\.io/v\d+((alpha|beta)\d+)?$
```

[try pattern](https://regexr.com/?expression=%5Ekfd%5C.sighup%5C.io%5C%2Fv%5Cd%2B\(\(alpha%7Cbeta\)%5Cd%2B\%29%3F%24)

## .kind

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value          |
|:---------------|
| `"EKSCluster"` |

## .metadata

Properties

| Property              | Type     | Required |
|:----------------------|:---------|:---------|
| [name](#metadataname) | `string` | Required |

## .metadata.name

**maximum length**: the maximum number of characters for this string is: `19`

**minimum length**: the minimum number of characters for this string is: `1`

## .spec

### Properties

| Property                                        | Type     | Required  |
|:------------------------------------------------|:---------|:----------|
| [distributionVersion](#specdistributionversion) | `string` | Required  |
| [region](#specregion)                           | `string` | Required  |
| [tags](#spectags)                               | `object` | Optional  |
| [toolsConfiguration](#spectoolsconfiguration)   | `object` | Required  |
| [infrastructure](#specinfrastructure)           | `object` | Optional* |
| [kubernetes](#speckubernetes)                   | `object` | Required  |
| [distribution](#specdistribution)               | `object` | Required  |

*infrastructure: if omitted, you need to provide ***vpcId*** and ***subnetIds*** in .spec.kubernetes*

## .spec.distributionVersion

### Constraints

**minimum length**: the minimum number of characters for this string is: `1`

## .spec.region

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
| `"af-south-1"`     |
| `"ap-east-1"`      |
| `"ap-northeast-1"` |
| `"ap-northeast-2"` |
| `"ap-northeast-3"` |
| `"ap-south-1"`     |
| `"ap-south-2"`     |
| `"ap-southeast-1"` |
| `"ap-southeast-2"` |
| `"ap-southeast-3"` |
| `"ap-southeast-4"` |
| `"ca-central-1"`   |
| `"eu-central-1"`   |
| `"eu-central-2"`   |
| `"eu-north-1"`     |
| `"eu-south-1"`     |
| `"eu-south-2"`     |
| `"eu-west-1"`      |
| `"eu-west-2"`      |
| `"eu-west-3"`      |
| `"me-central-1"`   |
| `"me-south-1"`     |
| `"sa-east-1"`      |
| `"us-east-1"`      |
| `"us-east-2"`      |
| `"us-gov-east-1"`  |
| `"us-gov-west-1"`  |
| `"us-west-1"`      |
| `"us-west-2"`      |

## .spec.tags

### Description

This map defines which will be the common tags that will be added to all the resources created on AWS.

## .spec.toolsConfiguration

### Properties

| Property                                      | Type     | Required |
|:----------------------------------------------|:---------|:---------|
| [terraform](#spectoolsconfigurationterraform) | `object` | Required |

## .spec.toolsConfiguration.terraform

### Properties

| Property                                       | Type     | Required |
|:-----------------------------------------------|:---------|:---------|
| [state](#spectoolsconfigurationterraformstate) | `object` | Required |

## .spec.toolsConfiguration.terraform.state

### Properties

| Property                                      | Type     | Required |
|:----------------------------------------------|:---------|:---------|
| [s3](#spectoolsconfigurationterraformstates3) | `object` | Required |

## .spec.toolsConfiguration.terraform.state.s3

### Properties

| Property                                                                            | Type      | Required |
|:------------------------------------------------------------------------------------|:----------|:---------|
| [bucketName](#spectoolsconfigurationterraformstates3bucketname)                     | Merged    | Required |
| [keyPrefix](#spectoolsconfigurationterraformstates3keyprefix)                       | `string`  | Required |
| [region](#spectoolsconfigurationterraformstates3region)                             | `string`  | Required |
| [skipRegionValidation](#spectoolsconfigurationterraformstates3skipregionvalidation) | `boolean` | Optional |

## .spec.toolsConfiguration.terraform.state.s3.bucketName

### Description

This value defines which bucket will be used to store all the states

### Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^[a-z0-9][a-z0-9-.]{1,61}[a-z0-9]$
```

[try pattern](https://regexr.com/?expression=%5E%5Ba-z0-9%5D%5Ba-z0-9-.%5D%7B1%2C61%7D%5Ba-z0-9%5D%24)

and it must not match the following regular expression:&#x20;

```regexp
^xn--|-s3alias$
```

[try pattern](https://regexr.com/?expression=%5Exn--%7C-s3alias%24)

## .spec.toolsConfiguration.terraform.state.s3.keyPrefix

### Description

This value defines which folder will be used to store all the states inside the bucket

### Constraints

**maximum length**: the maximum number of characters for this string is: `960`
**pattern**: the string must match the following regular expression:&#x20;

```regexp
^[A-z0-9][A-z0-9!-_.*'()]+$
```

[try pattern](https://regexr.com/?expression=%5E%5BA-z0-9%5D%5BA-z0-9!-_.*'\(\)%5D%2B%24)

## .spec.toolsConfiguration.terraform.state.s3.region

### Description

This value defines in which region the bucket is located

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
| `"af-south-1"`     |
| `"ap-east-1"`      |
| `"ap-northeast-1"` |
| `"ap-northeast-2"` |
| `"ap-northeast-3"` |
| `"ap-south-1"`     |
| `"ap-south-2"`     |
| `"ap-southeast-1"` |
| `"ap-southeast-2"` |
| `"ap-southeast-3"` |
| `"ap-southeast-4"` |
| `"ca-central-1"`   |
| `"eu-central-1"`   |
| `"eu-central-2"`   |
| `"eu-north-1"`     |
| `"eu-south-1"`     |
| `"eu-south-2"`     |
| `"eu-west-1"`      |
| `"eu-west-2"`      |
| `"eu-west-3"`      |
| `"me-central-1"`   |
| `"me-south-1"`     |
| `"sa-east-1"`      |
| `"us-east-1"`      |
| `"us-east-2"`      |
| `"us-gov-east-1"`  |
| `"us-gov-west-1"`  |
| `"us-west-1"`      |
| `"us-west-2"`      |

## .spec.toolsConfiguration.terraform.state.s3.skipRegionValidation

### Description

This value defines if the region of the bucket should be validated or not by Terraform, useful when using a bucket in a recently added region

## .spec.infrastructure

### Properties

| Property                      | Type     | Required  |
|:------------------------------|:---------|:----------|
| [vpc](#specinfrastructurevpc) | `object` | Optional* |
| [vpn](#specinfrastructurevpn) | `object` | Optional  |

*vpc: if omitted, you need to provide ***vpcId*** and ***subnetIds*** in .spec.kubernetes*, and ***vpcId*** in .spec.infrastructure.vpn*

## .spec.infrastructure.vpc

### Description

This key defines the VPC that will be created in AWS

### Properties

| Property                                 | Type     | Required |
|:-----------------------------------------|:---------|:---------|
| [network](#specinfrastructurevpcnetwork) | `object` | Required |

## .spec.infrastructure.vpc.network

### Properties

| Property                                                  | Type     | Required |
|:----------------------------------------------------------|:---------|:---------|
| [cidr](#specinfrastructurevpcnetworkcidr)                 | `string` | Required |
| [subnetsCidrs](#specinfrastructurevpcnetworksubnetscidrs) | `object` | Required |

## .spec.infrastructure.vpc.network.cidr

### Description

This is the CIDR of the VPC that will be created

### Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/(3[0-2]|[1-2][0-9]|[0-9])$
```

[try pattern](https://regexr.com/?expression=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%5C%2F%283%5B0-2%5D%7C%5B1-2%5D%5B0-9%5D%7C%5B0-9%5D%29%24)

## .spec.infrastructure.vpc.network.subnetsCidrs

### Properties

| Property                                                    | Type    | Required |
|:------------------------------------------------------------|:--------|:---------|
| [private](#specinfrastructurevpcnetworksubnetscidrsprivate) | `array` | Required |
| [public](#specinfrastructurevpcnetworksubnetscidrspublic)   | `array` | Required |

## .spec.infrastructure.vpc.network.subnetsCidrs.private

### Description

These are the CIRDs for the private subnets, where the nodes, the pods, and the private load balancers will be created

### Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/(3[0-2]|[1-2][0-9]|[0-9])$
```

[try pattern](https://regexr.com/?expression=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%5C%2F%283%5B0-2%5D%7C%5B1-2%5D%5B0-9%5D%7C%5B0-9%5D%29%24)

## .spec.infrastructure.vpc.network.subnetsCidrs.public

### Description

These are the CIDRs for the public subnets, where the public load balancers and the VPN servers will be created

### Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/(3[0-2]|[1-2][0-9]|[0-9])$
```

[try pattern](https://regexr.com/?expression=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%5C%2F%283%5B0-2%5D%7C%5B1-2%5D%5B0-9%5D%7C%5B0-9%5D%29%24)

## .spec.infrastructure.vpn

### Description

This section defines the creation of VPN bastions

### Properties

| Property                                                           | Type      | Required  |
|:-------------------------------------------------------------------|:----------|:----------|
| [instances](#specinfrastructurevpninstances)                       | `integer` | Optional  |
| [port](#specinfrastructurevpnport)                                 | `integer` | Optional  |
| [instanceType](#specinfrastructurevpninstancetype)                 | `string`  | Optional  |
| [diskSize](#specinfrastructurevpndisksize)                         | `integer` | Optional  |
| [operatorName](#specinfrastructurevpnoperatorname)                 | `string`  | Optional  |
| [dhParamsBits](#specinfrastructurevpndhparamsbits)                 | `integer` | Optional  |
| [vpnClientsSubnetCidr](#specinfrastructurevpnvpnclientssubnetcidr) | `string`  | Required  |
| [ssh](#specinfrastructurevpnssh)                                   | `object`  | Required  |
| [vpcId](#specinfrastructurevpnvpcid)                               | `string`  | Optional* |
| [bucketNamePrefix](#specinfrastructurevpnbucketnameprefix)         | Merged    | Optional  |

*vpcId: required only if .spec.infrastructure.vpc is omitted*

## .spec.infrastructure.vpn.instances

### Description

The number of instances to create, 0 to skip the creation

## .spec.infrastructure.vpn.port

### Description

The port used by the OpenVPN server

### Constraints

**maximum**: the value of this property must be lower or equal to `65535`
**minimum**: the value of this property must be higher or equal to `1`

## .spec.infrastructure.vpn.instanceType

### Description

The size of the AWS EC2 instance

## .spec.infrastructure.vpn.diskSize

### Description

The size of the disk in GB

## .spec.infrastructure.vpn.operatorName

### Description

The username of the account to create in the bastion's operating system

## .spec.infrastructure.vpn.dhParamsBits

### Description

The dhParamsBits size used for the creation of the .pem file that will be used in the dh openvpn server.conf file

## .spec.infrastructure.vpn.vpnClientsSubnetCidr

### Description

The CIDR that will be used to assign IP addresses to the VPN clients when connected

### Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/(3[0-2]|[1-2][0-9]|[0-9])$
```

[try pattern](https://regexr.com/?expression=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%5C%2F%283%5B0-2%5D%7C%5B1-2%5D%5B0-9%5D%7C%5B0-9%5D%29%24)

## .spec.infrastructure.vpn.ssh

### Properties

| Property                                                      | Type    | Required |
|:--------------------------------------------------------------|:--------|:---------|
| [publicKeys](#specinfrastructurevpnsshpublickeys)             | `array` | Optional |
| [githubUsersName](#specinfrastructurevpnsshgithubusersname)   | `array` | Required |
| [allowedFromCidrs](#specinfrastructurevpnsshallowedfromcidrs) | `array` | Required |

## .spec.infrastructure.vpn.ssh.publicKeys

### Description

This value defines the public keys that will be added to the bastion's operating system

NOTES: Not yet implemented

## .spec.infrastructure.vpn.ssh.githubUsersName

### Description

The github user name list that will be used to get the ssh public key that will be added as authorized key to the operatorName user

### Constraints

**minimum number of items**: the minimum number of items for this array is: `1`

## .spec.infrastructure.vpn.ssh.allowedFromCidrs

### Description

The CIDR enabled in the security group that can access the bastions in SSH

### Constraints

**minimum number of items**: the minimum number of items for this array is: `1`

elements of the array must adhere to the following pattern:&#x20;

```regexp
^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/(3[0-2]|[1-2][0-9]|[0-9])$
```

[try pattern](https://regexr.com/?expression=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%5C%2F%283%5B0-2%5D%7C%5B1-2%5D%5B0-9%5D%7C%5B0-9%5D%29%24)

## .spec.infrastructure.vpn.vpcId

### Description

The VPC ID where the VPN servers will be created, required only if .spec.infrastructure.vpc is omitted

### Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^vpc\-([0-9a-f]{8}|[0-9a-f]{17})$
```

[try pattern](https://regexr.com/?expression=%5Evpc%5C-%28%5B0-9a-f%5D%7B8%7D%7C%5B0-9a-f%5D%7B17%7D%29%24)

## .spec.infrastructure.vpn.bucketNamePrefix

### Description

This value defines the prefix that will be used to create the bucket name where the VPN servers will store the states

### Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^[a-z0-9][a-z0-9-.]{1,35}[a-z0-9-.]$
```

[try pattern](https://regexr.com/?expression=%5E%5Ba-z0-9%5D%5Ba-z0-9-.%5D%7B1%2C35%7D%5Ba-z0-9-.%5D%24)

and it must not match the following regular expression:&#x20;

```regexp
^xn--|-s3alias$
```

## .spec.kubernetes

### Properties

| Property                                                          | Type      | Required |
|:------------------------------------------------------------------|:----------|:---------|
| [vpcId](#speckubernetesvpcid)                                     | `string`  | Optional |
| [subnetIds](#speckubernetessubnetids)                             | `array`   | Optional |
| [apiServer](#speckubernetesapiserver)                             | `object`  | Required |
| [serviceIpV4Cidr](#speckubernetesserviceipv4cidr)                 | `string`  | Optional |
| [nodeAllowedSshPublicKey](#speckubernetesnodeallowedsshpublickey) | `string`  | Required |
| [nodePoolsLaunchKind](#speckubernetesnodepoolslaunchkind)         | `string`  | Required |
| [logRetentionDays](#speckuberneteslogretentiondays)               | `integer` | Optional |
| [logsTypes](#speckuberneteslogstypes)                             | `array`   | Optional |
| [nodePools](#speckubernetesnodepools)                             | `array`   | Required |
| [awsAuth](#speckubernetesawsauth)                                 | `object`  | Optional |

*vpcId: required only if .spec.infrastructure.vpc is omitted*
*subnetIds: required only if .spec.infrastructure.vpc is omitted*

## .spec.kubernetes.vpcId

### Description

This value defines the VPC ID where the EKS cluster will be created, required only if .spec.infrastructure.vpc is omitted

### Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^vpc\-([0-9a-f]{8}|[0-9a-f]{17})$
```

[try pattern](https://regexr.com/?expression=%5Evpc%5C-%28%5B0-9a-f%5D%7B8%7D%7C%5B0-9a-f%5D%7B17%7D%29%24)

## .spec.kubernetes.subnetIds

### Description

This value defines the subnet IDs where the EKS cluster will be created, required only if .spec.infrastructure.vpc is omitted

### Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^subnet\-[0-9a-f]{17}$
```

[try pattern](https://regexr.com/?expression=%5Esubnet%5C-%5B0-9a-f%5D%7B17%7D%24)

## .spec.kubernetes.apiServer

### Properties

| Property                                                         | Type      | Required |
|:-----------------------------------------------------------------|:----------|:---------|
| [privateAccess](#speckubernetesapiserverprivateaccess)           | `boolean` | Required |
| [privateAccessCidrs](#speckubernetesapiserverprivateaccesscidrs) | `array`   | Optional |
| [publicAccessCidrs](#speckubernetesapiserverpublicaccesscidrs)   | `array`   | Optional |
| [publicAccess](#speckubernetesapiserverpublicaccess)             | `boolean` | Required |

## .spec.kubernetes.apiServer.privateAccess

### Description

This value defines if the API server will be accessible only from the private subnets

## .spec.kubernetes.apiServer.privateAccessCidrs

### Description

This value defines the CIDRs that will be allowed to access the API server from the private subnets

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

elements of the array must adhere to the following pattern:&#x20;

```regexp
^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/(3[0-2]|[1-2][0-9]|[0-9])$
```

[try pattern](https://regexr.com/?expression=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%5C%2F%283%5B0-2%5D%7C%5B1-2%5D%5B0-9%5D%7C%5B0-9%5D%29%24)

## .spec.kubernetes.apiServer.publicAccessCidrs

### Description

This value defines the CIDRs that will be allowed to access the API server from the public subnets

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

elements of the array must adhere to the following pattern:&#x20;

```regexp
^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/(3[0-2]|[1-2][0-9]|[0-9])$
```

[try pattern](https://regexr.com/?expression=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%5C%2F%283%5B0-2%5D%7C%5B1-2%5D%5B0-9%5D%7C%5B0-9%5D%29%24)

## .spec.kubernetes.apiServer.publicAccess

### Description

This value defines if the API server will be accessible from the public subnets

## .spec.kubernetes.serviceIpV4Cidr

### Description

This value defines the CIDR that will be used to assign IP addresses to the services

### Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/(3[0-2]|[1-2][0-9]|[0-9])$
```

[try pattern](https://regexr.com/?expression=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%5C%2F%283%5B0-2%5D%7C%5B1-2%5D%5B0-9%5D%7C%5B0-9%5D%29%24)

## .spec.kubernetes.nodeAllowedSshPublicKey

### Description

This key contains the ssh public key that can connect to the nodes via SSH using the ec2-user user

### Constraints

*pattern*: the string must match either the following regular expression:&#x20;

```regexp
^ssh\-(ed25519|rsa)\s+
```

[try pattern](https://regexr.com/?expression=%5Essh%5C-%28ed25519%7Crsa%29%5Cs%2B)

or the following regular expression:&#x20;

```regexp
^\{file\:\/\/.+\}$
```

[try pattern](https://regexr.com/?expression=%5E%5C%7Bfile%5C%3A%5C%2F%5C%2F.%2B%5C%7D%24)

## .spec.kubernetes.nodePoolsLaunchKind

### Description

Either `launch_configurations`, `launch_templates` or `both`. For new clusters use `launch_templates`, for existing cluster you'll need to migrate from `launch_configurations` to `launch_templates` using `both` as interim.

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                     |
|:--------------------------|
| `"launch_configurations"` |
| `"launch_templates"`      |
| `"both"`                  |

## .spec.kubernetes.logRetentionDays

### Description

Optional Kubernetes Cluster log retention in days. Defaults to 90 days.

## .spec.kubernetes.logsTypes

### Description

Optional list of Kubernetes Cluster log types to enable. Defaults to all types.

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                 |
|:----------------------|
| `"api"`               |
| `"audit"`             |
| `"authenticator"`     |
| `"controllerManager"` |
| `"scheduler"`         |

## .spec.kubernetes.nodePools

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [name](#speckubernetesnodepoolsname)                                       | `string` | Required |
| [type](#speckubernetesnodepoolstype)                                       | `string` | Optional |
| [ami](#speckubernetesnodepoolsami)                                         | `object` | Optional |
| [containerRuntime](#speckubernetesnodepoolscontainerruntime)               | `string` | Optional |
| [size](#speckubernetesnodepoolssize)                                       | `object` | Required |
| [instance](#speckubernetesnodepoolsinstance)                               | `object` | Required |
| [attachedTargetGroups](#speckubernetesnodepoolsattachedtargetgroups)       | `array`  | Optional |
| [labels](#speckubernetesnodepoolslabels)                                   | `object` | Optional |
| [taints](#speckubernetesnodepoolstaints)                                   | `array`  | Optional |
| [tags](#speckubernetesnodepoolstags)                                       | `object` | Optional |
| [subnetIds](#speckubernetesnodepoolssubnetids)                             | `array`  | Optional |
| [additionalFirewallRules](#speckubernetesnodepoolsadditionalfirewallrules) | `object` | Optional |

## .spec.kubernetes.nodePools.name

### Description

The name of the node pool

## .spec.kubernetes.nodePools.ami

### Properties

| Property                                  | Type     | Required |
|:------------------------------------------|:---------|:---------|
| [id](#speckubernetesnodepoolsamiid)       | `string` | Required |
| [owner](#speckubernetesnodepoolsamiowner) | `string` | Required |

## .spec.kubernetes.nodePools.ami.id

### Description

The AMI ID to use for the nodes

## .spec.kubernetes.nodePools.ami.owner

### Description

The owner of the AMI

## .spec.kubernetes.nodePools.containerRuntime

### Description

The container runtime to use for the nodes

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value          |
|:---------------|
| `"docker"`     |
| `"containerd"` |

## .spec.kubernetes.nodePools.size

### Properties

| Property                               | Type      | Required |
|:---------------------------------------|:----------|:---------|
| [max](#speckubernetesnodepoolssizemax) | `integer` | Required |
| [min](#speckubernetesnodepoolssizemin) | `integer` | Required |

## .spec.kubernetes.nodePools.size.max

### Description

The maximum number of nodes in the node pool

### Constraints

**minimum**: the value of this property must be higher or equal to `0`

## .spec.kubernetes.nodePools.size.min

### Description

The minimum number of nodes in the node pool

### Constraints

**minimum**: the value of this property must be higher or equal to `0`

## .spec.kubernetes.nodePools.instance

### Properties

| Property                                                 | Type      | Required |
|:---------------------------------------------------------|:----------|:---------|
| [type](#speckubernetesnodepoolsinstancetype)             | `string`  | Required |
| [spot](#speckubernetesnodepoolsinstancespot)             | `boolean` | Optional |
| [volumeSize](#speckubernetesnodepoolsinstancevolumesize) | `integer` | Optional |

## .spec.kubernetes.nodePools.instance.type

### Description

The instance type to use for the nodes

## .spec.kubernetes.nodePools.instance.spot

### Description

If true, the nodes will be created as spot instances

## .spec.kubernetes.nodePools.instance.volumeSize

### Description

The size of the disk in GB

## .spec.kubernetes.nodePools.attachedTargetGroups

### Description

This optional array defines additional target groups to attach to the instances in the node pool

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

elements of the array must adhere to the following pattern:&#x20;

```regexp
^arn:(?P<Partition>[^:\n]*):(?P<Service>[^:\n]*):(?P<Region>[^:\n]*):(?P<AccountID>[^:\n]*):(?P<Ignore>(?P<ResourceType>[^:\/\n]*)[:\/])?(?P<Resource>.*)$
```

[try pattern](https://regexr.com/?expression=%5Earn%3A%28%3FP%3CPartition%3E%5B%5E%3A%5Cn%5D*%29%3A%28%3FP%3CService%3E%5B%5E%3A%5Cn%5D*%29%3A%28%3FP%3CRegion%3E%5B%5E%3A%5Cn%5D*%29%3A%28%3FP%3CAccountID%3E%5B%5E%3A%5Cn%5D*%29%3A%28%3FP%3CIgnore%3E%28%3FP%3CResourceType%3E%5B%5E%3A%5C%2F%5Cn%5D*%29%5B%3A%5C%2F%5D%29%3F%28%3FP%3CResource%3E.*%29%24)

## .spec.kubernetes.nodePools.labels

### Description

Kubernetes labels that will be added to the nodes

## .spec.kubernetes.nodePools.taints

### Description

Kubernetes taints that will be added to the nodes

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

elements of the array must adhere to the following pattern:&#x20;

```regexp
^([a-zA-Z0-9\-\.\/]+)=(\w+):(NoSchedule|PreferNoSchedule|NoExecute)$
```

[try pattern](https://regexr.com/?expression=%5E%28%5Ba-zA-Z0-9%5C-%5C.%5C%2F%5D%2B%29%3D%28%5Cw%2B%29%3A%28NoSchedule%7CPreferNoSchedule%7CNoExecute%29%24)

## .spec.kubernetes.nodePools.tags

### Description

AWS tags that will be added to the ASG and EC2 instances

## .spec.kubernetes.nodePools.subnetIds

### Description

This value defines the subnet IDs where the nodes will be created

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

elements of the array must adhere to the following pattern:&#x20;

```regexp
^subnet\-[0-9a-f]{17}$
```

[try pattern](https://regexr.com/?expression=%5Esubnet%5C-%5B0-9a-f%5D%7B17%7D%24)

## .spec.kubernetes.nodePools.additionalFirewallRules

### Properties

| Property                                                                                      | Type     | Required |
|:----------------------------------------------------------------------------------------------|:---------|:---------|
| [cidrBlocks](#speckubernetesnodepoolsadditionalfirewallrulescidrblocks)                       | `array`  | Optional |
| [sourceSecurityGroupId](#speckubernetesnodepoolsadditionalfirewallrulessourcesecuritygroupid) | `array`  | Optional |
| [self](#speckubernetesnodepoolsadditionalfirewallrulesself)                                   | `array`  | Optional |

## .spec.kubernetes.nodePools.additionalFirewallRules.cidrBlocks

### Description

The CIDR blocks for the FW rule. At the moment the first item of the list will be used, others will be ignored.

### Constraints

**minimum number of items**: the minimum number of items for this array is: `1`

elements of the array must adhere to the following pattern:&#x20;

```regexp
^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/(3[0-2]|[1-2][0-9]|[0-9])$
```

[try pattern](https://regexr.com/?expression=%5E%28%2825%5B0-5%5D%7C%282%5B0-4%5D%7C1%5Cd%7C%5B1-9%5D%7C%29%5Cd%29%5C.%3F%5Cb%29%7B4%7D%5C%2F%283%5B0-2%5D%7C%5B1-2%5D%5B0-9%5D%7C%5B0-9%5D%29%24)

## .spec.kubernetes.nodePools.additionalFirewallRules.sourceSecurityGroupId

### Properties

| Property                                                                                                           | Type     | Required |
|:-------------------------------------------------------------------------------------------------------------------|:---------|:---------|
| [name](#speckubernetesnodepoolsadditionalfirewallrulessourcesecuritygroupidname)                                   | `string` | Required |
| [type](#speckubernetesnodepoolsadditionalfirewallrulessourcesecuritygroupidtype)                                   | `string` | Required |
| [tags](#speckubernetesnodepoolsadditionalfirewallrulessourcesecuritygroupidtags)                                   | `object` | Optional |
| [sourceSecurityGroupId](#speckubernetesnodepoolsadditionalfirewallrulessourcesecuritygroupidsourcesecuritygroupid) | `string` | Required |
| [protocol](#speckubernetesnodepoolsadditionalfirewallrulessourcesecuritygroupidprotocol)                           | `string` | Required |
| [ports](#speckubernetesnodepoolsadditionalfirewallrulessourcesecuritygroupidports)                                 | `object` | Required |

## .spec.kubernetes.nodePools.additionalFirewallRules.sourceSecurityGroupId.name

### Description

The name of the FW rule

## .spec.kubernetes.nodePools.additionalFirewallRules.sourceSecurityGroupId.type

### Description

The type of the FW rule can be ingress or egress

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
|:------------|
| `"ingress"` |
| `"egress"`  |

## .spec.kubernetes.nodePools.additionalFirewallRules.sourceSecurityGroupId.tags

### Description

The tags of the FW rule

## .spec.kubernetes.nodePools.additionalFirewallRules.sourceSecurityGroupId.sourceSecurityGroupId

### Description

The source security group ID

## .spec.kubernetes.nodePools.additionalFirewallRules.sourceSecurityGroupId.protocol

### Description

The protocol of the FW rule

### Constraints

this value should be lowercase, but we rely on terraform to do the conversion to make it a bit more user-friendly

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^(?i)(tcp|udp|icmp|icmpv6|-1)$
```

[try pattern](https://regexr.com/?expression=%5E%28%3Fi%29%28tcp%7Cudp%7Cicmp%7Cicmpv6%7C-1%29%24)

## .spec.kubernetes.nodePools.additionalFirewallRules.sourceSecurityGroupId.ports

### Properties

| Property                                                                              | Type      | Required |
|:--------------------------------------------------------------------------------------|:----------|:---------|
| [from](#speckubernetesnodepoolsadditionalfirewallrulessourcesecuritygroupidportsfrom) | `integer` | Required |
| [to](#speckubernetesnodepoolsadditionalfirewallrulessourcesecuritygroupidportsto)     | `integer` | Required |

## .spec.kubernetes.nodePools.additionalFirewallRules.sourceSecurityGroupId.ports.from

### Constraints

**maximum**: the value of this property must be lower or equal to `65535`
**minimum**: the value of this property must be higher or equal to `1`

## .spec.kubernetes.nodePools.additionalFirewallRules.sourceSecurityGroupId.ports.to

### Constraints

**maximum**: the value of this property must be lower or equal to `65535`
**minimum**: the value of this property must be higher or equal to `1`

## .spec.kubernetes.nodePools.additionalFirewallRules.self

### Properties

| Property                                                                | Type      | Required |
|:------------------------------------------------------------------------|:----------|:---------|
| [name](#speckubernetesnodepoolsadditionalfirewallrulesselfname)         | `string`  | Required |
| [type](#speckubernetesnodepoolsadditionalfirewallrulesselftype)         | `string`  | Required |
| [tags](#speckubernetesnodepoolsadditionalfirewallrulesselftags)         | `object`  | Optional |
| [self](#speckubernetesnodepoolsadditionalfirewallrulesselfself)         | `boolean` | Required |
| [protocol](#speckubernetesnodepoolsadditionalfirewallrulesselfprotocol) | `string`  | Required |
| [ports](#speckubernetesnodepoolsadditionalfirewallrulesselfports)       | `object`  | Required |

## .spec.kubernetes.nodePools.additionalFirewallRules.self.name

### Description

The name of the FW rule

## .spec.kubernetes.nodePools.additionalFirewallRules.self.type

### Description

The type of the FW rule can be ingress or egress

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
|:------------|
| `"ingress"` |
| `"egress"`  |

## .spec.kubernetes.nodePools.additionalFirewallRules.self.tags

### Description

The tags of the FW rule

## .spec.kubernetes.nodePools.additionalFirewallRules.self.self

### Description

If true, the source will be the security group itself

## .spec.kubernetes.nodePools.additionalFirewallRules.self.protocol

### Description

The protocol of the FW rule

### Constraints

this value should be lowercase, but we rely on terraform to do the conversion to make it a bit more user-friendly

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^(?i)(tcp|udp|icmp|icmpv6|-1)$
```

[try pattern](https://regexr.com/?expression=%5E%28%3Fi%29%28tcp%7Cudp%7Cicmp%7Cicmpv6%7C-1%29%24)

## .spec.kubernetes.nodePools.additionalFirewallRules.self.ports

### Properties

| Property                                                             | Type      | Required |
|:---------------------------------------------------------------------|:----------|:---------|
| [from](#speckubernetesnodepoolsadditionalfirewallrulesselfportsfrom) | `integer` | Required |
| [to](#speckubernetesnodepoolsadditionalfirewallrulesselfportsto)     | `integer` | Required |

## .spec.kubernetes.nodePools.additionalFirewallRules.self.ports.from

### Constraints

**maximum**: the value of this property must be lower or equal to `65535`
**minimum**: the value of this property must be higher or equal to `1`

## .spec.kubernetes.nodePools.additionalFirewallRules.self.ports.to

### Constraints

**maximum**: the value of this property must be lower or equal to `65535`
**minimum**: the value of this property must be higher or equal to `1`

## .spec.kubernetes.awsAuth

### Properties

| Property                                                       | Type    | Required |
|:---------------------------------------------------------------|:--------|:---------|
| [additionalAccounts](#speckubernetesawsauthadditionalaccounts) | `array` | Optional |
| [users](#speckubernetesawsauthusers)                           | `array` | Optional |
| [roles](#speckubernetesawsauthroles)                           | `array` | Optional |

## .spec.kubernetes.awsAuth.additionalAccounts

### Description

This optional array defines additional AWS accounts that will be added to the aws-auth configmap

## .spec.kubernetes.awsAuth.users

### Description

This optional array defines additional IAM users that will be added to the aws-auth configmap

## .spec.kubernetes.awsAuth.roles

### Description

This optional array defines additional IAM roles that will be added to the aws-auth configmap

## .spec.distribution

### Properties

| Property                                        | Type     | Required |
|:------------------------------------------------|:---------|:---------|
| [common](#specdistributioncommon)               | `object` | Optional |
| [modules](#specdistributionmodules)             | `object` | Required |
| [customPatches](#specdistributioncustompatches) | `object` | Optional |

## .spec.distribution.common

### Properties

| Property                                                        | Type     | Required |
|:----------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributioncommonnodeselector)             | `object` | Optional |
| [tolerations](#specdistributioncommontolerations)               | `array`  | Optional |
| [provider](#specdistributioncommonprovider)                     | `object` | Optional |
| [relativeVendorPath](#specdistributioncommonrelativevendorpath) | `string` | Optional |

## .spec.distribution.common.nodeSelector

### Description

The node selector to use to place the pods for all the KFD modules

## .spec.distribution.common.tolerations

### Properties

| Property                                               | Type     | Required |
|:-------------------------------------------------------|:---------|:---------|
| [effect](#specdistributioncommontolerationseffect)     | `string` | Required |
| [operator](#specdistributioncommontolerationsoperator) | `string` | Optional |
| [key](#specdistributioncommontolerationskey)           | `string` | Required |
| [value](#specdistributioncommontolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for all the KFD modules

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.common.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.common.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.common.tolerations.key

### Description

The key of the toleration

## .spec.distribution.common.tolerations.value

### Description

The value of the toleration

## .spec.distribution.common.provider

### Properties

| Property                                    | Type     | Required |
|:--------------------------------------------|:---------|:---------|
| [type](#specdistributioncommonprovidertype) | `string` | Required |

## .spec.distribution.common.provider.type

### Description

The type of the provider, must be EKS if specified

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value   |
|:--------|
| `"EKS"` |

## .spec.distribution.common.relativeVendorPath

### Description

The relative path to the vendor directory, does not need to be changed

## .spec.distribution.modules

### Properties

| Property                                         | Type     | Required |
|:-------------------------------------------------|:---------|:---------|
| [auth](#specdistributionmodulesauth)             | `object` | Optional |
| [aws](#specdistributionmodulesaws)               | `object` | Optional |
| [dr](#specdistributionmodulesdr)                 | `object` | Required |
| [ingress](#specdistributionmodulesingress)       | `object` | Required |
| [logging](#specdistributionmoduleslogging)       | `object` | Required |
| [monitoring](#specdistributionmodulesmonitoring) | `object` | Optional |
| [networking](#specdistributionmodulesnetworking) | `object` | Optional |
| [policy](#specdistributionmodulespolicy)         | `object` | Required |
| [tracing](#specdistributionmodulestracing)       | `object` | Optional |

## .spec.distribution.modules.auth

### Properties

| Property                                             | Type     | Required  |
|:-----------------------------------------------------|:---------|:----------|
| [overrides](#specdistributionmodulesauthoverrides)   | `object` | Optional  |
| [provider](#specdistributionmodulesauthprovider)     | `object` | Required  |
| [baseDomain](#specdistributionmodulesauthbasedomain) | `string` | Optional* |
| [pomerium](#specdistributionmodulesauthpomerium)     | `object` | Optional* |
| [dex](#specdistributionmodulesauthdex)               | `object` | Optional* |

*required only if .spec.distribution.modules.auth.provider.type is ***sso***, otherwise it must be null*

## .spec.distribution.modules.auth.overrides

### Properties

| Property                                                          | Type     | Required |
|:------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesauthoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesauthoverridestolerations)   | `array`  | Optional |
| [ingresses](#specdistributionmodulesauthoverridesingresses)       | `object` | Optional |

## .spec.distribution.modules.auth.overrides.nodeSelector

### Description

The node selector to use to place the pods for the auth module

## .spec.distribution.modules.auth.overrides.tolerations

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesauthoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesauthoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesauthoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesauthoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the auth module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.auth.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.auth.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.auth.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.auth.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.auth.overrides.ingresses

### Properties

| Property                                                                   | Type      | Required |
|:---------------------------------------------------------------------------|:----------|:---------|
| [host](#specdistributionmodulesauthoverridesingresseshost)                 | `string`  | Required |
| [ingressClass](#specdistributionmodulesauthoverridesingressesingressclass) | `string`  | Required |
| [disableAuth](#specdistributionmodulesauthoverridesingressesdisableauth)   | `boolean` | Optional |

## .spec.distribution.modules.auth.overrides.ingresses.host

### Description

The host of the ingress

## .spec.distribution.modules.auth.overrides.ingresses.ingressClass

### Description

The ingress class of the ingress

## .spec.distribution.modules.auth.overrides.ingresses.disableAuth

### Description

If true, the auth will be disabled for the ingress

## .spec.distribution.modules.auth.provider

### Properties

| Property                                                   | Type     | Required  |
|:-----------------------------------------------------------|:---------|:----------|
| [type](#specdistributionmodulesauthprovidertype)           | `string` | Required  |
| [basicAuth](#specdistributionmodulesauthproviderbasicauth) | `object` | Optional* |

*basicAuth is required only if .spec.distribution.modules.auth.provider.type is ***basicAuth***, otherwise it must be null*

## .spec.distribution.modules.auth.provider.type

### Description

The type of the provider, must be ***none***, ***sso*** or ***basicAuth***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value         |
|:--------------|
| `"none"`      |
| `"sso"`       |
| `"basicAuth"` |

## .spec.distribution.modules.auth.provider.basicAuth

### Properties

| Property                                                          | Type     | Required |
|:------------------------------------------------------------------|:---------|:---------|
| [username](#specdistributionmodulesauthproviderbasicauthusername) | `string` | Required |
| [password](#specdistributionmodulesauthproviderbasicauthpassword) | `string` | Required |

## .spec.distribution.modules.auth.provider.basicAuth.username

### Description

The username for the basic auth

## .spec.distribution.modules.auth.provider.basicAuth.password

### Description

The password for the basic auth

## .spec.distribution.modules.auth.baseDomain

### Description

The base domain for the auth module

## .spec.distribution.modules.auth.pomerium

### Properties

| Property                                                   | Type     | Required |
|:-----------------------------------------------------------|:---------|:---------|
| [secrets](#specdistributionmodulesauthpomeriumsecrets)     | `object` | Required |
| [policy](#specdistributionmodulesauthpomeriumpolicy)       | `string` | Required |
| [overrides](#specdistributionmodulesauthpomeriumoverrides) | `object` | Optional |

## .spec.distribution.modules.auth.pomerium.secrets

### Properties

| Property                                                                          | Type     | Required |
|:----------------------------------------------------------------------------------|:---------|:---------|
| [COOKIE\_SECRET](#specdistributionmodulesauthpomeriumsecretscookiesecret)         | `string` | Required |
| [IDP\_CLIENT\_SECRET](#specdistributionmodulesauthpomeriumsecretsidpclientsecret) | `string` | Required |
| [SHARED\_SECRET](#specdistributionmodulesauthpomeriumsecretssharedsecret)         | `string` | Required |

## .spec.distribution.modules.auth.pomerium.secrets.COOKIE\_SECRET

### Description

The cookie secret for pomerium

## .spec.distribution.modules.auth.pomerium.secrets.IDP\_CLIENT\_SECRET

### Description

The IDP client secret for pomerium

## .spec.distribution.modules.auth.pomerium.secrets.SHARED\_SECRET

### Description

The shared secret for pomerium

## .spec.distribution.modules.auth.pomerium.policy

### Description

The policy for pomerium

## .spec.distribution.modules.auth.pomerium.overrides

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesauthpomeriumoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesauthpomeriumoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.auth.pomerium.overrides.nodeSelector

### Description

The node selector to use to place the pods for the pomerium module

## .spec.distribution.modules.auth.pomerium.overrides.tolerations

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesauthpomeriumoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesauthpomeriumoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesauthpomeriumoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesauthpomeriumoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the pomerium module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.auth.pomerium.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.auth.pomerium.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.auth.pomerium.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.auth.pomerium.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.auth.dex

### Properties

| Property                                                | Type     | Required |
|:--------------------------------------------------------|:---------|:---------|
| [connectors](#specdistributionmodulesauthdexconnectors) | `array`  | Required |
| [overrides](#specdistributionmodulesauthdexoverrides)   | `object` | Optional |

## .spec.distribution.modules.auth.dex.connectors

### Description

The connectors for dex

## .spec.distribution.modules.auth.dex.overrides

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesauthdexoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesauthdexoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.auth.dex.overrides.nodeSelector

### Description

The node selector to use to place the pods for the dex module

## .spec.distribution.modules.auth.dex.overrides.tolerations

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesauthdexoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesauthdexoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesauthdexoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesauthdexoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the dex module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.auth.dex.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.auth.dex.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.auth.dex.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.auth.dex.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.aws

### Properties

| Property                                                                    | Type     | Required |
|:----------------------------------------------------------------------------|:---------|:---------|
| [clusterAutoscaler](#specdistributionmodulesawsclusterautoscaler)           | `object` | Optional |
| [ebsCsiDriver](#specdistributionmodulesawsebscsidriver)                     | `object` | Optional |
| [loadBalancerController](#specdistributionmodulesawsloadbalancercontroller) | `object` | Optional |
| [ebsSnapshotController](#specdistributionmodulesawsebssnapshotcontroller)   | `object` | Optional |
| [overrides](#specdistributionmodulesawsoverrides)                           | `object` | Optional |

## .spec.distribution.modules.aws.clusterAutoscaler

### Properties

| Property                                                           | Type     | Required |
|:-------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesawsclusterautoscaleroverrides) | `object` | Optional |

## .spec.distribution.modules.aws.clusterAutoscaler.overrides

### Properties

| Property                                                                          | Type     | Required |
|:----------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesawsclusterautoscaleroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesawsclusterautoscaleroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.aws.clusterAutoscaler.overrides.nodeSelector

### Description

The node selector to use to place the pods for the cluster autoscaler module

## .spec.distribution.modules.aws.clusterAutoscaler.overrides.tolerations

### Properties

| Property                                                                             | Type     | Required |
|:-------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesawsclusterautoscaleroverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesawsclusterautoscaleroverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesawsclusterautoscaleroverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesawsclusterautoscaleroverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the cluster autoscaler module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.aws.clusterAutoscaler.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.aws.clusterAutoscaler.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.aws.clusterAutoscaler.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.aws.clusterAutoscaler.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.aws.ebsCsiDriver

### Properties

| Property                                                      | Type     | Required |
|:--------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesawsebscsidriveroverrides) | `object` | Optional |

## .spec.distribution.modules.aws.ebsCsiDriver.overrides

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesawsebscsidriveroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesawsebscsidriveroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.aws.ebsCsiDriver.overrides.nodeSelector

### Description

The node selector to use to place the pods for the ebs csi driver module

## .spec.distribution.modules.aws.ebsCsiDriver.overrides.tolerations

### Properties

| Property                                                                        | Type     | Required |
|:--------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesawsebscsidriveroverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesawsebscsidriveroverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesawsebscsidriveroverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesawsebscsidriveroverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the ebs csi driver module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.aws.ebsCsiDriver.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.aws.ebsCsiDriver.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.aws.ebsCsiDriver.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.aws.ebsCsiDriver.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.aws.loadBalancerController

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesawsloadbalancercontrolleroverrides) | `object` | Optional |

## .spec.distribution.modules.aws.loadBalancerController.overrides

### Properties

| Property                                                                               | Type     | Required |
|:---------------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesawsloadbalancercontrolleroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesawsloadbalancercontrolleroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.aws.loadBalancerController.overrides.nodeSelector

### Description

The node selector to use to place the pods for the load balancer controller module

## .spec.distribution.modules.aws.loadBalancerController.overrides.tolerations

### Properties

| Property                                                                                  | Type     | Required |
|:------------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesawsloadbalancercontrolleroverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesawsloadbalancercontrolleroverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesawsloadbalancercontrolleroverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesawsloadbalancercontrolleroverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the load balancer controller module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.aws.loadBalancerController.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.aws.loadBalancerController.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.aws.loadBalancerController.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.aws.loadBalancerController.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.aws.ebsSnapshotController

### Properties

| Property                                                               | Type     | Required |
|:-----------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesawsebssnapshotcontrolleroverrides) | `object` | Optional |

## .spec.distribution.modules.aws.ebsSnapshotController.overrides

### Properties

| Property                                                                              | Type     | Required |
|:--------------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesawsebssnapshotcontrolleroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesawsebssnapshotcontrolleroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.aws.ebsSnapshotController.overrides.nodeSelector

### Description

The node selector to use to place the pods for the ebs snapshot controller module

## .spec.distribution.modules.aws.ebsSnapshotController.overrides.tolerations

### Properties

| Property                                                                                 | Type     | Required |
|:-----------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesawsebssnapshotcontrolleroverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesawsebssnapshotcontrolleroverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesawsebssnapshotcontrolleroverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesawsebssnapshotcontrolleroverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the ebs snapshot controller module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.aws.ebsSnapshotController.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.aws.ebsSnapshotController.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |


## .spec.distribution.modules.aws.ebsSnapshotController.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.aws.ebsSnapshotController.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.aws.overrides

### Properties

| Property                                                         | Type     | Required |
|:-----------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesawsoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesawsoverridestolerations)   | `array`  | Optional |
| [ingresses](#specdistributionmodulesawsoverridesingresses)       | `object` | Optional |

## .spec.distribution.modules.aws.overrides.nodeSelector

### Description

The node selector to use to place the pods for all the AWS modules

## .spec.distribution.modules.aws.overrides.tolerations

### Properties

| Property                                                            | Type     | Required |
|:--------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesawsoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesawsoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesawsoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesawsoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for all the AWS modules

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.aws.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.aws.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.aws.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.aws.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.aws.overrides.ingresses

### Properties

| Property                                                                  | Type      | Required |
|:--------------------------------------------------------------------------|:----------|:---------|
| [host](#specdistributionmodulesawsoverridesingresseshost)                 | `string`  | Required |
| [ingressClass](#specdistributionmodulesawsoverridesingressesingressclass) | `string`  | Required |
| [disableAuth](#specdistributionmodulesawsoverridesingressesdisableauth)   | `boolean` | Optional |

## .spec.distribution.modules.aws.overrides.ingresses.host

### Description

The host of the ingress

## .spec.distribution.modules.aws.overrides.ingresses.ingressClass

### Description

The ingress class of the ingress

## .spec.distribution.modules.aws.overrides.ingresses.disableAuth

### Description

If true, the auth will be disabled for the ingress

## .spec.distribution.modules.dr

### Properties

| Property                                         | Type     | Required  |
|:-------------------------------------------------|:---------|:----------|
| [overrides](#specdistributionmodulesdroverrides) | `object` | Optional  |
| [type](#specdistributionmodulesdrtype)           | `string` | Required  |
| [velero](#specdistributionmodulesdrvelero)       | `object` | Optional* |

*velero: required only if .spec.distribution.modules.dr.type is ***eks***, otherwise it must be null*

## .spec.distribution.modules.dr.overrides

### Properties

| Property                                                        | Type     | Required |
|:----------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesdroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesdroverridestolerations)   | `array`  | Optional |
| [ingresses](#specdistributionmodulesdroverridesingresses)       | `object` | Optional |

## .spec.distribution.modules.dr.overrides.nodeSelector

### Description

The node selector to use to place the pods for the dr module

## .spec.distribution.modules.dr.overrides.tolerations

### Properties

| Property                                                           | Type     | Required |
|:-------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesdroverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesdroverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesdroverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesdroverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the dr module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.dr.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.dr.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.dr.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.dr.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.dr.overrides.ingresses

### Properties

| Property                                                                 | Type      | Required |
|:-------------------------------------------------------------------------|:----------|:---------|
| [host](#specdistributionmodulesdroverridesingresseshost)                 | `string`  | Required |
| [ingressClass](#specdistributionmodulesdroverridesingressesingressclass) | `string`  | Required |
| [disableAuth](#specdistributionmodulesdroverridesingressesdisableauth)   | `boolean` | Optional |

## .spec.distribution.modules.dr.overrides.ingresses.host

### Description

The host of the ingress

## .spec.distribution.modules.dr.overrides.ingresses.ingressClass

### Description

The ingress class of the ingress

## .spec.distribution.modules.dr.overrides.ingresses.disableAuth

### Description

If true, the ingress will not have authentication

## .spec.distribution.modules.dr.type

### Description

The type of the DR, must be ***none*** or ***eks***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
| `"none"` |
| `"eks"`  |

## .spec.distribution.modules.dr.velero

### Properties

| Property                                               | Type     | Required |
|:-------------------------------------------------------|:---------|:---------|
| [eks](#specdistributionmodulesdrveleroeks)             | `object` | Required |
| [overrides](#specdistributionmodulesdrvelerooverrides) | `object` | Optional |

## .spec.distribution.modules.dr.velero.eks

### Properties

| Property                                                    | Type     | Required |
|:------------------------------------------------------------|:---------|:---------|
| [region](#specdistributionmodulesdrveleroeksregion)         | `string` | Required |
| [bucketName](#specdistributionmodulesdrveleroeksbucketname) | `string` | Required |

## .spec.distribution.modules.dr.velero.eks.region

### Description

The region where the velero bucket is located

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
| `"af-south-1"`     |
| `"ap-east-1"`      |
| `"ap-northeast-1"` |
| `"ap-northeast-2"` |
| `"ap-northeast-3"` |
| `"ap-south-1"`     |
| `"ap-south-2"`     |
| `"ap-southeast-1"` |
| `"ap-southeast-2"` |
| `"ap-southeast-3"` |
| `"ap-southeast-4"` |
| `"ca-central-1"`   |
| `"eu-central-1"`   |
| `"eu-central-2"`   |
| `"eu-north-1"`     |
| `"eu-south-1"`     |
| `"eu-south-2"`     |
| `"eu-west-1"`      |
| `"eu-west-2"`      |
| `"eu-west-3"`      |
| `"me-central-1"`   |
| `"me-south-1"`     |
| `"sa-east-1"`      |
| `"us-east-1"`      |
| `"us-east-2"`      |
| `"us-gov-east-1"`  |
| `"us-gov-west-1"`  |
| `"us-west-1"`      |
| `"us-west-2"`      |

## .spec.distribution.modules.dr.velero.eks.bucketName

### Description

The name of the velero bucket

### Constraints

**maxLength**: the string must be shorter than or equal to `49` characters

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^[a-z0-9][a-z0-9-.]{1,61}[a-z0-9]$
```

[try pattern](https://regexr.com/?expression=%5E%5Ba-z0-9%5D%5Ba-z0-9-.%5D%7B1%2C61%7D%5Ba-z0-9%5D%24)

and it must not match the following regular expression:&#x20;

```regexp
^xn--|-s3alias$
```

[try pattern](https://regexr.com/?expression=%5Exn--%7C-s3alias%24)

## .spec.distribution.modules.dr.velero.overrides

### Properties

| Property                                                              | Type     | Required |
|:----------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesdrvelerooverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesdrvelerooverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.dr.velero.overrides.nodeSelector

### Description

The node selector to use to place the pods for the velero module

## .spec.distribution.modules.dr.velero.overrides.tolerations

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesdrvelerooverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesdrvelerooverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesdrvelerooverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesdrvelerooverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the velero module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.dr.velero.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.dr.velero.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.dr.velero.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.dr.velero.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.ingress

### Properties

| Property                                                  | Type     | Required  |
|:----------------------------------------------------------|:---------|:----------|
| [overrides](#specdistributionmodulesingressoverrides)     | `object` | Optional  |
| [baseDomain](#specdistributionmodulesingressbasedomain)   | `string` | Required  |
| [nginx](#specdistributionmodulesingressnginx)             | `object` | Required  |
| [certManager](#specdistributionmodulesingresscertmanager) | `object` | Optional* |
| [forecastle](#specdistributionmodulesingressforecastle)   | `object` | Optional  |
| [dns](#specdistributionmodulesingressdns)                 | `object` | Required  |

*certManager: required only if .spec.distribution.modules.ingress.nginx.tls.provider is ***certManager****

## .spec.distribution.modules.ingress.overrides

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesingressoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesingressoverridestolerations)   | `array`  | Optional |
| [ingresses](#specdistributionmodulesingressoverridesingresses)       | `object` | Optional |

## .spec.distribution.modules.ingress.overrides.nodeSelector

### Description

The node selector to use to place the pods for the ingress module

## .spec.distribution.modules.ingress.overrides.tolerations

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesingressoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesingressoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesingressoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesingressoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the ingress module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.ingress.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.ingress.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.ingress.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.ingress.overrides.ingresses

### Properties

| Property                                                                      | Type     | Required |
|:------------------------------------------------------------------------------|:---------|:---------|
| [forecastle](#specdistributionmodulesingressoverridesingressesforecastle)     | `object` | Optional |

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle

### Properties

| Property                                                                                | Type      | Required |
|:----------------------------------------------------------------------------------------|:----------|:---------|
| [host](#specdistributionmodulesingressoverridesingressesforecastlehost)                 | `string`  | Optional |
| [ingressClass](#specdistributionmodulesingressoverridesingressesforecastleingressclass) | `string`  | Optional |
| [disableAuth](#specdistributionmodulesingressoverridesingressesforecastledisableauth)   | `boolean` | Optional |

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle.host

### Description

The host of the ingress

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle.ingressClass

### Description

The ingress class of the ingress

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle.disableAuth

### Description

If true, auth will be disabled for the ingress

## .spec.distribution.modules.ingress.overrides.ingresses.nodeSelector

### Description

The node selector to use to place the pods for the ingress module

## .spec.distribution.modules.ingress.overrides.ingresses.tolerations

### Properties

| Property                                                                         | Type     | Required |
|:---------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesingressoverridesingressestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesingressoverridesingressestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesingressoverridesingressestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesingressoverridesingressestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the ingress module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.ingress.overrides.ingresses.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.ingress.overrides.ingresses.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.ingress.overrides.ingresses.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.overrides.ingresses.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.ingress.baseDomain

### Description

the base domain used for all the KFD ingresses, if in the nginx dual configuration, it should be the same as the .spec.distribution.modules.ingress.dns.private.name zone

## .spec.distribution.modules.ingress.nginx

### Description

Configurations for the nginx ingress controller module

### Properties

| Property                                                   | Type     | Required |
|:-----------------------------------------------------------|:---------|:---------|
| [type](#specdistributionmodulesingressnginxtype)           | `string` | Required |
| [tls](#specdistributionmodulesingressnginxtls)             | `object` | Optional |
| [overrides](#specdistributionmodulesingressnginxoverrides) | `object` | Optional |

## .spec.distribution.modules.ingress.nginx.type

### Description

The type of the nginx ingress controller, must be ***none***, ***single*** or ***dual***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"none"`   |
| `"single"` |
| `"dual"`   |

## .spec.distribution.modules.ingress.nginx.tls

### Properties

| Property                                                    | Type     | Required  |
|:------------------------------------------------------------|:---------|:----------|
| [provider](#specdistributionmodulesingressnginxtlsprovider) | `string` | Required  |
| [secret](#specdistributionmodulesingressnginxtlssecret)     | `object` | Optional* |

*secret: required only if .spec.distribution.modules.ingress.nginx.tls.provider is ***secret****

## .spec.distribution.modules.ingress.nginx.tls.provider

### Description

The provider of the TLS certificate, must be ***none***, ***certManager*** or ***secret***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value           |
|:----------------|
| `"none"`        |
| `"certManager"` |
| `"secret"`      |

## .spec.distribution.modules.ingress.nginx.tls.secret

### Properties

| Property                                                  | Type     | Required |
|:----------------------------------------------------------|:---------|:---------|
| [cert](#specdistributionmodulesingressnginxtlssecretcert) | `string` | Required |
| [key](#specdistributionmodulesingressnginxtlssecretkey)   | `string` | Required |
| [ca](#specdistributionmodulesingressnginxtlssecretca)     | `string` | Required |

## .spec.distribution.modules.ingress.nginx.tls.secret.cert

### Description

The certificate file content or you can use the file notation to get the content from a file

## .spec.distribution.modules.ingress.nginx.tls.secret.key

The key file, a file notation can be used to get the content from a file

## .spec.distribution.modules.ingress.nginx.tls.secret.ca

The ca file, a file notation can be used to get the content from a file

## .spec.distribution.modules.ingress.nginx.overrides

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesingressnginxoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesingressnginxoverridestolerations)   | `array`  | Optional |


## .spec.distribution.modules.ingress.nginx.overrides.nodeSelector

### Description

The node selector to use to place the pods for the nginx module

## .spec.distribution.modules.ingress.nginx.overrides.tolerations

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesingressnginxoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesingressnginxoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesingressnginxoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesingressnginxoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the nginx module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.ingress.nginx.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.ingress.nginx.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.ingress.nginx.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.nginx.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.ingress.certManager

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [clusterIssuer](#specdistributionmodulesingresscertmanagerclusterissuer) | Merged   | Required |
| [overrides](#specdistributionmodulesingresscertmanageroverrides)         | `object` | Optional |

## .spec.distribution.modules.ingress.certManager.clusterIssuer

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [name](#specdistributionmodulesingresscertmanagerclusterissuername)       | `string` | Required |
| [email](#specdistributionmodulesingresscertmanagerclusterissueremail)     | `string` | Required |
| [type](#specdistributionmodulesingresscertmanagerclusterissuertype)       | `string` | Optional |
| [solvers](#specdistributionmodulesingresscertmanagerclusterissuersolvers) | `array`  | Optional |

****type*** and ***solvers*** cannot be set at the same time*

## .spec.distribution.modules.ingress.certManager.clusterIssuer.name

### Description

The name of the cluster issuer

## .spec.distribution.modules.ingress.certManager.clusterIssuer.email

### Description

The email of the cluster issuer

## .spec.distribution.modules.ingress.certManager.clusterIssuer.type

### Description

The type of the cluster issuer, must be ***dns01*** or ***http01***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"dns01"`  |
| `"http01"` |

## .spec.distribution.modules.ingress.certManager.clusterIssuer.solvers

### Description

The custom solvers configurations

## .spec.distribution.modules.ingress.certManager.overrides

### Properties

| Property                                                                        | Type     | Required |
|:--------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesingresscertmanageroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesingresscertmanageroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.ingress.certManager.overrides.nodeSelector

### Description

The node selector to use to place the pods for the cert-manager module

## .spec.distribution.modules.ingress.certManager.overrides.tolerations

### Properties

| Property                                                                           | Type     | Required |
|:-----------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesingresscertmanageroverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesingresscertmanageroverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesingresscertmanageroverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesingresscertmanageroverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the cert-manager module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.ingress.certManager.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.ingress.certManager.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.ingress.certManager.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.certManager.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.ingress.forecastle

### Properties

| Property                                                        | Type     | Required |
|:----------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesingressforecastleoverrides) | `object` | Optional |

## .spec.distribution.modules.ingress.forecastle.overrides

### Properties

| Property                                                                       | Type     | Required |
|:-------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesingressforecastleoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesingressforecastleoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.ingress.forecastle.overrides.nodeSelector

### Description

The node selector to use to place the pods for the forecastle module

## .spec.distribution.modules.ingress.forecastle.overrides.tolerations

### Properties

| Property                                                                          | Type     | Required |
|:----------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesingressforecastleoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesingressforecastleoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesingressforecastleoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesingressforecastleoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the forecastle module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.ingress.forecastle.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.ingress.forecastle.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.ingress.forecastle.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.forecastle.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.ingress.dns

### Properties

| Property                                                 | Type     | Required |
|:---------------------------------------------------------|:---------|:---------|
| [private](#specdistributionmodulesingressdnsprivate)     | `object` | Required |
| [public](#specdistributionmodulesingressdnspublic)       | `object` | Required |
| [overrides](#specdistributionmodulesingressdnsoverrides) | `object` | Optional |

## .spec.distribution.modules.ingress.dns.private

### Properties

| Property                                                  | Type      | Required |
|:----------------------------------------------------------|:----------|:---------|
| [name](#specdistributionmodulesingressdnsprivatename)     | `string`  | Required |
| [create](#specdistributionmodulesingressdnsprivatecreate) | `boolean` | Required |

## .spec.distribution.modules.ingress.dns.private.name

### Description

The name of the private hosted zone

## .spec.distribution.modules.ingress.dns.private.create

### Description

If true, the private hosted zone will be created

## .spec.distribution.modules.ingress.dns.public

### Properties

| Property                                                 | Type      | Required |
|:---------------------------------------------------------|:----------|:---------|
| [name](#specdistributionmodulesingressdnspublicname)     | `string`  | Required |
| [create](#specdistributionmodulesingressdnspubliccreate) | `boolean` | Required |

## .spec.distribution.modules.ingress.dns.public.name

### Description

The name of the public hosted zone

## .spec.distribution.modules.ingress.dns.public.create

### Description

If true, the public hosted zone will be created

## .spec.distribution.modules.ingress.dns.overrides

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesingressdnsoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesingressdnsoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.ingress.dns.overrides.nodeSelector

### Description

The node selector to use to place the pods for the ingress module

## .spec.distribution.modules.ingress.dns.overrides.tolerations

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesingressdnsoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesingressdnsoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesingressdnsoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesingressdnsoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the ingress module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.ingress.dns.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.ingress.dns.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.ingress.dns.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.dns.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.logging

| Property                                                | Type     | Required  |
|:--------------------------------------------------------|:---------|:----------|
| [overrides](#specdistributionmodulesloggingoverrides)   | `object` | Optional  |
| [type](#specdistributionmodulesloggingtype)             | `string` | Required  |
| [opensearch](#specdistributionmodulesloggingopensearch) | `object` | Optional* |
| [loki](#specdistributionmodulesloggingloki)             | `object` | Optional  |
| [cerebro](#specdistributionmodulesloggingcerebro)       | `object` | Optional  |
| [minio](#specdistributionmodulesloggingminio)           | `object` | Optional  |
| [operator](#specdistributionmodulesloggingoperator)     | `object` | Optional  |

*opensearch: required only if .spec.distribution.modules.logging.type is ***opensearch****

## .spec.distribution.modules.logging.overrides

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesloggingoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesloggingoverridestolerations)   | `array`  | Optional |
| [ingresses](#specdistributionmodulesloggingoverridesingresses)       | `object` | Optional |

## .spec.distribution.modules.logging.overrides.nodeSelector

### Description

The node selector to use to place the pods for the logging module

## .spec.distribution.modules.logging.overrides.tolerations

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesloggingoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesloggingoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesloggingoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesloggingoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the logging module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.logging.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.logging.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.logging.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.logging.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.logging.overrides.ingresses

### Properties

| Property                                                                      | Type      | Required |
|:------------------------------------------------------------------------------|:----------|:---------|
| [host](#specdistributionmodulesloggingoverridesingresseshost)                 | `string`  | Required |
| [ingressClass](#specdistributionmodulesloggingoverridesingressesingressclass) | `string`  | Required |
| [disableAuth](#specdistributionmodulesloggingoverridesingressesdisableauth)   | `boolean` | Optional |

## .spec.distribution.modules.logging.overrides.ingresses.host

### Description

The host of the ingress

## .spec.distribution.modules.logging.overrides.ingresses.ingressClass

### Description

The ingress class of the ingress

## .spec.distribution.modules.logging.overrides.ingresses.disableAuth

### Description

If true, the ingress will not have authentication

## .spec.distribution.modules.logging.type

### Description

The type of the logging, must be ***none***, ***opensearch*** or ***loki***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value          |
|:---------------|
| `"none"`       |
| `"opensearch"` |
| `"loki"`       |

## .spec.distribution.modules.logging.opensearch

### Properties

| Property                                                            | Type     | Required |
|:--------------------------------------------------------------------|:---------|:---------|
| [type](#specdistributionmodulesloggingopensearchtype)               | `string` | Required |
| [resources](#specdistributionmodulesloggingopensearchresources)     | `object` | Optional |
| [storageSize](#specdistributionmodulesloggingopensearchstoragesize) | `string` | Optional |
| [overrides](#specdistributionmodulesloggingopensearchoverrides)     | `object` | Optional |

## .spec.distribution.modules.logging.opensearch.type

### Description

The type of the opensearch, must be ***single*** or ***triple***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value          |
|:---------------|
| `"single"`     |
| `"triple"`     |

## .spec.distribution.modules.logging.opensearch.resources

### Properties

| Property                                                               | Type     | Required |
|:-----------------------------------------------------------------------|:---------|:---------|
| [requests](#specdistributionmodulesloggingopensearchresourcesrequests) | `object` | Optional |
| [limits](#specdistributionmodulesloggingopensearchresourceslimits)     | `object` | Optional |

## .spec.distribution.modules.logging.opensearch.resources.requests

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmodulesloggingopensearchresourcesrequestscpu)       | `string` | Optional |
| [memory](#specdistributionmodulesloggingopensearchresourcesrequestsmemory) | `string` | Optional |

## .spec.distribution.modules.logging.opensearch.resources.requests.cpu

### Description

The cpu request for the opensearch pods

## .spec.distribution.modules.logging.opensearch.resources.requests.memory

### Description

The memory request for the opensearch pods

## .spec.distribution.modules.logging.opensearch.resources.limits

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmodulesloggingopensearchresourceslimitscpu)       | `string` | Optional |
| [memory](#specdistributionmodulesloggingopensearchresourceslimitsmemory) | `string` | Optional |

## .spec.distribution.modules.logging.opensearch.resources.limits.cpu

### Description

The cpu limit for the opensearch pods

## .spec.distribution.modules.logging.opensearch.resources.limits.memory

### Description

The memory limit for the opensearch pods

## .spec.distribution.modules.logging.opensearch.storageSize

### Description

The storage size for the opensearch pods

## .spec.distribution.modules.logging.opensearch.overrides

### Properties

| Property                                                                       | Type     | Required |
|:-------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesloggingopensearchoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesloggingopensearchoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.logging.opensearch.overrides.nodeSelector

### Description

The node selector to use to place the pods for the opensearch module

## .spec.distribution.modules.logging.opensearch.overrides.tolerations

### Properties

| Property                                                                          | Type     | Required |
|:----------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesloggingopensearchoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesloggingopensearchoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesloggingopensearchoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesloggingopensearchoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the opensearch module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.logging.opensearch.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.logging.opensearch.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |
| `"Exists"` |

## .spec.distribution.modules.logging.opensearch.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.logging.opensearch.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.logging.loki

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [resources](#specdistributionmoduleslogginglokiresources)               | `object` | Optional |
| [backend](#specdistributionmoduleslogginglokibackend)                   | `object` | Optional |
| [externalEndpoint](#specdistributionmoduleslogginglokiexternalendpoint) | `string` | Optional |

## .spec.distribution.modules.logging.loki.resources

### Properties

| Property                                                         | Type     | Required |
|:-----------------------------------------------------------------|:---------|:---------|
| [requests](#specdistributionmoduleslogginglokiresourcesrequests) | `object` | Optional |
| [limits](#specdistributionmoduleslogginglokiresourceslimits)     | `object` | Optional |

## .spec.distribution.modules.logging.loki.resources.requests

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmoduleslogginglokiresourcesrequestscpu)       | `string` | Optional |
| [memory](#specdistributionmoduleslogginglokiresourcesrequestsmemory) | `string` | Optional |

## .spec.distribution.modules.logging.loki.resources.requests.cpu

### Description

The cpu request for the loki pods

## .spec.distribution.modules.logging.loki.resources.requests.memory

### Description

The memory request for the loki pods

## .spec.distribution.modules.logging.loki.resources.limits

### Properties

| Property                                                           | Type     | Required |
|:-------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmoduleslogginglokiresourceslimitscpu)       | `string` | Optional |
| [memory](#specdistributionmoduleslogginglokiresourceslimitsmemory) | `string` | Optional |

## .spec.distribution.modules.logging.loki.resources.limits.cpu

### Description

The cpu limit for the loki pods

## .spec.distribution.modules.logging.loki.resources.limits.memory

### Description

The memory limit for the loki pods

## .spec.distribution.modules.logging.loki.backend

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [type](#specdistributionmoduleslogginglokibackendtype)                   | `string` | Required |

## .spec.distribution.modules.logging.loki.backend.type

### Description

The type of the loki backend, must be ***minio*** or ***externalEndpoint***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                   |
|:------------------------|
| `"minio"`               |
| `"externalEndpoint"`    |

## .spec.distribution.modules.logging.loki.externalEndpoint

### Properties

| Property                                                                              | Type      | Required |
|:--------------------------------------------------------------------------------------|:----------|:---------|
| [endpoint](#specdistributionmoduleslogginglokiexternalendpointendpoint)               | `string`  | Required |
| [insecure](#specdistributionmoduleslogginglokiexternalendpointinsecure)               | `boolean` | Optional |
| [secretAccessKey](#specdistributionmoduleslogginglokiexternalendpointsecretaccesskey) | `string`  | Optional |
| [accessKeyId](#specdistributionmoduleslogginglokiexternalendpointaccesskeyid)         | `string`  | Optional |
| [bucketName](#specdistributionmoduleslogginglokiexternalendpointbucketname)           | `string`  | Optional |

## .spec.distribution.modules.logging.loki.externalEndpoint.endpoint

### Description

The endpoint of the loki external endpoint

## .spec.distribution.modules.logging.loki.externalEndpoint.insecure

### Description

If true, the loki external endpoint will be insecure

## .spec.distribution.modules.logging.loki.externalEndpoint.secretAccessKey

### Description

The secret access key of the loki external endpoint

## .spec.distribution.modules.logging.loki.externalEndpoint.accessKeyId

### Description

The access key id of the loki external endpoint

## .spec.distribution.modules.logging.loki.externalEndpoint.bucketName

### Description

The bucket name of the loki external endpoint

## .spec.distribution.modules.logging.cerebro

### Properties

| Property                                                     | Type     | Required |
|:-------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesloggingcerebrooverrides) | `object` | Optional |

## .spec.distribution.modules.logging.cerebro.overrides

### Properties

| Property                                                                    | Type     | Required |
|:----------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesloggingcerebrooverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesloggingcerebrooverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.logging.cerebro.overrides.nodeSelector

### Description

The node selector to use to place the pods for the cerebro module

## .spec.distribution.modules.logging.cerebro.overrides.tolerations

### Properties

| Property                                                                       | Type     | Required |
|:-------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesloggingcerebrooverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesloggingcerebrooverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesloggingcerebrooverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesloggingcerebrooverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the cerebro module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.logging.cerebro.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.logging.cerebro.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.logging.cerebro.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.logging.cerebro.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.logging.minio

### Properties

| Property                                                       | Type     | Required |
|:---------------------------------------------------------------|:---------|:---------|
| [storageSize](#specdistributionmodulesloggingminiostoragesize) | `string` | Optional |
| [overrides](#specdistributionmodulesloggingminiooverrides)     | `object` | Optional |
| [rootUser](#specdistributionmodulesloggingminiorootuser)       | `object` | Optional |

## .spec.distribution.modules.logging.minio.storageSize

### Description

The PVC size for each minio disk, 6 disks total

## .spec.distribution.modules.logging.minio.rootUser

### Properties

| Property                                                         | Type     | Required |
|:-----------------------------------------------------------------|:---------|:---------|
| [username](#specdistributionmodulesloggingminiorootusername)     | `string` | Required |
| [password](#specdistributionmodulesloggingminiorootuserpassword) | `string` | Required |

## .spec.distribution.modules.logging.minio.rootUser.username

### Description

The username of the minio root user

## .spec.distribution.modules.logging.minio.rootUser.password

### Description

The password of the minio root user

## .spec.distribution.modules.logging.minio.overrides

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesloggingminiooverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesloggingminiooverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.logging.minio.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.logging.minio.overrides.tolerations

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesloggingminiooverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesloggingminiooverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesloggingminiooverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesloggingminiooverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the minio module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.logging.minio.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.logging.minio.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |


## .spec.distribution.modules.logging.minio.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.logging.minio.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.logging.operator

### Properties

| Property                                                      | Type     | Required |
|:--------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesloggingoperatoroverrides) | `object` | Optional |

## .spec.distribution.modules.logging.operator.overrides

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesloggingoperatoroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesloggingoperatoroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.logging.operator.overrides.nodeSelector

### Description

The node selector to use to place the pods for the operator module

## .spec.distribution.modules.logging.operator.overrides.tolerations

### Properties

| Property                                                                        | Type     | Required |
|:--------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesloggingoperatoroverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesloggingoperatoroverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesloggingoperatoroverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesloggingoperatoroverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the operator module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.logging.operator.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.logging.operator.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.logging.operator.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.logging.operator.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring

### Properties

| Property                                                               | Type     | Required |
|:-----------------------------------------------------------------------|:---------|:---------|
| [type](#specdistributionmodulesmonitoringtype)                         | `string` | Required |
| [overrides](#specdistributionmodulesmonitoringoverrides)               | `object` | Optional |
| [prometheus](#specdistributionmodulesmonitoringprometheus)             | `object` | Optional |
| [alertmanager](#specdistributionmodulesmonitoringalertmanager)         | `object` | Optional |
| [grafana](#specdistributionmodulesmonitoringgrafana)                   | `object` | Optional |
| [blackboxExporter](#specdistributionmodulesmonitoringblackboxexporter) | `object` | Optional |
| [kubeStateMetrics](#specdistributionmodulesmonitoringkubestatemetrics) | `object` | Optional |
| [x509Exporter](#specdistributionmodulesmonitoringx509exporter)         | `object` | Optional |
| [mimir](#specdistributionmodulesmonitoringmimir)                       | `object` | Optional |
| [minio](#specdistributionmodulesmonitoringminio)                       | `object` | Optional |

## .spec.distribution.modules.monitoring.type

### Description

The type of the monitoring, must be ***none***, ***prometheus*** or ***mimir***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value          |
|:---------------|
| `"none"`       |
| `"prometheus"` |
| `"mimir"`      |

## .spec.distribution.modules.monitoring.overrides

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesmonitoringoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesmonitoringoverridestolerations)   | `array`  | Optional |
| [ingresses](#specdistributionmodulesmonitoringoverridesingresses)       | `object` | Optional |

## .spec.distribution.modules.monitoring.overrides.nodeSelector

### Description

The node selector to use to place the pods for the monitoring module

## .spec.distribution.modules.monitoring.overrides.tolerations

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesmonitoringoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesmonitoringoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesmonitoringoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the monitoring module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.monitoring.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.monitoring.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.monitoring.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.overrides.ingresses

### Properties

| Property                                                                         | Type      | Required |
|:---------------------------------------------------------------------------------|:----------|:---------|
| [host](#specdistributionmodulesmonitoringoverridesingresseshost)                 | `string`  | Required |
| [ingressClass](#specdistributionmodulesmonitoringoverridesingressesingressclass) | `string`  | Required |
| [disableAuth](#specdistributionmodulesmonitoringoverridesingressesdisableauth)   | `boolean` | Optional |

## .spec.distribution.modules.monitoring.overrides.ingresses.host

### Description

The host of the ingress

## .spec.distribution.modules.monitoring.overrides.ingresses.ingressClass

### Description

The ingress class of the ingress

## .spec.distribution.modules.monitoring.overrides.ingresses.disableAuth

### Description

If true, the ingress will not have authentication

## .spec.distribution.modules.monitoring.prometheus

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [resources](#specdistributionmodulesmonitoringprometheusresources)         | `object` | Optional |
| [retentionTime](#specdistributionmodulesmonitoringprometheusretentiontime) | `string` | Optional |
| [retentionSize](#specdistributionmodulesmonitoringprometheusretentionsize) | `string` | Optional |
| [storageSize](#specdistributionmodulesmonitoringprometheusstoragesize)     | `string` | Optional |

## .spec.distribution.modules.monitoring.prometheus.resources

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [requests](#specdistributionmodulesmonitoringprometheusresourcesrequests) | `object` | Optional |
| [limits](#specdistributionmodulesmonitoringprometheusresourceslimits)     | `object` | Optional |

## .spec.distribution.modules.monitoring.prometheus.resources.requests

### Properties

| Property                                                                      | Type     | Required |
|:------------------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmodulesmonitoringprometheusresourcesrequestscpu)       | `string` | Optional |
| [memory](#specdistributionmodulesmonitoringprometheusresourcesrequestsmemory) | `string` | Optional |

## .spec.distribution.modules.monitoring.prometheus.resources.requests.cpu

### Description

The cpu request for the prometheus pods

## .spec.distribution.modules.monitoring.prometheus.resources.requests.memory

### Description

The memory request for the prometheus pods

## .spec.distribution.modules.monitoring.prometheus.resources.limits

### Properties

| Property                                                                    | Type     | Required |
|:----------------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmodulesmonitoringprometheusresourceslimitscpu)       | `string` | Optional |
| [memory](#specdistributionmodulesmonitoringprometheusresourceslimitsmemory) | `string` | Optional |

## .spec.distribution.modules.monitoring.prometheus.resources.limits.cpu

### Description

The cpu limit for the prometheus pods

## .spec.distribution.modules.monitoring.prometheus.resources.limits.memory

### Description

The memory limit for the prometheus pods

## .spec.distribution.modules.monitoring.prometheus.retentionTime

### Description

The retention time for the prometheus pods

## .spec.distribution.modules.monitoring.prometheus.retentionSize

### Description

The retention size for the prometheus pods

## .spec.distribution.modules.monitoring.prometheus.storageSize

### Description

The storage size for the prometheus pods

## .spec.distribution.modules.monitoring.alertmanager

### Properties

| Property                                                                                         | Type      | Required |
|:-------------------------------------------------------------------------------------------------|:----------|:---------|
| [deadManSwitchWebhookUrl](#specdistributionmodulesmonitoringalertmanagerdeadmanswitchwebhookurl) | `string`  | Optional |
| [installDefaultRules](#specdistributionmodulesmonitoringalertmanagerinstalldefaultrules)         | `boolean` | Optional |
| [slackWebhookUrl](#specdistributionmodulesmonitoringalertmanagerslackwebhookurl)                 | `string`  | Optional |

## .spec.distribution.modules.monitoring.alertmanager.deadManSwitchWebhookUrl

### Description

The webhook url to send deadman switch monitoring, for example to use with healthchecks.io

## .spec.distribution.modules.monitoring.alertmanager.installDefaultRules

### Description

If true, the default rules will be installed

## .spec.distribution.modules.monitoring.alertmanager.slackWebhookUrl

### Description

The slack webhook url to send alerts

## .spec.distribution.modules.monitoring.grafana

### Properties

| Property                                                        | Type     | Required |
|:----------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesmonitoringgrafanaoverrides) | `object` | Optional |

## .spec.distribution.modules.monitoring.grafana.overrides

### Properties

| Property                                                                       | Type     | Required |
|:-------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesmonitoringgrafanaoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesmonitoringgrafanaoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.monitoring.grafana.overrides.nodeSelector

### Description

The node selector to use to place the pods for the grafana module

## .spec.distribution.modules.monitoring.grafana.overrides.tolerations

### Properties

| Property                                                                          | Type     | Required |
|:----------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringgrafanaoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesmonitoringgrafanaoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesmonitoringgrafanaoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesmonitoringgrafanaoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the grafana module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.monitoring.grafana.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.monitoring.grafana.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.monitoring.grafana.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.grafana.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.blackboxExporter

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesmonitoringblackboxexporteroverrides) | `object` | Optional |

## .spec.distribution.modules.monitoring.blackboxExporter.overrides

### Properties

| Property                                                                                | Type     | Required |
|:----------------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesmonitoringblackboxexporteroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesmonitoringblackboxexporteroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.monitoring.blackboxExporter.overrides.nodeSelector

### Description

The node selector to use to place the pods for the blackboxExporter module

## .spec.distribution.modules.monitoring.blackboxExporter.overrides.tolerations

### Properties

| Property                                                                                   | Type     | Required |
|:-------------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringblackboxexporteroverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesmonitoringblackboxexporteroverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesmonitoringblackboxexporteroverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesmonitoringblackboxexporteroverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the blackboxExporter module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.monitoring.blackboxExporter.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.monitoring.blackboxExporter.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.monitoring.blackboxExporter.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.blackboxExporter.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.kubeStateMetrics

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesmonitoringkubestatemetricsoverrides) | `object` | Optional |

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides

### Properties

| Property                                                                                | Type     | Required |
|:----------------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesmonitoringkubestatemetricsoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesmonitoringkubestatemetricsoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides.nodeSelector

### Description

The node selector to use to place the pods for the kubeStateMetrics module

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides.tolerations

### Properties

| Property                                                                                   | Type     | Required |
|:-------------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringkubestatemetricsoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesmonitoringkubestatemetricsoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesmonitoringkubestatemetricsoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesmonitoringkubestatemetricsoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the kubeStateMetrics module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.x509Exporter

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesmonitoringx509exporteroverrides) | `object` | Optional |

## .spec.distribution.modules.monitoring.x509Exporter.overrides

### Properties

| Property                                                                            | Type     | Required |
|:------------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesmonitoringx509exporteroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesmonitoringx509exporteroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.monitoring.x509Exporter.overrides.nodeSelector

### Description

The node selector to use to place the pods for the x509Exporter module

## .spec.distribution.modules.monitoring.x509Exporter.overrides.tolerations

### Properties

| Property                                                                               | Type     | Required |
|:---------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringx509exporteroverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesmonitoringx509exporteroverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesmonitoringx509exporteroverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesmonitoringx509exporteroverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the x509Exporter module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.monitoring.x509Exporter.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.monitoring.x509Exporter.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.monitoring.x509Exporter.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.x509Exporter.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.mimir

### Properties

| Property                                                                    | Type     | Required |
|:----------------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesmonitoringmimiroverrides)               | `object` | Optional |
| [retentionTime](#specdistributionmodulesmonitoringmimirretentiontime)       | `string` | Optional |
| [backend](#specdistributionmodulesmonitoringmimirbackend)                   | `string` | Optional |
| [externalEndpoint](#specdistributionmodulesmonitoringmimirexternalendpoint) | `object` | Optional |

## .spec.distribution.modules.monitoring.mimir.overrides

### Properties

| Property                                                                               | Type     | Required |
|:---------------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesmonitoringmimiroverridesnodeselector)           | `object` | Optional |
| [tolerations](#specdistributionmodulesmonitoringmimiroverridestolerations)             | `array`  | Optional |

## .spec.distribution.modules.monitoring.mimir.overrides.nodeSelector

### Description

The node selector to use to place the pods for the mimir module

## .spec.distribution.modules.monitoring.mimir.overrides.tolerations

### Properties

| Property                                                                              | Type     | Required |
|:--------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringmimiroverridestolerationseffect)           | `string` | Required |
| [operator](#specdistributionmodulesmonitoringmimiroverridestolerationsoperator)       | `string` | Optional |
| [key](#specdistributionmodulesmonitoringmimiroverridestolerationskey)                 | `string` | Required |
| [value](#specdistributionmodulesmonitoringmimiroverridestolerationsvalue)             | `string` | Required |

### Description

The tolerations that will be added to the pods for the mimir module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.monitoring.mimir.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.monitoring.mimir.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.monitoring.mimir.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.mimir.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.mimir.retentionTime

### Description

The retention time for the mimir pods

## .spec.distribution.modules.monitoring.mimir.backend

### Description

The backend for the mimir pods, must be ***minio*** or ***externalEndpoint***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"minio"`            |
| `"externalEndpoint"` |

## .spec.distribution.modules.monitoring.mimir.externalEndpoint

### Properties

| Property                                                                                  | Type      | Required |
|:------------------------------------------------------------------------------------------|:----------|:---------|
| [endpoint](#specdistributionmodulesmonitoringmimirexternalendpointendpoint)               | `string`  | Required |
| [insecure](#specdistributionmodulesmonitoringmimirexternalendpointinsecure)               | `boolean` | Optional |
| [secretAccessKey](#specdistributionmodulesmonitoringmimirexternalendpointsecretaccesskey) | `string`  | Required |
| [accessKeyId](#specdistributionmodulesmonitoringmimirexternalendpointaccesskeyid)         | `string`  | Required |
| [bucketName](#specdistributionmodulesmonitoringmimirexternalendpointbucketname)           | `string`  | Required |

## .spec.distribution.modules.monitoring.mimir.externalEndpoint.endpoint

### Description

The endpoint of the external mimir backend

## .spec.distribution.modules.monitoring.mimir.externalEndpoint.insecure

### Description

If true, the external mimir backend will not use tls

## .spec.distribution.modules.monitoring.mimir.externalEndpoint.secretAccessKey

### Description

The secret access key of the external mimir backend

## .spec.distribution.modules.monitoring.mimir.externalEndpoint.accessKeyId

### Description

The access key id of the external mimir backend

## .spec.distribution.modules.monitoring.mimir.externalEndpoint.bucketName

### Description

The bucket name of the external mimir backend

## .spec.distribution.modules.monitoring.minio

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesmonitoringminiooverrides)            | `object` | Optional |
| [storageSize](#specdistributionmodulesmonitoringminiostoragesize)        | `string` | Optional |
| [rootUser](#specdistributionmodulesmonitoringminiorootuser)              | `object` | Optional |

## .spec.distribution.modules.monitoring.minio.overrides

### Properties

| Property                                                                               | Type     | Required |
|:---------------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesmonitoringminiooverridesnodeselector)           | `object` | Optional |
| [tolerations](#specdistributionmodulesmonitoringminiooverridestolerations)             | `array`  | Optional |

## .spec.distribution.modules.monitoring.minio.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.monitoring.minio.overrides.tolerations

### Properties

| Property                                                                              | Type     | Required |
|:--------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringminiooverridestolerationseffect)           | `string` | Required |
| [operator](#specdistributionmodulesmonitoringminiooverridestolerationsoperator)       | `string` | Optional |
| [key](#specdistributionmodulesmonitoringminiooverridestolerationskey)                 | `string` | Required |
| [value](#specdistributionmodulesmonitoringminiooverridestolerationsvalue)             | `string` | Required |

### Description

The tolerations that will be added to the pods for the minio module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.monitoring.minio.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.monitoring.minio.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.monitoring.minio.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.minio.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.minio.storageSize

### Description

The storage size for the minio pods

## .spec.distribution.modules.monitoring.minio.rootUser

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [username](#specdistributionmodulesmonitoringminiorootuserusername)      | `string` | Required |
| [password](#specdistributionmodulesmonitoringminiorootuserpassword)      | `string` | Required |

## .spec.distribution.modules.monitoring.minio.rootUser.username

### Description

The username for the minio root user

## .spec.distribution.modules.monitoring.minio.rootUser.password

### Description

The password for the minio root user

## .spec.distribution.modules.networking

### Properties

| Property                                                           | Type     | Required |
|:-------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesnetworkingoverrides)           | `object` | Optional |
| [tigeraOperator](#specdistributionmodulesnetworkingtigeraoperator) | `object` | Optional |

## .spec.distribution.modules.networking.overrides

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesnetworkingoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesnetworkingoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.networking.overrides.nodeSelector

### Description

The node selector to use to place the pods for the networking module

## .spec.distribution.modules.networking.overrides.tolerations

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesnetworkingoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesnetworkingoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesnetworkingoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesnetworkingoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the networking module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.networking.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.networking.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.networking.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.networking.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.networking.tigeraOperator

### Properties

| Property                                                               | Type     | Required |
|:-----------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesnetworkingtigeraoperatoroverrides) | `object` | Optional |

## .spec.distribution.modules.networking.tigeraOperator.overrides

### Properties

| Property                                                                              | Type     | Required |
|:--------------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesnetworkingtigeraoperatoroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesnetworkingtigeraoperatoroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.networking.tigeraOperator.overrides.nodeSelector

### Description

The node selector to use to place the pods for the tigeraOperator module

## .spec.distribution.modules.networking.tigeraOperator.overrides.tolerations

### Properties

| Property                                                                                 | Type     | Required |
|:-----------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesnetworkingtigeraoperatoroverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesnetworkingtigeraoperatoroverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesnetworkingtigeraoperatoroverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesnetworkingtigeraoperatoroverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the tigeraOperator module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.networking.tigeraOperator.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.networking.tigeraOperator.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.networking.tigeraOperator.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.networking.tigeraOperator.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.policy

### Properties

| Property                                               | Type     | Required   |
|:-------------------------------------------------------|:---------|:-----------|
| [overrides](#specdistributionmodulespolicyoverrides)   | `object` | Optional   |
| [type](#specdistributionmodulespolicytype)             | `string` | Required   |
| [gatekeeper](#specdistributionmodulespolicygatekeeper) | `object` | Optional*  |
| [kyverno](#specdistributionmodulespolicykyverno)       | `object` | Optional** |

*required if type is ***gatekeeper***

**required if type is ***kyverno***

## .spec.distribution.modules.policy.overrides

### Properties

| Property                                                            | Type     | Required |
|:--------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulespolicyoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulespolicyoverridestolerations)   | `array`  | Optional |
| [ingresses](#specdistributionmodulespolicyoverridesingresses)       | `object` | Optional |

## .spec.distribution.modules.policy.overrides.nodeSelector

### Description

The node selector to use to place the pods for the security module

## .spec.distribution.modules.policy.overrides.tolerations

### Properties

| Property                                                               | Type     | Required |
|:-----------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulespolicyoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulespolicyoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulespolicyoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulespolicyoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the policy module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.policy.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.policy.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.policy.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.policy.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.policy.overrides.ingresses

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [host](#specdistributionmodulespolicyoverridesingresseshost)                 | `string` | Required |
| [ingressClass](#specdistributionmodulespolicyoverridesingressesingressclass) | `string` | Required |

## .spec.distribution.modules.policy.overrides.ingresses.host

### Description

The host of the ingress

## .spec.distribution.modules.policy.overrides.ingresses.ingressClass

### Description

The ingress class of the ingress

## .spec.distribution.modules.policy.type

### Description

The type of security to use, either ***none***, ***gatekeeper*** or ***kyverno***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value          |
|:---------------|
| `"none"`       |
| `"gatekeeper"` |
| `"kyverno"`    |

## .spec.distribution.modules.policy.gatekeeper

### Properties

| Property                                                                                             | Type      | Required |
|:-----------------------------------------------------------------------------------------------------|:----------|:---------|
| [additionalExcludedNamespaces](#specdistributionmodulespolicygatekeeperadditionalexcludednamespaces) | `array`   | Optional |
| [enforcementAction](#specdistributionmodulespolicygatekeeperenforcementaction)                       | `string`  | Required |
| [installDefaultPolicies](#specdistributionmodulespolicygatekeeperinstalldefaultpolicies)             | `boolean` | Required |
| [overrides](#specdistributionmodulespolicygatekeeperoverrides)                                       | `object`  | Optional |

## .spec.distribution.modules.policy.gatekeeper.additionalExcludedNamespaces

### Description

This parameter adds namespaces to Gatekeeper's exemption list, so it will not enforce the constraints on them.

## .spec.distribution.modules.policy.gatekeeper.enforcementAction

### Description

The enforcement action to use for the gatekeeper module

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value          |
|:---------------|
| `"deny"`       |
| `"dryrun"`     |
| `"warn"`       |

## .spec.distribution.modules.policy.gatekeeper.installDefaultPolicies

### Description

If true, the default policies will be installed

## .spec.distribution.modules.policy.gatekeeper.overrides

### Properties

| Property                                                                      | Type     | Required |
|:------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulespolicygatekeeperoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulespolicygatekeeperoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.policy.gatekeeper.overrides.nodeSelector

### Description

The node selector to use to place the pods for the gatekeeper module

## .spec.distribution.modules.policy.gatekeeper.overrides.tolerations

### Properties

| Property                                                                         | Type     | Required |
|:---------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulespolicygatekeeperoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulespolicygatekeeperoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulespolicygatekeeperoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulespolicygatekeeperoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the gatekeeper module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.policy.gatekeeper.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.policy.gatekeeper.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.policy.gatekeeper.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.policy.gatekeeper.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.policy.kyverno

### Properties

| Property                                                                                             | Type      | Required |
|:-----------------------------------------------------------------------------------------------------|:----------|:---------|
| [additionalExcludedNamespaces](#specdistributionmodulespolicykyvernoadditionalexcludednamespaces)    | `array`   | Optional |
| [validationFailureAction](#specdistributionmodulespolicykyvernovalidationfailureaction)              | `string`  | Required |
| [installDefaultPolicies](#specdistributionmodulespolicykyvernoinstalldefaultpolicies)                | `boolean` | Required |
| [overrides](#specdistributionmodulespolicykyvernooverrides)                                          | `object`  | Optional |

## .spec.distribution.modules.policy.kyverno.additionalExcludedNamespaces

### Description

This parameter adds namespaces to Kyverno's exemption list, so it will not enforce the constraints on them.

## .spec.distribution.modules.policy.kyverno.validationFailureAction

### Description

The validation failure action to use for the kyverno module

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value          |
|:---------------|
| `"audit"`      |
| `"enforce"`    |

## .spec.distribution.modules.policy.kyverno.installDefaultPolicies

### Description

If true, the default policies will be installed

## .spec.distribution.modules.policy.kyverno.overrides

### Properties

| Property                                                                      | Type     | Required |
|:------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulespolicykyvernooverridesnodeselector)    | `object` | Optional |
| [tolerations](#specdistributionmodulespolicykyvernooverridestolerations)      | `array`  | Optional |

## .spec.distribution.modules.policy.kyverno.overrides.nodeSelector

### Description

The node selector to use to place the pods for the kyverno module

## .spec.distribution.modules.policy.kyverno.overrides.tolerations

### Properties

| Property                                                                         | Type     | Required |
|:---------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulespolicykyvernooverridestolerationseffect)        | `string` | Required |
| [operator](#specdistributionmodulespolicykyvernooverridestolerationsoperator)    | `string` | Optional |
| [key](#specdistributionmodulespolicykyvernooverridestolerationskey)              | `string` | Required |
| [value](#specdistributionmodulespolicykyvernooverridestolerationsvalue)          | `string` | Required |

### Description

The tolerations that will be added to the pods for the kyverno module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.policy.kyverno.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.policy.kyverno.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.policy.kyverno.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.policy.kyverno.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.tracing

### Properties

| Property                                                           | Type     | Required |
|:-------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulestracingoverrides)              | `object` | Optional |
| [type](#specdistributionmodulestracingtype)                        | `string` | Required |
| [tempo](#specdistributionmodulestracingtempo)                      | `object` | Optional |
| [minio](#specdistributionmodulestracingminio)                      | `object` | Optional |

## .spec.distribution.modules.tracing.overrides

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulestracingoverridesnodeselector)    | `object` | Optional |
| [tolerations](#specdistributionmodulestracingoverridestolerations)      | `array`  | Optional |
| [ingresses](#specdistributionmodulestracingoverridesingresses)          | `object` | Optional |

## .spec.distribution.modules.tracing.overrides.nodeSelector

### Description

The node selector to use to place the pods for the tracing module

## .spec.distribution.modules.tracing.overrides.tolerations

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulestracingoverridestolerationseffect)        | `string` | Required |
| [operator](#specdistributionmodulestracingoverridestolerationsoperator)    | `string` | Optional |
| [key](#specdistributionmodulestracingoverridestolerationskey)              | `string` | Required |
| [value](#specdistributionmodulestracingoverridestolerationsvalue)          | `string` | Required |

### Description

The tolerations that will be added to the pods for the tracing module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.tracing.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.tracing.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.tracing.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.tracing.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.tracing.overrides.ingresses

### Properties

| Property                                                                      | Type     | Required |
|:------------------------------------------------------------------------------|:---------|:---------|
| [host](#specdistributionmodulestracingoverridesingresseshost)                 | `string` | Required |
| [ingressClass](#specdistributionmodulestracingoverridesingressesingressclass) | `string` | Required |

## .spec.distribution.modules.tracing.overrides.ingresses.host

### Description

The host of the ingress

## .spec.distribution.modules.tracing.overrides.ingresses.ingressClass

### Description

The ingress class of the ingress

## .spec.distribution.modules.tracing.type

### Description

The type of tracing to use, either ***none*** or ***tempo***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value          |
|:---------------|
| `"none"`       |
| `"tempo"`      |

## .spec.distribution.modules.tracing.tempo

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulestracingtempooverrides)               | `object` | Optional |
| [retentionTime](#specdistributionmodulestracingtemporetentiontime)       | `string` | Optional |
| [backend](#specdistributionmodulestracingtempobackend)                   | `string` | Optional |
| [externalEndpoint](#specdistributionmodulestracingtempoexternalendpoint) | `object` | Optional |

## .spec.distribution.modules.tracing.tempo.overrides

### Properties

| Property                                                                      | Type     | Required |
|:------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulestracingtempooverridesnodeselector)     | `object` | Optional |
| [tolerations](#specdistributionmodulestracingtempooverridestolerations)       | `array`  | Optional |

## .spec.distribution.modules.tracing.tempo.overrides.nodeSelector

### Description

The node selector to use to place the pods for the tempo module

## .spec.distribution.modules.tracing.tempo.overrides.tolerations

### Properties

| Property                                                                         | Type     | Required |
|:---------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulestracingtempooverridestolerationseffect)         | `string` | Required |
| [operator](#specdistributionmodulestracingtempooverridestolerationsoperator)     | `string` | Optional |
| [key](#specdistributionmodulestracingtempooverridestolerationskey)               | `string` | Required |
| [value](#specdistributionmodulestracingtempooverridestolerationsvalue)           | `string` | Required |

### Description

The tolerations that will be added to the pods for the tempo module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.tracing.tempo.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.tracing.tempo.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |


## .spec.distribution.modules.tracing.tempo.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.tracing.tempo.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.tracing.tempo.retentionTime

### Description

The retention time for the tempo pods

## .spec.distribution.modules.tracing.tempo.backend

### Description

The backend for the tempo pods, must be ***minio*** or ***externalEndpoint***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"minio"`            |
| `"externalEndpoint"` |

## .spec.distribution.modules.tracing.tempo.externalEndpoint

### Properties

| Property                                                                                  | Type      | Required |
|:------------------------------------------------------------------------------------------|:----------|:---------|
| [endpoint](#specdistributionmodulestracingtempoexternalendpointendpoint)                  | `string`  | Required |
| [insecure](#specdistributionmodulestracingtempoexternalendpointinsecure)                  | `boolean` | Optional |
| [secretAccessKey](#specdistributionmodulestracingtempoexternalendpointsecretaccesskey)    | `string`  | Required |
| [accessKeyId](#specdistributionmodulestracingtempoexternalendpointaccesskeyid)            | `string`  | Required |
| [bucketName](#specdistributionmodulestracingtempoexternalendpointbucketname)              | `string`  | Required |

## .spec.distribution.modules.tracing.tempo.externalEndpoint.endpoint

### Description

The endpoint of the external tempo backend

## .spec.distribution.modules.tracing.tempo.externalEndpoint.insecure

### Description

If true, the external tempo backend will not use tls

## .spec.distribution.modules.tracing.tempo.externalEndpoint.secretAccessKey

### Description

The secret access key of the external tempo backend

## .spec.distribution.modules.tracing.tempo.externalEndpoint.accessKeyId

### Description

The access key id of the external tempo backend

## .spec.distribution.modules.tracing.tempo.externalEndpoint.bucketName

### Description

The bucket name of the external tempo backend

## .spec.distribution.modules.tracing.minio

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulestracingminiooverrides)               | `object` | Optional |
| [storageSize](#specdistributionmodulestracingminiostoragesize)           | `string` | Optional |
| [rootUser](#specdistributionmodulestracingminiorootuser)                 | `object` | Optional |

## .spec.distribution.modules.tracing.minio.overrides

### Properties

| Property                                                                      | Type     | Required |
|:------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulestracingminiooverridesnodeselector)     | `object` | Optional |
| [tolerations](#specdistributionmodulestracingminiooverridestolerations)       | `array`  | Optional |

## .spec.distribution.modules.tracing.minio.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.tracing.minio.overrides.tolerations

### Properties

| Property                                                                         | Type     | Required |
|:---------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulestracingminiooverridestolerationseffect)         | `string` | Required |
| [operator](#specdistributionmodulestracingminiooverridestolerationsoperator)     | `string` | Optional |
| [key](#specdistributionmodulestracingminiooverridestolerationskey)               | `string` | Required |
| [value](#specdistributionmodulestracingminiooverridestolerationsvalue)           | `string` | Required |

### Description

The tolerations that will be added to the pods for the minio module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.tracing.minio.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.tracing.minio.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |


## .spec.distribution.modules.tracing.minio.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.tracing.minio.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.tracing.minio.storageSize

### Description

The storage size for the minio pods

## .spec.distribution.modules.tracing.minio.rootUser

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [username](#specdistributionmodulestracingminiorootuserusername)          | `string` | Required |
| [password](#specdistributionmodulestracingminiorootuserpassword)          | `string` | Required |

## .spec.distribution.modules.tracing.minio.rootUser.username

### Description

The username for the minio root user

## .spec.distribution.modules.tracing.minio.rootUser.password

### Description

The password for the minio root user

## .spec.distribution.customPatches

### Properties

| Property                                                                     | Type    | Required |
|:-----------------------------------------------------------------------------|:--------|:---------|
| [configMapGenerator](#specdistributioncustompatchesconfigmapgenerator)       | `array` | Optional |
| [secretGenerator](#specdistributioncustompatchessecretgenerator)             | `array` | Optional |
| [patches](#specdistributioncustompatchespatches)                             | `array` | Optional |
| [patchesStrategicMerge](#specdistributioncustompatchespatchesstrategicmerge) | `array` | Optional |

## .spec.distribution.customPatches.configMapGenerator

### Properties

| Property                                                               | Type     | Required |
|:-----------------------------------------------------------------------|:---------|:---------|
| [name](#specdistributioncustompatchesconfigmapgeneratorname)           | `string` | Required |
| [behavior](#specdistributioncustompatchesconfigmapgeneratorbehavior)   | `string` | Optional |
| [files](#specdistributioncustompatchesconfigmapgeneratorfiles)         | `array`  | Optional |
| [envs](#specdistributioncustompatchesconfigmapgeneratorenvs)           | `array`  | Optional |
| [literals](#specdistributioncustompatchesconfigmapgeneratorliterals)   | `array`  | Optional |
| [namespace](#specdistributioncustompatchesconfigmapgeneratornamespace) | `string` | Optional |
| [options](#specdistributioncustompatchesconfigmapgeneratoroptions)     | `object` | Optional |

## .spec.distribution.customPatches.configMapGenerator.name

### Description

The name of the configmap

## .spec.distribution.customPatches.configMapGenerator.behavior

### Description

The behavior of the configmap

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
|:------------|
| `"merge"`   |
| `"replace"` |
| `"create"`  |

## .spec.distribution.customPatches.configMapGenerator.files

### Description

The files of the configmap

## .spec.distribution.customPatches.configMapGenerator.envs

### Description

The envs of the configmap

## .spec.distribution.customPatches.configMapGenerator.literals

### Description

The literals of the configmap

## .spec.distribution.customPatches.configMapGenerator.namespace

### Description

The namespace of the configmap

## .spec.distribution.customPatches.configMapGenerator.options

### Properties

| Property                                                                                              | Type      | Required |
|:------------------------------------------------------------------------------------------------------|:----------|:---------|
| [disableNameSuffixHash](#specdistributioncustompatchesconfigmapgeneratoroptionsdisablenamesuffixhash) | `boolean` | Optional |
| [immutable](#specdistributioncustompatchesconfigmapgeneratoroptionsimmutable)                         | `boolean` | Optional |
| [labels](#specdistributioncustompatchesconfigmapgeneratoroptionslabels)                               | `object`  | Optional |
| [annotations](#specdistributioncustompatchesconfigmapgeneratoroptionsannotations)                     | `object`  | Optional |

## .spec.distribution.customPatches.configMapGenerator.options.disableNameSuffixHash

### Description

If true, the name suffix hash will be disabled

## .spec.distribution.customPatches.configMapGenerator.options.immutable

### Description

If true, the configmap will be immutable

## .spec.distribution.customPatches.configMapGenerator.options.labels

### Description

The labels of the configmap

## .spec.distribution.customPatches.configMapGenerator.options.annotations

### Description

The annotations of the configmap

## .spec.distribution.customPatches.secretGenerator

### Properties

### Properties

Elements can be either `string` or:

| Property                                                            | Type     | Required |
|:--------------------------------------------------------------------|:---------|:---------|
| [name](#specdistributioncustompatchessecretgeneratorname)           | `string` | Required |
| [behavior](#specdistributioncustompatchessecretgeneratorbehavior)   | `string` | Optional |
| [files](#specdistributioncustompatchessecretgeneratorfiles)         | `array`  | Optional |
| [envs](#specdistributioncustompatchessecretgeneratorenvs)           | `array`  | Optional |
| [literals](#specdistributioncustompatchessecretgeneratorliterals)   | `array`  | Optional |
| [namespace](#specdistributioncustompatchessecretgeneratornamespace) | `string` | Optional |
| [options](#specdistributioncustompatchessecretgeneratoroptions)     | `object` | Optional |

## .spec.distribution.customPatches.secretGenerator.name

### Description

The name of the secret

## .spec.distribution.customPatches.secretGenerator.behavior

### Description

The behavior of the secret

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
|:------------|
| `"merge"`   |
| `"replace"` |
| `"create"`  |

## .spec.distribution.customPatches.secretGenerator.files

### Description

The files of the secret

## .spec.distribution.customPatches.secretGenerator.envs

### Description

The envs of the secret

## .spec.distribution.customPatches.secretGenerator.literals

### Description

The literals of the secret

## .spec.distribution.customPatches.secretGenerator.namespace

### Description

The namespace of the secret

## .spec.distribution.customPatches.secretGenerator.options

### Properties

| Property                                                                                           | Type      | Required |
|:---------------------------------------------------------------------------------------------------|:----------|:---------|
| [disableNameSuffixHash](#specdistributioncustompatchessecretgeneratoroptionsdisablenamesuffixhash) | `boolean` | Optional |
| [immutable](#specdistributioncustompatchessecretgeneratoroptionsimmutable)                         | `boolean` | Optional |
| [labels](#specdistributioncustompatchessecretgeneratoroptionslabels)                               | `object`  | Optional |
| [annotations](#specdistributioncustompatchessecretgeneratoroptionsannotations)                     | `object`  | Optional |

## .spec.distribution.customPatches.secretGenerator.options.disableNameSuffixHash

### Description

If true, the name suffix hash will be disabled

## .spec.distribution.customPatches.secretGenerator.options.immutable

### Description

If true, the secret will be immutable

## .spec.distribution.customPatches.secretGenerator.options.labels

### Description

The labels of the secret

## .spec.distribution.customPatches.secretGenerator.options.annotations

### Description

The annotations of the secret

## .spec.distribution.customPatches.patches

### Properties

| Property                                                | Type     | Required  |
|:--------------------------------------------------------|:---------|:----------|
| [target](#specdistributioncustompatchespatchestarget)   | `object` | Optional  |
| [options](#specdistributioncustompatchespatchesoptions) | `object` | Optional  |
| [path](#specdistributioncustompatchespatchespath)       | `string` | Optional* |
| [patch](#specdistributioncustompatchespatchespatch)     | `string` | Optional* |

****patch*** and ***path*** cannot be set at the same time*

## .spec.distribution.customPatches.patches.target

### Properties

| Property                                                                            | Type     | Required |
|:------------------------------------------------------------------------------------|:---------|:---------|
| [group](#specdistributioncustompatchespatchestargetgroup)                           | `string` | Optional |
| [version](#specdistributioncustompatchespatchestargetversion)                       | `string` | Optional |
| [kind](#specdistributioncustompatchespatchestargetkind)                             | `string` | Optional |
| [name](#specdistributioncustompatchespatchestargetname)                             | `string` | Optional |
| [namespace](#specdistributioncustompatchespatchestargetnamespace)                   | `string` | Optional |
| [labelSelector](#specdistributioncustompatchespatchestargetlabelselector)           | `string` | Optional |
| [annotationSelector](#specdistributioncustompatchespatchestargetannotationselector) | `string` | Optional |

## .spec.distribution.customPatches.patches.target.group

### Description

The group of the target

## .spec.distribution.customPatches.patches.target.version

### Description

The version of the target

## .spec.distribution.customPatches.patches.target.kind

### Description

The kind of the target

## .spec.distribution.customPatches.patches.target.name

### Description

The name of the target

## .spec.distribution.customPatches.patches.target.namespace

### Description

The namespace of the target

## .spec.distribution.customPatches.patches.target.labelSelector

### Description

The label selector of the target

## .spec.distribution.customPatches.patches.target.annotationSelector

### Description

The annotation selector of the target

## .spec.distribution.customPatches.patches.options

### Properties

| Property                                                                       | Type      | Required |
|:-------------------------------------------------------------------------------|:----------|:---------|
| [allowNameChange](#specdistributioncustompatchespatchesoptionsallownamechange) | `boolean` | Optional |
| [allowKindChange](#specdistributioncustompatchespatchesoptionsallowkindchange) | `boolean` | Optional |

## .spec.distribution.customPatches.patches.options.allowNameChange

### Description

If true, the name change will be allowed

## .spec.distribution.customPatches.patches.options.allowKindChange

### Description

If true, the kind change will be allowed

## .spec.distribution.customPatches.patches.path

### Description

The path of the patch

## .spec.distribution.customPatches.patches.patch

### Description

The patch

## .spec.distribution.customPatches.patchesStrategicMerge

### Description

Each entry should be either a relative file path or an inline content resolving to a partial or complete resource definition
