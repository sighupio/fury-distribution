# EKS Cluster Schema

*A Fury Cluster deployed through AWS's Elastic Kubernetes Service*

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
| :------------- |
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
| [infrastructure](#specinfrastructure)           | `object`  | Optional* |
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
| :----------------- |
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
|:----------------------------------------------| :------- | :------- |
| [terraform](#spectoolsconfigurationterraform) | `object` | Required |

## .spec.toolsConfiguration.terraform

### Properties

| Property        | Type     | Required |
| :-------------- | :------- | :------- |
| [state](#spectoolsconfigurationterraformstate) | `object` | Required |

## .spec.toolsConfiguration.terraform.state

### Properties

| Property  | Type     | Required |
| :-------- | :------- | :------- |
| [s3](#spectoolsconfigurationterraformstates3) | `object` | Required |

## .spec.toolsConfiguration.terraform.state.s3

### Properties

| Property                                      | Type      | Required |
| :-------------------------------------------- | :-------- | :------- |
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
| :----------------- |
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
|:------------------------------| :------- |:----------|
| [vpc](#specinfrastructurevpc) | `object` | Optional* |
| [vpn](#specinfrastructurevpn)                   | `object` | Optional  |

*vpc: if omitted, you need to provide ***vpcId*** and ***subnetIds*** in .spec.kubernetes*, and ***vpcId*** in .spec.infrastructure.vpn*

## .spec.infrastructure.vpc

### Description

This key defines the VPC that will be created in AWS

### Properties

| Property            | Type     | Required |
| :------------------ | :------- | :------- |
| [network](#specinfrastructurevpcnetwork) | `object` | Required |

## .spec.infrastructure.vpc.network

### Properties

| Property                      | Type     | Required |
| :---------------------------- | :------- | :------- |
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

| Property            | Type    | Required |
| :------------------ | :------ | :------- |
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

| Property                                      | Type      | Required  |
| :-------------------------------------------- | :-------- |:----------|
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

| Property                              | Type    | Required |
| :------------------------------------ | :------ | :------- |
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

| Property                                            | Type      | Required |
|:----------------------------------------------------|:----------| :------- |
| [vpcId](#speckubernetesvpcid)                       | `string`  | Optional |
| [subnetIds](#speckubernetessubnetids)                             | `array`   | Optional |
| [apiServer](#speckubernetesapiserver)                             | `object`  | Required |
| [serviceIpV4Cidr](#speckubernetesserviceipv4cidr)                 | `string`  | Optional |
| [nodeAllowedSshPublicKey](#speckubernetesnodeallowedsshpublickey) | `string`   | Required |
| [nodePoolsLaunchKind](#speckubernetesnodepoolslaunchkind)         | `string`  | Required |
| [logRetentionDays](#speckuberneteslogretentiondays)               | `integer` | Optional |
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

| Property                                  | Type      | Required |
| :---------------------------------------- | :-------- | :------- |
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

| Value                   |
| :---------------------- |
| `"launch_configurations"` |
| `"launch_templates"`     |
| `"both"`                 |

## .spec.kubernetes.logRetentionDays

### Description

Optional Kubernetes Cluster log retention in days. Defaults to 90 days.

## .spec.kubernetes.nodePools

### Properties

| Property                                            | Type     | Required |
| :-------------------------------------------------- | :------- | :------- |
| [name](#speckubernetesnodepoolsname)                                       | `string` | Required |
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

| Property                                     | Type     | Required |
|:---------------------------------------------| :------- | :------- |
| [id](#speckubernetesnodepoolsamiid)          | `string` | Required |
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
| :------------- |
| `"docker"`     |
| `"containerd"` |

## .spec.kubernetes.nodePools.size

### Properties

| Property                                     | Type     | Required |
|:---------------------------------------------| :------- | :------- |
| [max](#speckubernetesnodepoolssizemax)         | `integer` | Required |
| [min](#speckubernetesnodepoolssizemin)         | `integer` | Required |

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
| :---------- |
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

| Property                                                                              | Type     | Required |
|:--------------------------------------------------------------------------------------|:---------|:---------|
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

| Property                                                        | Type      | Required |
|:----------------------------------------------------------------|:----------|:---------|
| [name](#speckubernetesnodepoolsadditionalfirewallrulesselfname) | `string`  | Required |
| [type](#speckubernetesnodepoolsadditionalfirewallrulesselftype) | `string`  | Required |
| [tags](#speckubernetesnodepoolsadditionalfirewallrulesselftags) | `object`  | Optional |
| [self](#speckubernetesnodepoolsadditionalfirewallrulesselfself) | `boolean` | Required |
| [protocol](#speckubernetesnodepoolsadditionalfirewallrulesselfprotocol) | `string` | Required |
| [ports](#speckubernetesnodepoolsadditionalfirewallrulesselfports) | `object` | Required |

## .spec.kubernetes.nodePools.additionalFirewallRules.self.name

### Description

The name of the FW rule

## .spec.kubernetes.nodePools.additionalFirewallRules.self.type

### Description

The type of the FW rule can be ingress or egress

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
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

| Property                                                  | Type     | Required |
|:----------------------------------------------------------|:---------|:---------|
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

| Property                                  | Type    | Required |
| :---------------------------------------- | :------ | :------- |
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

| Property                          | Type     | Required |
|:----------------------------------| :------- | :------- |
| [common](#specdistributioncommon) | `object` | Optional |
| [modules](#specdistributionmodules)               | `object` | Required |
| [customPatches](#specdistributioncustompatches)   | `object` | Optional |

## .spec.distribution.common

### Properties

| Property                                  | Type     | Required |
| :---------------------------------------- | :------- | :------- |
| [nodeSelector](#specdistributioncommonnodeselector)             | `object` | Optional |
| [tolerations](#specdistributioncommontolerations)               | `array`  | Optional |
| [provider](#specdistributioncommonprovider)                     | `object` | Optional |
| [relativeVendorPath](#specdistributioncommonrelativevendorpath) | `string` | Optional |

## .spec.distribution.common.nodeSelector

### Description

The node selector to use to place the pods for all the KFD packages

## .spec.distribution.common.tolerations

### Properties

| Property              | Type     | Required |
| :-------------------- | :------- | :------- |
| [effect](#specdistributioncommontolerationseffect)     | `string` | Required |
| [operator](#specdistributioncommontolerationsoperator) | `string` | Optional |
| [key](#specdistributioncommontolerationskey)           | `string` | Required |
| [value](#specdistributioncommontolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for all the KFD packages

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.common.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"NoSchedule"` |
| `"PreferNoSchedule"`  |
| `"NoExecute"`  |

## .spec.distribution.common.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
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
|:--------------------------------------------| :------- | :------- |
| [type](#specdistributioncommonprovidertype) | `string` | Required |

## .spec.distribution.common.provider.type

### Description

The type of the provider, must be EKS if specified

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value   |
| :------ |
| `"EKS"` |

## .spec.distribution.common.relativeVendorPath

### Description

The relative path to the vendor directory, does not need to be changed

## .spec.distribution.modules

### Properties

| Property                  | Type     | Required |
| :------------------------ |:---------| :------- |
| [auth](#specdistributionmodulesauth)             | `object` | Optional |
| [dr](#specdistributiondr)                 | `object` | Required |
| [ingress](#specdistributioningress)       | `object` | Required |
| [logging](#specdistributionlogging)       | `object` | Required |
| [monitoring](#specdistributionmonitoring) | `object` | Optional |
| [networking](#specdistributionnetworking) | `object` | Optional |
| [policy](#specdistributionpolicy)         | `object` | Required |

## .spec.distribution.modules.auth

### Properties

| Property                                             | Type     | Required  |
|:-----------------------------------------------------| :------- |:----------|
| [overrides](#specdistributionmodulesauthoverrides)   | `object` | Optional  |
| [provider](#specdistributionmodulesauthprovider)     | `object` | Required  |
| [baseDomain](#specdistributionmodulesauthbasedomain) | `string` | Optional* |
| [pomerium](#specdistributionmodulesauthpomerium)     | `object` | Optional* |
| [dex](#specdistributionmodulesauthdex)               | `object` | Optional* |

*required only if .spec.distribution.modules.auth.provider.type is ***sso***, otherwise it must be null*

## .spec.distribution.modules.auth.overrides

### Properties

| Property                      | Type     | Required |
| :---------------------------- | :------- | :------- |
| [nodeSelector](#specdistributionmodulesauthoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesauthoverridestolerations)   | `array`  | Optional |
| [ingresses](#specdistributionmodulesauthoverridesingresses)       | `object` | Optional |

## .spec.distribution.modules.auth.overrides.nodeSelector

### Description

The node selector to use to place the pods for the auth package

## .spec.distribution.modules.auth.overrides.tolerations

### Properties

| Property              | Type     | Required |
| :-------------------- | :------- | :------- |
| [effect](#specdistributionmodulesauthoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesauthoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesauthoverridestolerationskey)           | `string` | Required |

### Description

The tolerations that will be added to the pods for the auth package

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.auth.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"NoSchedule"` |
| `"PreferNoSchedule"`  |
| `"NoExecute"`  |

## .spec.distribution.modules.auth.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.auth.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.auth.overrides.ingresses

### Properties

| Property      | Type     | Required |
|:--------------|:---------|:---------|
| [host](#specdistributionmodulesauthoverridesingresseshost) | `string` | Required |
| [ingressClass](#specdistributionmodulesauthoverridesingressesingressclass) | `string` | Required |
| [disableAuth](#specdistributionmodulesauthoverridesingressesdisableauth) | `boolean` | Optional |

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

| Property                | Type     | Required  |
| :---------------------- | :------- |:----------|
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

| Property              | Type     | Required |
| :-------------------- | :------- | :------- |
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

The base domain for the auth package

## .spec.distribution.modules.auth.pomerium

### Properties

| Property                                        | Type     | Required |
|:------------------------------------------------| :------- | :------- |
| [secrets](#specdistributionmodulesauthpomeriumsecrets) | `object` | Required |
| [policy](#specdistributionmodulesauthpomeriumpolicy)                               | `string` | Required |
| [overrides](#specdistributionmodulesauthpomeriumoverrides)                         | `object` | Optional |

## .spec.distribution.modules.auth.pomerium.secrets

### Properties

| Property                                  | Type     | Required |
| :---------------------------------------- | :------- | :------- |
| [COOKIE\_SECRET](#specdistributionmodulesauthpomeriumsecretscookie_secret)          | `string` | Required |
| [IDP\_CLIENT\_SECRET](#specdistributionmodulesauthpomeriumsecretsidp_client_secret) | `string` | Required |
| [SHARED\_SECRET](#specdistributionmodulesauthpomeriumsecretsshared_secret)          | `string` | Required |

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

| Property                      | Type     | Required |
| :---------------------------- | :------- | :------- |
| [nodeSelector](#specdistributionmodulesauthpomeriumoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesauthpomeriumoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.auth.pomerium.overrides.nodeSelector

### Description

The node selector to use to place the pods for the pomerium package

## .spec.distribution.modules.auth.pomerium.overrides.tolerations

### Properties

| Property              | Type     | Required |
| :-------------------- | :------- | :------- |
| [effect](#specdistributionmodulesauthpomeriumoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesauthpomeriumoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesauthpomeriumoverridestolerationskey)           | `string` | Required |

### Description

The tolerations that will be added to the pods for the pomerium package

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.auth.pomerium.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"NoSchedule"` |
| `"PreferNoSchedule"`  |
| `"NoExecute"`  |

## .spec.distribution.modules.auth.pomerium.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.auth.pomerium.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.auth.dex

### Properties

| Property                                         | Type     | Required |
|:-------------------------------------------------| :------- | :------- |
| [connectors](#specdistributionmodulesauthdexconnectors) | `array`  | Required |
| [overrides](#specdistributionmodulesauthdexoverrides)                          | `object` | Optional |

## .spec.distribution.modules.auth.dex.connectors

### Description

The connectors for dex

## .spec.distribution.modules.auth.dex.overrides

### Properties

| Property                      | Type     | Required |
| :---------------------------- | :------- | :------- |
| [nodeSelector](#specdistributionmodulesauthdexoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesauthdexoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.auth.dex.overrides.nodeSelector

### Description

The node selector to use to place the pods for the dex package

## .spec.distribution.modules.auth.dex.overrides.tolerations

### Properties

| Property              | Type     | Required |
| :-------------------- | :------- | :------- |
| [effect](#specdistributionmodulesauthdexoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesauthdexoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesauthdexoverridestolerationskey)           | `string` | Required |

### Description

The tolerations that will be added to the pods for the dex package

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.auth.dex.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"NoSchedule"` |
| `"PreferNoSchedule"`  |
| `"NoExecute"`  |

## .spec.distribution.modules.auth.dex.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.auth.dex.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.dr

### Properties

| Property                | Type     | Required  |
| :---------------------- | :------- |:----------|
| [overrides](#specdistributionmodulesoverrides) | `object` | Optional  |
| [type](#specdistributionmodulestype)           | `string` | Required  |
| [velero](#specdistributionmodulesvelero)       | `object` | Optional* |

*velero: required only if .spec.distribution.modules.dr.type is ***eks***, otherwise it must be null*

## .spec.distribution.modules.dr.overrides

### Properties

| Property                      | Type     | Required |
| :---------------------------- | :------- | :------- |
| [nodeSelector](#specdistributionmodulesdroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesdroverridestolerations)   | `array`  | Optional |
| [ingresses](#specdistributionmodulesdroverridesingresses)       | `object` | Optional |

## .spec.distribution.modules.dr.overrides.nodeSelector

### Description

The node selector to use to place the pods for the dr package

## .spec.distribution.modules.dr.overrides.tolerations

### Properties

| Property              | Type     | Required |
| :-------------------- | :------- | :------- |
| [effect](#specdistributionmodulesdroverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesdroverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesdroverridestolerationskey)           | `string` | Required |

### Description

The tolerations that will be added to the pods for the dr package

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.dr.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"NoSchedule"` |
| `"PreferNoSchedule"`  |
| `"NoExecute"`  |

## .spec.distribution.modules.dr.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.dr.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.dr.overrides.ingresses

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [host](#specdistributionmodulesdroverridesingresseshost)                 | `string` | Required |
| [ingressClass](#specdistributionmodulesdroverridesingressesingressclass) | `string` | Required |
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

| Value   |
|:--------|
| `"none"` |
| `"eks"`  |

## .spec.distribution.modules.dr.velero

### Properties

| Property                | Type     | Required |
| :---------------------- | :------- | :------- |
| [eks](#specdistributionmodulesdrveleroeks) | `object` | Required |
| [overrides](#specdistributionmodulesdrvelerooverrides) | `object` | Optional |

## .spec.distribution.modules.dr.velero.eks

### Properties

| Property                                            | Type     | Required |
|:----------------------------------------------------|:---------| :------- |
| [region](#specdistributionmodulesdrveleroeksregion) | `string` | Required |
| [bucketName](#specdistributionmodulesdrveleroeksbucketname) | `string` | Required |

## .spec.distribution.modules.dr.velero.eks.region

### Description

The region where the velero bucket is located

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
| :----------------- |
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

| Property                      | Type     | Required |
| :---------------------------- | :------- | :------- |
| [nodeSelector](#specdistributionmodulesdrvelerooverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesdrvelerooverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.dr.velero.overrides.nodeSelector

### Description

The node selector to use to place the pods for the velero package

## .spec.distribution.modules.dr.velero.overrides.tolerations

### Properties

| Property              | Type     | Required |
| :-------------------- | :------- | :------- |
| [effect](#specdistributionmodulesdrvelerooverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesdrvelerooverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesdrvelerooverridestolerationskey)           | `string` | Required |

### Description

The tolerations that will be added to the pods for the velero package

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.dr.velero.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"NoSchedule"` |
| `"PreferNoSchedule"`  |
| `"NoExecute"`  |

## .spec.distribution.modules.dr.velero.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.dr.velero.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress

### Properties

| Property                                              | Type     | Required |
|:------------------------------------------------------| :------- |:---------|
| [overrides](#specdistributionmodulesingressoverrides) | `object` | Optional |
| [baseDomain](#specdistributionmodulesingressbasedomain)                             | `string` | Required |
| [nginx](#specdistributionmodulesingressnginx)                                       | `object` | Required |
| [certManager](#specdistributionmodulesingresscertmanager)                           | `object` | Optional |
| [forecastle](#specdistributionmodulesingressforecastle)                             | `object` | Optional |
| [dns](#specdistributionmodulesingressdns)                                           | `object` | Required |

## .spec.distribution.modules.ingress.overrides

### Properties

| Property                      | Type     | Required |
| :---------------------------- | :------- | :------- |
| [nodeSelector](#specdistributionmodulesingressoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesingressoverridestolerations)   | `array`  | Optional |
| [ingresses](#specdistributionmodulesingressoverridesingresses)       | `object` | Optional |

## .spec.distribution.modules.ingress.overrides.nodeSelector

### Description

The node selector to use to place the pods for the ingress package

## .spec.distribution.modules.ingress.overrides.tolerations

### Properties

| Property              | Type     | Required |
| :-------------------- | :------- | :------- |
| [effect](#specdistributionmodulesingressoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesingressoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesingressoverridestolerationskey)           | `string` | Required |

### Description

The tolerations that will be added to the pods for the ingress package

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.ingress.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"NoSchedule"` |
| `"PreferNoSchedule"`  |
| `"NoExecute"`  |

## .spec.distribution.modules.ingress.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.ingress.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.overrides.ingresses

### Properties

| Property      | Type     | Required |
|:--------------|:---------|:---------|
| [forecastle](#specdistributionmodulesingressoverridesingressesforecastle) | `object` | Optional |

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle

### Properties

| Property                                                                                        | Type     | Required |
|:------------------------------------------------------------------------------------------------|:---------|:---------|
| [host](#specdistributionmodulesingressoverridesingressesforecastlehost)                         | `string` | Optional |
| [ingressClass](#specdistributionmodulesingressoverridesingressesforecastleingressclass)         | `string` | Optional |
| [disableAuth](#specdistributionmodulesingressoverridesingressesforecastledisableauth) | `boolean` | Optional |

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle.host

### Description

The host of the ingress

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle.ingressClass

### Description

The ingress class of the ingress

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle.disableAuth

### Description

If true, auth will be disabled for the ingress

## .spec.distribution.modules.ingress.baseDomain

### Description

the base domain used for all the KFD ingresses, if in the nginx dual configuration, it should be the same as the .spec.distribution.modules.ingress.dns.private.name zone

## .spec.distribution.modules.ingress.nginx

### Description

Configurations for the nginx ingress controller package

### Properties

| Property                                         | Type     | Required |
|:-------------------------------------------------| :------- | :------- |
| [type](#specdistributionmodulesingressnginxtype) | `string` | Required |
| [tls](#specdistributionmodulesingressnginxtls)                                      | `object` | Optional |
| [overrides](#specdistributionmodulesingressnginxoverrides)                          | `object` | Optional |

## .spec.distribution.modules.ingress.nginx.type

### Description

The type of the nginx ingress controller, must be ***none***, ***single*** or ***dual***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value     |
|:----------|
| `"none"`  |
| `"single"`|
| `"dual"`  |

## .spec.distribution.modules.ingress.nginx.tls

### Properties

| Property                                                    | Type     | Required  |
|:------------------------------------------------------------| :------- |:----------|
| [provider](#specdistributionmodulesingressnginxtlsprovider) | `string` | Required  |
| [secret](#specdistributionmodulesingressnginxtlssecret)                                           | `object` | Optional* |

*secret: required only if .spec.distribution.modules.ingress.nginx.tls.provider is ***secret****

## .spec.distribution.modules.ingress.nginx.tls.provider

### Description

The provider of the TLS certificate, must be ***none***, ***certManager*** or ***secret***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value          |
|:---------------|
| `"none"`       |
| `"certManager"`|
| `"secret"`     |

## .spec.distribution.modules.ingress.nginx.tls.secret

### Properties

| Property      | Type     | Required |
| :------------ | :------- | :------- |
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

| Property                      | Type     | Required |
| :---------------------------- | :------- | :------- |
| [nodeSelector](#specdistributionmodulesingressnginxoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesingressnginxoverridestolerations)   | `array`  | Optional |


## .spec.distribution.modules.ingress.nginx.overrides.nodeSelector

### Description

The node selector to use to place the pods for the nginx package

## .spec.distribution.modules.ingress.nginx.overrides.tolerations

### Properties

| Property              | Type     | Required |
| :-------------------- | :------- | :------- |
| [effect](#specdistributionmodulesingressnginxoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesingressnginxoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesingressnginxoverridestolerationskey)           | `string` | Required |

### Description

The tolerations that will be added to the pods for the nginx package

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.ingress.nginx.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"NoSchedule"` |
| `"PreferNoSchedule"`  |
| `"NoExecute"`  |

## .spec.distribution.modules.ingress.nginx.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
| :---------- |
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.ingress.nginx.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.certManager

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------| :------- | :------- |
| [clusterIssuer](#specdistributionmodulesingresscertmanagerclusterissuer) | Merged   | Required |
| [overrides](#specdistributionmodulesingresscertmanageroverrides)                                                  | `object` | Optional |

## .spec.distribution.modules.ingress.certManager.clusterIssuer

### Properties

| Property            | Type     | Required |
| :------------------ | :------- | :------- |
| [name](#specdistributionmodulesingresscertmanagerclusterissuername)       | `string` | Required |
| [email](#specdistributionmodulesingresscertmanagerclusterissueremail)     | `string` | Required |
| [type](#specdistributionmodulesingresscertmanagerclusterissuertype)       | `string` | Optional |
| [solvers](#specdistributionmodulesingresscertmanagerclusterissuersolvers) | `array`  | Optional |

*type and solvers cannot be set at the same time*

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

| Value     |
|:----------|
| `"dns01"` |
| `"http01"`|

## .spec.distribution.modules.ingress.certManager.clusterIssuer.solvers

### Description

The custom solvers configurations

## .spec.distribution.modules.ingress.dns

### Properties












































