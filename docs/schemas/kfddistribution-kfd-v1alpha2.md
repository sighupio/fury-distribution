# KFDDistribution - Distribution Only Cluster Schema

This document explains the full schema for the `kind: KFDDistribution` for the `furyctl.yaml` file used by `furyctl`. This configuration file will be used to deploy the Kubernetes Fury Distribution modules on top of an existing Kubernetes cluster.

An example file can be found [here](https://github.com/sighupio/fury-distribution/blob/feature/schema-docs/templates/config/kfddistribution-kfd-v1alpha2.yaml.tpl).

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

| Value               |
|:--------------------|
| `"KFDDistribution"` |

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
| [distribution](#specdistribution)               | `object` | Required  |

## .spec.distributionVersion

### Constraints

**minimum length**: the minimum number of characters for this string is: `1`

## .spec.distribution

### Properties

| Property                                        | Type     | Required |
|:------------------------------------------------|:---------|:---------|
| [common](#specdistributioncommon)               | `object` | Optional |
| [kubeconfig](#specdistributionkubeconfig)       | `string` | Required |
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

The type of the provider

## .spec.distribution.common.relativeVendorPath

### Description

The relative path to the vendor directory, does not need to be changed

## .spec.distribution.kubeconfig

### Description

The kubeconfig file path

## .spec.distribution.modules

### Properties

| Property                                         | Type     | Required |
|:-------------------------------------------------|:---------|:---------|
| [auth](#specdistributionmodulesauth)             | `object` | Optional |
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

## .spec.distribution.modules.auth.overrides.ingresses.host

### Description

The host of the ingress

## .spec.distribution.modules.auth.overrides.ingresses.ingressClass

### Description

The ingress class of the ingress

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

| Property                                                                          | Type     | Required |
|:----------------------------------------------------------------------------------|:---------|:---------|
| [connectors](#specdistributionmodulesauthdexconnectors)                           | `array`  | Required |
| [additionalStaticClients](#specdistributionmodulesauthdexadditionalstaticclients) | `array`  | Optional |
| [overrides](#specdistributionmodulesauthdexoverrides)                             | `object` | Optional |

## .spec.distribution.modules.auth.dex.connectors

### Description

The connectors for dex

## .spec.distribution.modules.auth.dex.additionalStaticClients

### Description

The additional static clients for dex

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

## .spec.distribution.modules.dr

### Properties

| Property                                         | Type     | Required  |
|:-------------------------------------------------|:---------|:----------|
| [overrides](#specdistributionmodulesdroverrides) | `object` | Optional  |
| [type](#specdistributionmodulesdrtype)           | `string` | Required  |
| [velero](#specdistributionmodulesdrvelero)       | `object` | Optional* |

*velero: required only if .spec.distribution.modules.dr.type is ***on-premises***, otherwise it must be null*

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

The type of the DR, must be ***none*** or ***on-premises***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value           |
|:----------------|
| `"none"`        |
| `"on-premises"` |

## .spec.distribution.modules.dr.velero

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesdrvelerooverrides)               | `object` | Optional |
| [retentionTime](#specdistributionmodulesdrveleroretentiontime)       | `string` | Optional |
| [backend](#specdistributionmodulesdrvelerobackend)                   | `string` | Optional |
| [externalEndpoint](#specdistributionmodulesdrveleroexternalendpoint) | `object` | Optional |

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


## .spec.distribution.modules.dr.velero.retentionTime

### Description

The retention time for velero

## .spec.distribution.modules.dr.velero.backend

### Description

The backend for velero

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                      |
|:---------------------------|
| `"minio"`                  |
| `"externalEndpoint"`       |

## .spec.distribution.modules.dr.velero.externalEndpoint

### Properties

| Property                                                                           | Type      | Required |
|:-----------------------------------------------------------------------------------|:----------|:---------|
| [endpoint](#specdistributionmodulesdrveleroexternalendpointendpoint)               | `string`  | Optional |
| [insecure](#specdistributionmodulesdrveleroexternalendpointinsecure)               | `boolean` | Optional |
| [secretAccessKey](#specdistributionmodulesdrveleroexternalendpointsecretaccesskey) | `string`  | Optional |
| [accessKeyId](#specdistributionmodulesdrveleroexternalendpointaccesskeyid)         | `string`  | Optional |
| [bucketName](#specdistributionmodulesdrveleroexternalendpointbucketname)           | `string`  | Optional |

## .spec.distribution.modules.dr.velero.externalEndpoint.endpoint

### Description

The endpoint for velero

## .spec.distribution.modules.dr.velero.externalEndpoint.insecure

### Description

If true, the endpoint will be insecure

## .spec.distribution.modules.dr.velero.externalEndpoint.secretAccessKey

### Description

The secret access key for velero backend

## .spec.distribution.modules.dr.velero.externalEndpoint.accessKeyId

### Description

The access key id for velero backend

## .spec.distribution.modules.dr.velero.externalEndpoint.bucketName

### Description

The bucket name for velero backend

## .spec.distribution.modules.ingress

### Properties

| Property                                                  | Type     | Required  |
|:----------------------------------------------------------|:---------|:----------|
| [overrides](#specdistributionmodulesingressoverrides)     | `object` | Optional  |
| [baseDomain](#specdistributionmodulesingressbasedomain)   | `string` | Required  |
| [nginx](#specdistributionmodulesingressnginx)             | `object` | Required  |
| [certManager](#specdistributionmodulesingresscertmanager) | `object` | Optional* |
| [forecastle](#specdistributionmodulesingressforecastle)   | `object` | Optional  |

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

The type of the cluster issuer, must be ***http01***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
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
| [cilium](#specdistributionmodulesnetworkingcilium)                 | `object` | Optional |
| [type](#specdistributionmodulesnetworkingtype)                     | `string` | Optional |

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

## .spec.distribution.modules.networking.cilium

### Properties

| Property                                                           | Type     | Required |
|:-------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesnetworkingciliumoverrides)     | `object` | Optional |

## .spec.distribution.modules.networking.cilium.overrides

### Properties

| Property                                                                      | Type     | Required |
|:------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesnetworkingciliumoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesnetworkingciliumoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.networking.cilium.overrides.nodeSelector

### Description

The node selector to use to place the pods for the cilium module

## .spec.distribution.modules.networking.cilium.overrides.tolerations

### Properties

| Property                                                                         | Type     | Required |
|:---------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesnetworkingciliumoverridestolerationseffect)     | `string` | Required |
| [operator](#specdistributionmodulesnetworkingciliumoverridestolerationsoperator) | `string` | Optional |
| [key](#specdistributionmodulesnetworkingciliumoverridestolerationskey)           | `string` | Required |
| [value](#specdistributionmodulesnetworkingciliumoverridestolerationsvalue)       | `string` | Required |

### Description

The tolerations that will be added to the pods for the cilium module

### Constraints

**minimum number of items**: the minimum number of items for this array is: `0`

## .spec.distribution.modules.networking.cilium.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value                |
|:---------------------|
| `"NoSchedule"`       |
| `"PreferNoSchedule"` |
| `"NoExecute"`        |

## .spec.distribution.modules.networking.cilium.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"Exists"` |
| `"Equal"`  |

## .spec.distribution.modules.networking.cilium.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.networking.cilium.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.networking.type

### Description

The type of networking to use, either ***none***, ***calico*** or ***cilium***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value      |
|:-----------|
| `"none"`   |
| `"calico"` |
| `"cilium"` |

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
