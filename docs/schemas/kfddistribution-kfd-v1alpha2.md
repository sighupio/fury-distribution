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

**pattern**: the string must match the following regular expression:

```regexp
^kfd\.sighup\.io/v\d+((alpha|beta)\d+)?$
```

[try pattern](https://regexr.com/?expression=^kfd\.sighup\.io\/v\d%2B\(\(alpha|beta\)\d%2B\)?$)

## .kind

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value             |
|:------------------|
|`"KFDDistribution"`|

## .metadata

### Properties

| Property              | Type     | Required |
|:----------------------|:---------|:---------|
| [name](#metadataname) | `string` | Required |

## .metadata.name

### Constraints

**maximum length**: the maximum number of characters for this string is: `56`

**minimum length**: the minimum number of characters for this string is: `1`

## .spec

### Properties

| Property                                        | Type     | Required |
|:------------------------------------------------|:---------|:---------|
| [distribution](#specdistribution)               | `object` | Required |
| [distributionVersion](#specdistributionversion) | `string` | Required |
| [plugins](#specplugins)                         | `object` | Optional |

## .spec.distribution

### Properties

| Property                                        | Type     | Required |
|:------------------------------------------------|:---------|:---------|
| [common](#specdistributioncommon)               | `object` | Optional |
| [customPatches](#specdistributioncustompatches) | `object` | Optional |
| [kubeconfig](#specdistributionkubeconfig)       | `string` | Required |
| [modules](#specdistributionmodules)             | `object` | Required |

## .spec.distribution.common

### Properties

| Property                                                        | Type     | Required |
|:----------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributioncommonnodeselector)             | `object` | Optional |
| [provider](#specdistributioncommonprovider)                     | `object` | Optional |
| [relativeVendorPath](#specdistributioncommonrelativevendorpath) | `string` | Optional |
| [tolerations](#specdistributioncommontolerations)               | `array`  | Optional |

## .spec.distribution.common.nodeSelector

### Description

The node selector to use to place the pods for all the KFD modules

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

## .spec.distribution.common.tolerations

### Properties

| Property                                               | Type     | Required |
|:-------------------------------------------------------|:---------|:---------|
| [effect](#specdistributioncommontolerationseffect)     | `string` | Required |
| [key](#specdistributioncommontolerationskey)           | `string` | Required |
| [operator](#specdistributioncommontolerationsoperator) | `string` | Optional |
| [value](#specdistributioncommontolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for all the KFD modules

## .spec.distribution.common.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.common.tolerations.key

### Description

The key of the toleration

## .spec.distribution.common.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.common.tolerations.value

### Description

The value of the toleration

## .spec.distribution.customPatches

### Properties

| Property                                                                     | Type    | Required |
|:-----------------------------------------------------------------------------|:--------|:---------|
| [configMapGenerator](#specdistributioncustompatchesconfigmapgenerator)       | `array` | Optional |
| [images](#specdistributioncustompatchesimages)                               | `array` | Optional |
| [patches](#specdistributioncustompatchespatches)                             | `array` | Optional |
| [patchesStrategicMerge](#specdistributioncustompatchespatchesstrategicmerge) | `array` | Optional |
| [secretGenerator](#specdistributioncustompatchessecretgenerator)             | `array` | Optional |

## .spec.distribution.customPatches.configMapGenerator

### Properties

| Property                                                               | Type     | Required |
|:-----------------------------------------------------------------------|:---------|:---------|
| [behavior](#specdistributioncustompatchesconfigmapgeneratorbehavior)   | `string` | Optional |
| [envs](#specdistributioncustompatchesconfigmapgeneratorenvs)           | `array`  | Optional |
| [files](#specdistributioncustompatchesconfigmapgeneratorfiles)         | `array`  | Optional |
| [literals](#specdistributioncustompatchesconfigmapgeneratorliterals)   | `array`  | Optional |
| [name](#specdistributioncustompatchesconfigmapgeneratorname)           | `string` | Required |
| [namespace](#specdistributioncustompatchesconfigmapgeneratornamespace) | `string` | Optional |
| [options](#specdistributioncustompatchesconfigmapgeneratoroptions)     | `object` | Optional |

## .spec.distribution.customPatches.configMapGenerator.behavior

### Description

The behavior of the configmap

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value     |
|:----------|
|`"create"` |
|`"replace"`|
|`"merge"`  |

## .spec.distribution.customPatches.configMapGenerator.envs

### Description

The envs of the configmap

## .spec.distribution.customPatches.configMapGenerator.files

### Description

The files of the configmap

## .spec.distribution.customPatches.configMapGenerator.literals

### Description

The literals of the configmap

## .spec.distribution.customPatches.configMapGenerator.name

### Description

The name of the configmap

## .spec.distribution.customPatches.configMapGenerator.namespace

### Description

The namespace of the configmap

## .spec.distribution.customPatches.configMapGenerator.options

### Properties

| Property                                                                                              | Type      | Required |
|:------------------------------------------------------------------------------------------------------|:----------|:---------|
| [annotations](#specdistributioncustompatchesconfigmapgeneratoroptionsannotations)                     | `object`  | Optional |
| [disableNameSuffixHash](#specdistributioncustompatchesconfigmapgeneratoroptionsdisablenamesuffixhash) | `boolean` | Optional |
| [immutable](#specdistributioncustompatchesconfigmapgeneratoroptionsimmutable)                         | `boolean` | Optional |
| [labels](#specdistributioncustompatchesconfigmapgeneratoroptionslabels)                               | `object`  | Optional |

## .spec.distribution.customPatches.configMapGenerator.options.annotations

### Description

The annotations of the configmap

## .spec.distribution.customPatches.configMapGenerator.options.disableNameSuffixHash

### Description

If true, the name suffix hash will be disabled

## .spec.distribution.customPatches.configMapGenerator.options.immutable

### Description

If true, the configmap will be immutable

## .spec.distribution.customPatches.configMapGenerator.options.labels

### Description

The labels of the configmap

## .spec.distribution.customPatches.images

### Description

Each entry should follow the format of Kustomize's images patch

## .spec.distribution.customPatches.patches

### Properties

| Property                                                | Type     | Required |
|:--------------------------------------------------------|:---------|:---------|
| [options](#specdistributioncustompatchespatchesoptions) | `object` | Optional |
| [patch](#specdistributioncustompatchespatchespatch)     | `string` | Optional |
| [path](#specdistributioncustompatchespatchespath)       | `string` | Optional |
| [target](#specdistributioncustompatchespatchestarget)   | `object` | Optional |

## .spec.distribution.customPatches.patches.options

### Properties

| Property                                                                       | Type      | Required |
|:-------------------------------------------------------------------------------|:----------|:---------|
| [allowKindChange](#specdistributioncustompatchespatchesoptionsallowkindchange) | `boolean` | Optional |
| [allowNameChange](#specdistributioncustompatchespatchesoptionsallownamechange) | `boolean` | Optional |

## .spec.distribution.customPatches.patches.options.allowKindChange

### Description

If true, the kind change will be allowed

## .spec.distribution.customPatches.patches.options.allowNameChange

### Description

If true, the name change will be allowed

## .spec.distribution.customPatches.patches.patch

### Description

The patch content

## .spec.distribution.customPatches.patches.path

### Description

The path of the patch

## .spec.distribution.customPatches.patches.target

### Properties

| Property                                                                            | Type     | Required |
|:------------------------------------------------------------------------------------|:---------|:---------|
| [annotationSelector](#specdistributioncustompatchespatchestargetannotationselector) | `string` | Optional |
| [group](#specdistributioncustompatchespatchestargetgroup)                           | `string` | Optional |
| [kind](#specdistributioncustompatchespatchestargetkind)                             | `string` | Optional |
| [labelSelector](#specdistributioncustompatchespatchestargetlabelselector)           | `string` | Optional |
| [name](#specdistributioncustompatchespatchestargetname)                             | `string` | Optional |
| [namespace](#specdistributioncustompatchespatchestargetnamespace)                   | `string` | Optional |
| [version](#specdistributioncustompatchespatchestargetversion)                       | `string` | Optional |

## .spec.distribution.customPatches.patches.target.annotationSelector

### Description

The annotation selector of the target

## .spec.distribution.customPatches.patches.target.group

### Description

The group of the target

## .spec.distribution.customPatches.patches.target.kind

### Description

The kind of the target

## .spec.distribution.customPatches.patches.target.labelSelector

### Description

The label selector of the target

## .spec.distribution.customPatches.patches.target.name

### Description

The name of the target

## .spec.distribution.customPatches.patches.target.namespace

### Description

The namespace of the target

## .spec.distribution.customPatches.patches.target.version

### Description

The version of the target

## .spec.distribution.customPatches.patchesStrategicMerge

### Description

Each entry should be either a relative file path or an inline content resolving to a partial or complete resource definition

## .spec.distribution.customPatches.secretGenerator

### Properties

| Property                                                            | Type     | Required |
|:--------------------------------------------------------------------|:---------|:---------|
| [behavior](#specdistributioncustompatchessecretgeneratorbehavior)   | `string` | Optional |
| [envs](#specdistributioncustompatchessecretgeneratorenvs)           | `array`  | Optional |
| [files](#specdistributioncustompatchessecretgeneratorfiles)         | `array`  | Optional |
| [literals](#specdistributioncustompatchessecretgeneratorliterals)   | `array`  | Optional |
| [name](#specdistributioncustompatchessecretgeneratorname)           | `string` | Required |
| [namespace](#specdistributioncustompatchessecretgeneratornamespace) | `string` | Optional |
| [options](#specdistributioncustompatchessecretgeneratoroptions)     | `object` | Optional |
| [type](#specdistributioncustompatchessecretgeneratortype)           | `string` | Optional |

## .spec.distribution.customPatches.secretGenerator.behavior

### Description

The behavior of the secret

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value     |
|:----------|
|`"create"` |
|`"replace"`|
|`"merge"`  |

## .spec.distribution.customPatches.secretGenerator.envs

### Description

The envs of the secret

## .spec.distribution.customPatches.secretGenerator.files

### Description

The files of the secret

## .spec.distribution.customPatches.secretGenerator.literals

### Description

The literals of the secret

## .spec.distribution.customPatches.secretGenerator.name

### Description

The name of the secret

## .spec.distribution.customPatches.secretGenerator.namespace

### Description

The namespace of the secret

## .spec.distribution.customPatches.secretGenerator.options

### Properties

| Property                                                                                           | Type      | Required |
|:---------------------------------------------------------------------------------------------------|:----------|:---------|
| [annotations](#specdistributioncustompatchessecretgeneratoroptionsannotations)                     | `object`  | Optional |
| [disableNameSuffixHash](#specdistributioncustompatchessecretgeneratoroptionsdisablenamesuffixhash) | `boolean` | Optional |
| [immutable](#specdistributioncustompatchessecretgeneratoroptionsimmutable)                         | `boolean` | Optional |
| [labels](#specdistributioncustompatchessecretgeneratoroptionslabels)                               | `object`  | Optional |

## .spec.distribution.customPatches.secretGenerator.options.annotations

### Description

The annotations of the secret

## .spec.distribution.customPatches.secretGenerator.options.disableNameSuffixHash

### Description

If true, the name suffix hash will be disabled

## .spec.distribution.customPatches.secretGenerator.options.immutable

### Description

If true, the secret will be immutable

## .spec.distribution.customPatches.secretGenerator.options.labels

### Description

The labels of the secret

## .spec.distribution.customPatches.secretGenerator.type

### Description

The type of the secret

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

| Property                                             | Type     | Required |
|:-----------------------------------------------------|:---------|:---------|
| [baseDomain](#specdistributionmodulesauthbasedomain) | `string` | Optional |
| [dex](#specdistributionmodulesauthdex)               | `object` | Optional |
| [overrides](#specdistributionmodulesauthoverrides)   | `object` | Optional |
| [pomerium](#specdistributionmodulesauthpomerium)     | `object` | Optional |
| [provider](#specdistributionmodulesauthprovider)     | `object` | Required |

## .spec.distribution.modules.auth.baseDomain

### Description

The base domain for the auth module

## .spec.distribution.modules.auth.dex

### Properties

| Property                                                                          | Type     | Required |
|:----------------------------------------------------------------------------------|:---------|:---------|
| [additionalStaticClients](#specdistributionmodulesauthdexadditionalstaticclients) | `array`  | Optional |
| [connectors](#specdistributionmodulesauthdexconnectors)                           | `array`  | Required |
| [expiry](#specdistributionmodulesauthdexexpiry)                                   | `object` | Optional |
| [overrides](#specdistributionmodulesauthdexoverrides)                             | `object` | Optional |

## .spec.distribution.modules.auth.dex.additionalStaticClients

### Description

The additional static clients for dex

## .spec.distribution.modules.auth.dex.connectors

### Description

The connectors for dex

## .spec.distribution.modules.auth.dex.expiry

### Properties

| Property                                                        | Type     | Required |
|:----------------------------------------------------------------|:---------|:---------|
| [idTokens](#specdistributionmodulesauthdexexpiryidtokens)       | `string` | Optional |
| [signingKeys](#specdistributionmodulesauthdexexpirysigningkeys) | `string` | Optional |

## .spec.distribution.modules.auth.dex.expiry.idTokens

### Description

Dex ID tokens expiration time duration (default 24h).

## .spec.distribution.modules.auth.dex.expiry.signingKeys

### Description

Dex signing key expiration time duration (default 6h).

## .spec.distribution.modules.auth.dex.overrides

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesauthdexoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesauthdexoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.auth.dex.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.auth.dex.overrides.tolerations

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesauthdexoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesauthdexoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesauthdexoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesauthdexoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.auth.dex.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.auth.dex.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.auth.dex.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.auth.dex.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.auth.overrides

### Properties

| Property                                                          | Type     | Required |
|:------------------------------------------------------------------|:---------|:---------|
| [ingresses](#specdistributionmodulesauthoverridesingresses)       | `object` | Optional |
| [nodeSelector](#specdistributionmodulesauthoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesauthoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.auth.overrides.ingresses

## .spec.distribution.modules.auth.overrides.nodeSelector

### Description

The node selector to use to place the pods for the auth module

## .spec.distribution.modules.auth.overrides.tolerations

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesauthoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesauthoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesauthoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesauthoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the auth module

## .spec.distribution.modules.auth.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.auth.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.auth.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.auth.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.auth.pomerium

### Properties

| Property                                                                       | Type     | Required |
|:-------------------------------------------------------------------------------|:---------|:---------|
| [defaultRoutesPolicy](#specdistributionmodulesauthpomeriumdefaultroutespolicy) | `object` | Optional |
| [overrides](#specdistributionmodulesauthpomeriumoverrides)                     | `object` | Optional |
| [policy](#specdistributionmodulesauthpomeriumpolicy)                           | `string` | Optional |
| [routes](#specdistributionmodulesauthpomeriumroutes)                           | `array`  | Optional |
| [secrets](#specdistributionmodulesauthpomeriumsecrets)                         | `object` | Required |

### Description

Configuration for Pomerium, an identity-aware reverse proxy used for SSO.

## .spec.distribution.modules.auth.pomerium.defaultRoutesPolicy

### Properties

| Property                                                                                                          | Type    | Required |
|:------------------------------------------------------------------------------------------------------------------|:--------|:---------|
| [gatekeeperPolicyManager](#specdistributionmodulesauthpomeriumdefaultroutespolicygatekeeperpolicymanager)         | `array` | Optional |
| [hubbleUi](#specdistributionmodulesauthpomeriumdefaultroutespolicyhubbleui)                                       | `array` | Optional |
| [ingressNgnixForecastle](#specdistributionmodulesauthpomeriumdefaultroutespolicyingressngnixforecastle)           | `array` | Optional |
| [loggingMinioConsole](#specdistributionmodulesauthpomeriumdefaultroutespolicyloggingminioconsole)                 | `array` | Optional |
| [loggingOpensearchDashboards](#specdistributionmodulesauthpomeriumdefaultroutespolicyloggingopensearchdashboards) | `array` | Optional |
| [monitoringAlertmanager](#specdistributionmodulesauthpomeriumdefaultroutespolicymonitoringalertmanager)           | `array` | Optional |
| [monitoringGrafana](#specdistributionmodulesauthpomeriumdefaultroutespolicymonitoringgrafana)                     | `array` | Optional |
| [monitoringMinioConsole](#specdistributionmodulesauthpomeriumdefaultroutespolicymonitoringminioconsole)           | `array` | Optional |
| [monitoringPrometheus](#specdistributionmodulesauthpomeriumdefaultroutespolicymonitoringprometheus)               | `array` | Optional |
| [tracingMinioConsole](#specdistributionmodulesauthpomeriumdefaultroutespolicytracingminioconsole)                 | `array` | Optional |

### Description

override default routes for KFD components

## .spec.distribution.modules.auth.pomerium.defaultRoutesPolicy.gatekeeperPolicyManager

## .spec.distribution.modules.auth.pomerium.defaultRoutesPolicy.hubbleUi

## .spec.distribution.modules.auth.pomerium.defaultRoutesPolicy.ingressNgnixForecastle

## .spec.distribution.modules.auth.pomerium.defaultRoutesPolicy.loggingMinioConsole

## .spec.distribution.modules.auth.pomerium.defaultRoutesPolicy.loggingOpensearchDashboards

## .spec.distribution.modules.auth.pomerium.defaultRoutesPolicy.monitoringAlertmanager

## .spec.distribution.modules.auth.pomerium.defaultRoutesPolicy.monitoringGrafana

## .spec.distribution.modules.auth.pomerium.defaultRoutesPolicy.monitoringMinioConsole

## .spec.distribution.modules.auth.pomerium.defaultRoutesPolicy.monitoringPrometheus

## .spec.distribution.modules.auth.pomerium.defaultRoutesPolicy.tracingMinioConsole

## .spec.distribution.modules.auth.pomerium.overrides

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesauthpomeriumoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesauthpomeriumoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.auth.pomerium.overrides.nodeSelector

## .spec.distribution.modules.auth.pomerium.overrides.tolerations

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesauthpomeriumoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesauthpomeriumoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesauthpomeriumoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesauthpomeriumoverridestolerationsvalue)       | `string` | Required |

## .spec.distribution.modules.auth.pomerium.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.auth.pomerium.overrides.tolerations.key

## .spec.distribution.modules.auth.pomerium.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.auth.pomerium.overrides.tolerations.value

## .spec.distribution.modules.auth.pomerium.policy

### Description

DEPRECATED: Use defaultRoutesPolicy and/or routes

## .spec.distribution.modules.auth.pomerium.routes

### Description

Additional routes configuration for Pomerium. Follows Pomerium's route format: https://www.pomerium.com/docs/reference/routes

## .spec.distribution.modules.auth.pomerium.secrets

### Properties

| Property                                                                          | Type     | Required |
|:----------------------------------------------------------------------------------|:---------|:---------|
| [COOKIE_SECRET](#specdistributionmodulesauthpomeriumsecretscookie_secret)         | `string` | Required |
| [IDP_CLIENT_SECRET](#specdistributionmodulesauthpomeriumsecretsidp_client_secret) | `string` | Required |
| [SHARED_SECRET](#specdistributionmodulesauthpomeriumsecretsshared_secret)         | `string` | Required |
| [SIGNING_KEY](#specdistributionmodulesauthpomeriumsecretssigning_key)             | `string` | Required |

### Description

Pomerium needs some user-provided secrets to be fully configured. These secrets should be unique between clusters.

## .spec.distribution.modules.auth.pomerium.secrets.COOKIE_SECRET

### Description

Cookie Secret is the secret used to encrypt and sign session cookies.

To generate a random key, run the following command: `head -c32 /dev/urandom | base64`

## .spec.distribution.modules.auth.pomerium.secrets.IDP_CLIENT_SECRET

### Description

Identity Provider Client Secret is the OAuth 2.0 Secret Identifier. When auth type is SSO, this value will be the secret used to authenticate Pomerium with Dex, **use a strong random value**.

## .spec.distribution.modules.auth.pomerium.secrets.SHARED_SECRET

### Description

Shared Secret is the base64-encoded, 256-bit key used to mutually authenticate requests between Pomerium services. It's critical that secret keys are random, and stored safely.

To generate a key, run the following command: `head -c32 /dev/urandom | base64`

## .spec.distribution.modules.auth.pomerium.secrets.SIGNING_KEY

### Description

Signing Key is the base64 representation of one or more PEM-encoded private keys used to sign a user's attestation JWT, which can be consumed by upstream applications to pass along identifying user information like username, id, and groups.

To generates an P-256 (ES256) signing key:

```bash
openssl ecparam  -genkey  -name prime256v1  -noout  -out ec_private.pem
# careful! this will output your private key in terminal
cat ec_private.pem | base64
```

## .spec.distribution.modules.auth.provider

### Properties

| Property                                                   | Type     | Required |
|:-----------------------------------------------------------|:---------|:---------|
| [basicAuth](#specdistributionmodulesauthproviderbasicauth) | `object` | Optional |
| [type](#specdistributionmodulesauthprovidertype)           | `string` | Required |

## .spec.distribution.modules.auth.provider.basicAuth

### Properties

| Property                                                          | Type     | Required |
|:------------------------------------------------------------------|:---------|:---------|
| [password](#specdistributionmodulesauthproviderbasicauthpassword) | `string` | Required |
| [username](#specdistributionmodulesauthproviderbasicauthusername) | `string` | Required |

## .spec.distribution.modules.auth.provider.basicAuth.password

### Description

The password for the basic auth

## .spec.distribution.modules.auth.provider.basicAuth.username

### Description

The username for the basic auth

## .spec.distribution.modules.auth.provider.type

### Description

The type of the provider, must be ***none***, ***sso*** or ***basicAuth***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value       |
|:------------|
|`"none"`     |
|`"basicAuth"`|
|`"sso"`      |

## .spec.distribution.modules.dr

### Properties

| Property                                         | Type     | Required |
|:-------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesdroverrides) | `object` | Optional |
| [type](#specdistributionmodulesdrtype)           | `string` | Required |
| [velero](#specdistributionmodulesdrvelero)       | `object` | Optional |

## .spec.distribution.modules.dr.overrides

### Properties

| Property                                                        | Type     | Required |
|:----------------------------------------------------------------|:---------|:---------|
| [ingresses](#specdistributionmodulesdroverridesingresses)       | `object` | Optional |
| [nodeSelector](#specdistributionmodulesdroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesdroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.dr.overrides.ingresses

## .spec.distribution.modules.dr.overrides.nodeSelector

### Description

The node selector to use to place the pods for the security module

## .spec.distribution.modules.dr.overrides.tolerations

### Properties

| Property                                                           | Type     | Required |
|:-------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesdroverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesdroverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesdroverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesdroverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the monitoring module

## .spec.distribution.modules.dr.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.dr.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.dr.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.dr.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.dr.type

### Description

The type of the DR, must be ***none*** or ***on-premises***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value         |
|:--------------|
|`"none"`       |
|`"on-premises"`|

## .spec.distribution.modules.dr.velero

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [backend](#specdistributionmodulesdrvelerobackend)                   | `string` | Optional |
| [externalEndpoint](#specdistributionmodulesdrveleroexternalendpoint) | `object` | Optional |
| [overrides](#specdistributionmodulesdrvelerooverrides)               | `object` | Optional |
| [retentionTime](#specdistributionmodulesdrveleroretentiontime)       | `string` | Optional |

## .spec.distribution.modules.dr.velero.backend

### Description

The backend for velero

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"minio"`           |
|`"externalEndpoint"`|

## .spec.distribution.modules.dr.velero.externalEndpoint

### Properties

| Property                                                                           | Type      | Required |
|:-----------------------------------------------------------------------------------|:----------|:---------|
| [accessKeyId](#specdistributionmodulesdrveleroexternalendpointaccesskeyid)         | `string`  | Optional |
| [bucketName](#specdistributionmodulesdrveleroexternalendpointbucketname)           | `string`  | Optional |
| [endpoint](#specdistributionmodulesdrveleroexternalendpointendpoint)               | `string`  | Optional |
| [insecure](#specdistributionmodulesdrveleroexternalendpointinsecure)               | `boolean` | Optional |
| [secretAccessKey](#specdistributionmodulesdrveleroexternalendpointsecretaccesskey) | `string`  | Optional |

## .spec.distribution.modules.dr.velero.externalEndpoint.accessKeyId

### Description

The access key id for velero backend

## .spec.distribution.modules.dr.velero.externalEndpoint.bucketName

### Description

The bucket name for velero backend

## .spec.distribution.modules.dr.velero.externalEndpoint.endpoint

### Description

The endpoint for velero

## .spec.distribution.modules.dr.velero.externalEndpoint.insecure

### Description

If true, the endpoint will be insecure

## .spec.distribution.modules.dr.velero.externalEndpoint.secretAccessKey

### Description

The secret access key for velero backend

## .spec.distribution.modules.dr.velero.overrides

### Properties

| Property                                                              | Type     | Required |
|:----------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesdrvelerooverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesdrvelerooverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.dr.velero.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.dr.velero.overrides.tolerations

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesdrvelerooverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesdrvelerooverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesdrvelerooverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesdrvelerooverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.dr.velero.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.dr.velero.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.dr.velero.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.dr.velero.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.dr.velero.retentionTime

### Description

The retention time for velero

## .spec.distribution.modules.ingress

### Properties

| Property                                                  | Type     | Required |
|:----------------------------------------------------------|:---------|:---------|
| [baseDomain](#specdistributionmodulesingressbasedomain)   | `string` | Required |
| [certManager](#specdistributionmodulesingresscertmanager) | `object` | Optional |
| [forecastle](#specdistributionmodulesingressforecastle)   | `object` | Optional |
| [nginx](#specdistributionmodulesingressnginx)             | `object` | Required |
| [overrides](#specdistributionmodulesingressoverrides)     | `object` | Optional |

## .spec.distribution.modules.ingress.baseDomain

### Description

the base domain used for all the KFD ingresses, if in the nginx dual configuration, it should be the same as the .spec.distribution.modules.ingress.dns.private.name zone

## .spec.distribution.modules.ingress.certManager

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [clusterIssuer](#specdistributionmodulesingresscertmanagerclusterissuer) | `object` | Required |
| [overrides](#specdistributionmodulesingresscertmanageroverrides)         | `object` | Optional |

## .spec.distribution.modules.ingress.certManager.clusterIssuer

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [email](#specdistributionmodulesingresscertmanagerclusterissueremail)     | `string` | Required |
| [name](#specdistributionmodulesingresscertmanagerclusterissuername)       | `string` | Required |
| [solvers](#specdistributionmodulesingresscertmanagerclusterissuersolvers) | `array`  | Optional |
| [type](#specdistributionmodulesingresscertmanagerclusterissuertype)       | `string` | Optional |

## .spec.distribution.modules.ingress.certManager.clusterIssuer.email

### Description

The email of the cluster issuer

## .spec.distribution.modules.ingress.certManager.clusterIssuer.name

### Description

The name of the cluster issuer

## .spec.distribution.modules.ingress.certManager.clusterIssuer.solvers

### Description

The custom solvers configurations

## .spec.distribution.modules.ingress.certManager.clusterIssuer.type

### Description

The type of the cluster issuer, must be ***http01***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"http01"`|

## .spec.distribution.modules.ingress.certManager.overrides

### Properties

| Property                                                                        | Type     | Required |
|:--------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesingresscertmanageroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesingresscertmanageroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.ingress.certManager.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.ingress.certManager.overrides.tolerations

### Properties

| Property                                                                           | Type     | Required |
|:-----------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesingresscertmanageroverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesingresscertmanageroverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesingresscertmanageroverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesingresscertmanageroverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.ingress.certManager.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.ingress.certManager.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.certManager.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

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

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.ingress.forecastle.overrides.tolerations

### Properties

| Property                                                                          | Type     | Required |
|:----------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesingressforecastleoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesingressforecastleoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesingressforecastleoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesingressforecastleoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.ingress.forecastle.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.ingress.forecastle.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.forecastle.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.ingress.forecastle.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.ingress.nginx

### Properties

| Property                                                   | Type     | Required |
|:-----------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesingressnginxoverrides) | `object` | Optional |
| [tls](#specdistributionmodulesingressnginxtls)             | `object` | Optional |
| [type](#specdistributionmodulesingressnginxtype)           | `string` | Required |

### Description

Configurations for the nginx ingress controller module

## .spec.distribution.modules.ingress.nginx.overrides

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesingressnginxoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesingressnginxoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.ingress.nginx.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.ingress.nginx.overrides.tolerations

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesingressnginxoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesingressnginxoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesingressnginxoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesingressnginxoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.ingress.nginx.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.ingress.nginx.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.nginx.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.ingress.nginx.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.ingress.nginx.tls

### Properties

| Property                                                    | Type     | Required |
|:------------------------------------------------------------|:---------|:---------|
| [provider](#specdistributionmodulesingressnginxtlsprovider) | `string` | Required |
| [secret](#specdistributionmodulesingressnginxtlssecret)     | `object` | Optional |

## .spec.distribution.modules.ingress.nginx.tls.provider

### Description

The provider of the TLS certificate, must be ***none***, ***certManager*** or ***secret***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value         |
|:--------------|
|`"certManager"`|
|`"secret"`     |
|`"none"`       |

## .spec.distribution.modules.ingress.nginx.tls.secret

### Properties

| Property                                                  | Type     | Required |
|:----------------------------------------------------------|:---------|:---------|
| [ca](#specdistributionmodulesingressnginxtlssecretca)     | `string` | Required |
| [cert](#specdistributionmodulesingressnginxtlssecretcert) | `string` | Required |
| [key](#specdistributionmodulesingressnginxtlssecretkey)   | `string` | Required |

## .spec.distribution.modules.ingress.nginx.tls.secret.ca

## .spec.distribution.modules.ingress.nginx.tls.secret.cert

### Description

The certificate file content or you can use the file notation to get the content from a file

## .spec.distribution.modules.ingress.nginx.tls.secret.key

## .spec.distribution.modules.ingress.nginx.type

### Description

The type of the nginx ingress controller, must be ***none***, ***single*** or ***dual***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"none"`  |
|`"single"`|
|`"dual"`  |

## .spec.distribution.modules.ingress.overrides

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [ingresses](#specdistributionmodulesingressoverridesingresses)       | `object` | Optional |
| [nodeSelector](#specdistributionmodulesingressoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesingressoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.ingress.overrides.ingresses

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [forecastle](#specdistributionmodulesingressoverridesingressesforecastle) | `object` | Optional |

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle

### Properties

| Property                                                                                | Type      | Required |
|:----------------------------------------------------------------------------------------|:----------|:---------|
| [disableAuth](#specdistributionmodulesingressoverridesingressesforecastledisableauth)   | `boolean` | Optional |
| [host](#specdistributionmodulesingressoverridesingressesforecastlehost)                 | `string`  | Optional |
| [ingressClass](#specdistributionmodulesingressoverridesingressesforecastleingressclass) | `string`  | Optional |

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle.disableAuth

### Description

If true, the ingress will not have authentication

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle.host

### Description

The host of the ingress

## .spec.distribution.modules.ingress.overrides.ingresses.forecastle.ingressClass

### Description

The ingress class of the ingress

## .spec.distribution.modules.ingress.overrides.nodeSelector

### Description

The node selector to use to place the pods for the ingress module

## .spec.distribution.modules.ingress.overrides.tolerations

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesingressoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesingressoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesingressoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesingressoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the ingress module

## .spec.distribution.modules.ingress.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.ingress.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.ingress.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.ingress.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.logging

### Properties

| Property                                                      | Type     | Required |
|:--------------------------------------------------------------|:---------|:---------|
| [cerebro](#specdistributionmodulesloggingcerebro)             | `object` | Optional |
| [customOutputs](#specdistributionmodulesloggingcustomoutputs) | `object` | Optional |
| [loki](#specdistributionmodulesloggingloki)                   | `object` | Optional |
| [minio](#specdistributionmodulesloggingminio)                 | `object` | Optional |
| [opensearch](#specdistributionmodulesloggingopensearch)       | `object` | Optional |
| [operator](#specdistributionmodulesloggingoperator)           | `object` | Optional |
| [overrides](#specdistributionmodulesloggingoverrides)         | `object` | Optional |
| [type](#specdistributionmodulesloggingtype)                   | `string` | Required |

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

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.logging.cerebro.overrides.tolerations

### Properties

| Property                                                                       | Type     | Required |
|:-------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesloggingcerebrooverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesloggingcerebrooverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesloggingcerebrooverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesloggingcerebrooverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.logging.cerebro.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.logging.cerebro.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.logging.cerebro.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.logging.cerebro.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.logging.customOutputs

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [audit](#specdistributionmodulesloggingcustomoutputsaudit)                 | `string` | Required |
| [errors](#specdistributionmodulesloggingcustomoutputserrors)               | `string` | Required |
| [events](#specdistributionmodulesloggingcustomoutputsevents)               | `string` | Required |
| [infra](#specdistributionmodulesloggingcustomoutputsinfra)                 | `string` | Required |
| [ingressNginx](#specdistributionmodulesloggingcustomoutputsingressnginx)   | `string` | Required |
| [kubernetes](#specdistributionmodulesloggingcustomoutputskubernetes)       | `string` | Required |
| [systemdCommon](#specdistributionmodulesloggingcustomoutputssystemdcommon) | `string` | Required |
| [systemdEtcd](#specdistributionmodulesloggingcustomoutputssystemdetcd)     | `string` | Required |

### Description

when using the customOutputs logging type, you need to manually specify the spec of the several Output and ClusterOutputs that the Logging Operator expects to forward the logs collected by the pre-defined flows.

## .spec.distribution.modules.logging.customOutputs.audit

### Description

This value defines where the output from Flow will be sent. Will be the `spec` section of the `Output` object. It must be a string (and not a YAML object) following the OutputSpec definition. Use the nullout output to discard the flow.

## .spec.distribution.modules.logging.customOutputs.errors

### Description

This value defines where the output from Flow will be sent. Will be the `spec` section of the `Output` object. It must be a string (and not a YAML object) following the OutputSpec definition. Use the nullout output to discard the flow.

## .spec.distribution.modules.logging.customOutputs.events

### Description

This value defines where the output from Flow will be sent. Will be the `spec` section of the `Output` object. It must be a string (and not a YAML object) following the OutputSpec definition. Use the nullout output to discard the flow.

## .spec.distribution.modules.logging.customOutputs.infra

### Description

This value defines where the output from Flow will be sent. Will be the `spec` section of the `Output` object. It must be a string (and not a YAML object) following the OutputSpec definition. Use the nullout output to discard the flow.

## .spec.distribution.modules.logging.customOutputs.ingressNginx

### Description

This value defines where the output from Flow will be sent. Will be the `spec` section of the `Output` object. It must be a string (and not a YAML object) following the OutputSpec definition. Use the nullout output to discard the flow.

## .spec.distribution.modules.logging.customOutputs.kubernetes

### Description

This value defines where the output from Flow will be sent. Will be the `spec` section of the `Output` object. It must be a string (and not a YAML object) following the OutputSpec definition. Use the nullout output to discard the flow.

## .spec.distribution.modules.logging.customOutputs.systemdCommon

### Description

This value defines where the output from Flow will be sent. Will be the `spec` section of the `Output` object. It must be a string (and not a YAML object) following the OutputSpec definition. Use the nullout output to discard the flow.

## .spec.distribution.modules.logging.customOutputs.systemdEtcd

### Description

This value defines where the output from Flow will be sent. Will be the `spec` section of the `Output` object. It must be a string (and not a YAML object) following the OutputSpec definition. Use the nullout output to discard the flow.

## .spec.distribution.modules.logging.loki

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [backend](#specdistributionmoduleslogginglokibackend)                   | `string` | Optional |
| [externalEndpoint](#specdistributionmoduleslogginglokiexternalendpoint) | `object` | Optional |
| [resources](#specdistributionmoduleslogginglokiresources)               | `object` | Optional |

## .spec.distribution.modules.logging.loki.backend

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"minio"`           |
|`"externalEndpoint"`|

## .spec.distribution.modules.logging.loki.externalEndpoint

### Properties

| Property                                                                              | Type      | Required |
|:--------------------------------------------------------------------------------------|:----------|:---------|
| [accessKeyId](#specdistributionmoduleslogginglokiexternalendpointaccesskeyid)         | `string`  | Optional |
| [bucketName](#specdistributionmoduleslogginglokiexternalendpointbucketname)           | `string`  | Optional |
| [endpoint](#specdistributionmoduleslogginglokiexternalendpointendpoint)               | `string`  | Optional |
| [insecure](#specdistributionmoduleslogginglokiexternalendpointinsecure)               | `boolean` | Optional |
| [secretAccessKey](#specdistributionmoduleslogginglokiexternalendpointsecretaccesskey) | `string`  | Optional |

## .spec.distribution.modules.logging.loki.externalEndpoint.accessKeyId

### Description

The access key id of the loki external endpoint

## .spec.distribution.modules.logging.loki.externalEndpoint.bucketName

### Description

The bucket name of the loki external endpoint

## .spec.distribution.modules.logging.loki.externalEndpoint.endpoint

### Description

The endpoint of the loki external endpoint

## .spec.distribution.modules.logging.loki.externalEndpoint.insecure

### Description

If true, the loki external endpoint will be insecure

## .spec.distribution.modules.logging.loki.externalEndpoint.secretAccessKey

### Description

The secret access key of the loki external endpoint

## .spec.distribution.modules.logging.loki.resources

### Properties

| Property                                                         | Type     | Required |
|:-----------------------------------------------------------------|:---------|:---------|
| [limits](#specdistributionmoduleslogginglokiresourceslimits)     | `object` | Optional |
| [requests](#specdistributionmoduleslogginglokiresourcesrequests) | `object` | Optional |

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

The memory limit for the opensearch pods

## .spec.distribution.modules.logging.loki.resources.requests

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmoduleslogginglokiresourcesrequestscpu)       | `string` | Optional |
| [memory](#specdistributionmoduleslogginglokiresourcesrequestsmemory) | `string` | Optional |

## .spec.distribution.modules.logging.loki.resources.requests.cpu

### Description

The cpu request for the prometheus pods

## .spec.distribution.modules.logging.loki.resources.requests.memory

### Description

The memory request for the opensearch pods

## .spec.distribution.modules.logging.minio

### Properties

| Property                                                       | Type     | Required |
|:---------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesloggingminiooverrides)     | `object` | Optional |
| [rootUser](#specdistributionmodulesloggingminiorootuser)       | `object` | Optional |
| [storageSize](#specdistributionmodulesloggingminiostoragesize) | `string` | Optional |

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
| [key](#specdistributionmodulesloggingminiooverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesloggingminiooverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesloggingminiooverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.logging.minio.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.logging.minio.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.logging.minio.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.logging.minio.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.logging.minio.rootUser

### Properties

| Property                                                         | Type     | Required |
|:-----------------------------------------------------------------|:---------|:---------|
| [password](#specdistributionmodulesloggingminiorootuserpassword) | `string` | Optional |
| [username](#specdistributionmodulesloggingminiorootuserusername) | `string` | Optional |

## .spec.distribution.modules.logging.minio.rootUser.password

### Description

The password of the minio root user

## .spec.distribution.modules.logging.minio.rootUser.username

### Description

The username of the minio root user

## .spec.distribution.modules.logging.minio.storageSize

### Description

The PVC size for each minio disk, 6 disks total

## .spec.distribution.modules.logging.opensearch

### Properties

| Property                                                            | Type     | Required |
|:--------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesloggingopensearchoverrides)     | `object` | Optional |
| [resources](#specdistributionmodulesloggingopensearchresources)     | `object` | Optional |
| [storageSize](#specdistributionmodulesloggingopensearchstoragesize) | `string` | Optional |
| [type](#specdistributionmodulesloggingopensearchtype)               | `string` | Required |

## .spec.distribution.modules.logging.opensearch.overrides

### Properties

| Property                                                                       | Type     | Required |
|:-------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesloggingopensearchoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesloggingopensearchoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.logging.opensearch.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.logging.opensearch.overrides.tolerations

### Properties

| Property                                                                          | Type     | Required |
|:----------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesloggingopensearchoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesloggingopensearchoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesloggingopensearchoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesloggingopensearchoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.logging.opensearch.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.logging.opensearch.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.logging.opensearch.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.logging.opensearch.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.logging.opensearch.resources

### Properties

| Property                                                               | Type     | Required |
|:-----------------------------------------------------------------------|:---------|:---------|
| [limits](#specdistributionmodulesloggingopensearchresourceslimits)     | `object` | Optional |
| [requests](#specdistributionmodulesloggingopensearchresourcesrequests) | `object` | Optional |

## .spec.distribution.modules.logging.opensearch.resources.limits

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmodulesloggingopensearchresourceslimitscpu)       | `string` | Optional |
| [memory](#specdistributionmodulesloggingopensearchresourceslimitsmemory) | `string` | Optional |

## .spec.distribution.modules.logging.opensearch.resources.limits.cpu

### Description

The cpu limit for the loki pods

## .spec.distribution.modules.logging.opensearch.resources.limits.memory

### Description

The memory limit for the opensearch pods

## .spec.distribution.modules.logging.opensearch.resources.requests

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmodulesloggingopensearchresourcesrequestscpu)       | `string` | Optional |
| [memory](#specdistributionmodulesloggingopensearchresourcesrequestsmemory) | `string` | Optional |

## .spec.distribution.modules.logging.opensearch.resources.requests.cpu

### Description

The cpu request for the prometheus pods

## .spec.distribution.modules.logging.opensearch.resources.requests.memory

### Description

The memory request for the opensearch pods

## .spec.distribution.modules.logging.opensearch.storageSize

### Description

The storage size for the opensearch pods

## .spec.distribution.modules.logging.opensearch.type

### Description

The type of the opensearch, must be ***single*** or ***triple***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"single"`|
|`"triple"`|

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

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.logging.operator.overrides.tolerations

### Properties

| Property                                                                        | Type     | Required |
|:--------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesloggingoperatoroverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesloggingoperatoroverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesloggingoperatoroverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesloggingoperatoroverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.logging.operator.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.logging.operator.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.logging.operator.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.logging.operator.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.logging.overrides

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [ingresses](#specdistributionmodulesloggingoverridesingresses)       | `object` | Optional |
| [nodeSelector](#specdistributionmodulesloggingoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesloggingoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.logging.overrides.ingresses

## .spec.distribution.modules.logging.overrides.nodeSelector

### Description

The node selector to use to place the pods for the security module

## .spec.distribution.modules.logging.overrides.tolerations

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesloggingoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesloggingoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesloggingoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesloggingoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the monitoring module

## .spec.distribution.modules.logging.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.logging.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.logging.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.logging.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.logging.type

### Description

selects the logging stack. Choosing none will disable the centralized logging. Choosing opensearch will deploy and configure the Logging Operator and an OpenSearch cluster (can be single or triple for HA) where the logs will be stored. Choosing loki will use a distributed Grafana Loki instead of OpenSearh for storage. Choosing customOuput the Logging Operator will be deployed and installed but with no local storage, you will have to create the needed Outputs and ClusterOutputs to ship the logs to your desired storage.

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value           |
|:----------------|
|`"none"`         |
|`"opensearch"`   |
|`"loki"`         |
|`"customOutputs"`|

## .spec.distribution.modules.monitoring

### Properties

| Property                                                               | Type     | Required |
|:-----------------------------------------------------------------------|:---------|:---------|
| [alertmanager](#specdistributionmodulesmonitoringalertmanager)         | `object` | Optional |
| [blackboxExporter](#specdistributionmodulesmonitoringblackboxexporter) | `object` | Optional |
| [grafana](#specdistributionmodulesmonitoringgrafana)                   | `object` | Optional |
| [kubeStateMetrics](#specdistributionmodulesmonitoringkubestatemetrics) | `object` | Optional |
| [mimir](#specdistributionmodulesmonitoringmimir)                       | `object` | Optional |
| [minio](#specdistributionmodulesmonitoringminio)                       | `object` | Optional |
| [overrides](#specdistributionmodulesmonitoringoverrides)               | `object` | Optional |
| [prometheus](#specdistributionmodulesmonitoringprometheus)             | `object` | Optional |
| [prometheusAgent](#specdistributionmodulesmonitoringprometheusagent)   | `object` | Optional |
| [type](#specdistributionmodulesmonitoringtype)                         | `string` | Required |
| [x509Exporter](#specdistributionmodulesmonitoringx509exporter)         | `object` | Optional |

### Description

configuration for the Monitoring module components

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

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.monitoring.blackboxExporter.overrides.tolerations

### Properties

| Property                                                                                   | Type     | Required |
|:-------------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringblackboxexporteroverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesmonitoringblackboxexporteroverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesmonitoringblackboxexporteroverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesmonitoringblackboxexporteroverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.monitoring.blackboxExporter.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.monitoring.blackboxExporter.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.blackboxExporter.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.monitoring.blackboxExporter.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.grafana

### Properties

| Property                                                                                  | Type      | Required |
|:------------------------------------------------------------------------------------------|:----------|:---------|
| [basicAuthIngress](#specdistributionmodulesmonitoringgrafanabasicauthingress)             | `boolean` | Optional |
| [overrides](#specdistributionmodulesmonitoringgrafanaoverrides)                           | `object`  | Optional |
| [usersRoleAttributePath](#specdistributionmodulesmonitoringgrafanausersroleattributepath) | `string`  | Optional |

## .spec.distribution.modules.monitoring.grafana.basicAuthIngress

### Description

Setting this to true will deploy an additional `grafana-basic-auth` ingress protected with Grafana's basic auth instead of SSO. It's intended use is as a temporary ingress for when there are problems with the SSO login flow.

Notice that by default anonymous access is enabled.

## .spec.distribution.modules.monitoring.grafana.overrides

### Properties

| Property                                                                       | Type     | Required |
|:-------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesmonitoringgrafanaoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesmonitoringgrafanaoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.monitoring.grafana.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.monitoring.grafana.overrides.tolerations

### Properties

| Property                                                                          | Type     | Required |
|:----------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringgrafanaoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesmonitoringgrafanaoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesmonitoringgrafanaoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesmonitoringgrafanaoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.monitoring.grafana.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.monitoring.grafana.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.grafana.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.monitoring.grafana.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.grafana.usersRoleAttributePath

### Description

[JMESPath](http://jmespath.org/examples.html) expression to retrieve the user's role. Example:

```yaml
usersRoleAttributePath: "contains(groups[*], 'beta') && 'Admin' || contains(groups[*], 'gamma') && 'Editor' || contains(groups[*], 'delta') && 'Viewer'
```

More details in [Grafana's documentation](https://grafana.com/docs/grafana/latest/setup-grafana/configure-security/configure-authentication/generic-oauth/#configure-role-mapping).

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

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides.tolerations

### Properties

| Property                                                                                   | Type     | Required |
|:-------------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringkubestatemetricsoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesmonitoringkubestatemetricsoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesmonitoringkubestatemetricsoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesmonitoringkubestatemetricsoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.monitoring.kubeStateMetrics.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.mimir

### Properties

| Property                                                                    | Type     | Required |
|:----------------------------------------------------------------------------|:---------|:---------|
| [backend](#specdistributionmodulesmonitoringmimirbackend)                   | `string` | Optional |
| [externalEndpoint](#specdistributionmodulesmonitoringmimirexternalendpoint) | `object` | Optional |
| [overrides](#specdistributionmodulesmonitoringmimiroverrides)               | `object` | Optional |
| [retentionTime](#specdistributionmodulesmonitoringmimirretentiontime)       | `string` | Optional |

## .spec.distribution.modules.monitoring.mimir.backend

### Description

The backend for the mimir pods, must be ***minio*** or ***externalEndpoint***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"minio"`           |
|`"externalEndpoint"`|

## .spec.distribution.modules.monitoring.mimir.externalEndpoint

### Properties

| Property                                                                                  | Type      | Required |
|:------------------------------------------------------------------------------------------|:----------|:---------|
| [accessKeyId](#specdistributionmodulesmonitoringmimirexternalendpointaccesskeyid)         | `string`  | Optional |
| [bucketName](#specdistributionmodulesmonitoringmimirexternalendpointbucketname)           | `string`  | Optional |
| [endpoint](#specdistributionmodulesmonitoringmimirexternalendpointendpoint)               | `string`  | Optional |
| [insecure](#specdistributionmodulesmonitoringmimirexternalendpointinsecure)               | `boolean` | Optional |
| [secretAccessKey](#specdistributionmodulesmonitoringmimirexternalendpointsecretaccesskey) | `string`  | Optional |

## .spec.distribution.modules.monitoring.mimir.externalEndpoint.accessKeyId

### Description

The access key id of the external mimir backend

## .spec.distribution.modules.monitoring.mimir.externalEndpoint.bucketName

### Description

The bucket name of the external mimir backend

## .spec.distribution.modules.monitoring.mimir.externalEndpoint.endpoint

### Description

The endpoint of the external mimir backend

## .spec.distribution.modules.monitoring.mimir.externalEndpoint.insecure

### Description

If true, the external mimir backend will not use tls

## .spec.distribution.modules.monitoring.mimir.externalEndpoint.secretAccessKey

### Description

The secret access key of the external mimir backend

## .spec.distribution.modules.monitoring.mimir.overrides

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesmonitoringmimiroverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesmonitoringmimiroverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.monitoring.mimir.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.monitoring.mimir.overrides.tolerations

### Properties

| Property                                                                        | Type     | Required |
|:--------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringmimiroverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesmonitoringmimiroverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesmonitoringmimiroverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesmonitoringmimiroverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.monitoring.mimir.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.monitoring.mimir.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.mimir.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.monitoring.mimir.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.mimir.retentionTime

### Description

The retention time for the mimir pods

## .spec.distribution.modules.monitoring.minio

### Properties

| Property                                                          | Type     | Required |
|:------------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulesmonitoringminiooverrides)     | `object` | Optional |
| [rootUser](#specdistributionmodulesmonitoringminiorootuser)       | `object` | Optional |
| [storageSize](#specdistributionmodulesmonitoringminiostoragesize) | `string` | Optional |

## .spec.distribution.modules.monitoring.minio.overrides

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesmonitoringminiooverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesmonitoringminiooverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.monitoring.minio.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.monitoring.minio.overrides.tolerations

### Properties

| Property                                                                        | Type     | Required |
|:--------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringminiooverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesmonitoringminiooverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesmonitoringminiooverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesmonitoringminiooverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.monitoring.minio.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.monitoring.minio.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.minio.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.monitoring.minio.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.minio.rootUser

### Properties

| Property                                                            | Type     | Required |
|:--------------------------------------------------------------------|:---------|:---------|
| [password](#specdistributionmodulesmonitoringminiorootuserpassword) | `string` | Optional |
| [username](#specdistributionmodulesmonitoringminiorootuserusername) | `string` | Optional |

## .spec.distribution.modules.monitoring.minio.rootUser.password

### Description

The password for the minio root user

## .spec.distribution.modules.monitoring.minio.rootUser.username

### Description

The username for the minio root user

## .spec.distribution.modules.monitoring.minio.storageSize

### Description

The storage size for the minio pods

## .spec.distribution.modules.monitoring.overrides

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [ingresses](#specdistributionmodulesmonitoringoverridesingresses)       | `object` | Optional |
| [nodeSelector](#specdistributionmodulesmonitoringoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesmonitoringoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.monitoring.overrides.ingresses

## .spec.distribution.modules.monitoring.overrides.nodeSelector

### Description

The node selector to use to place the pods for the security module

## .spec.distribution.modules.monitoring.overrides.tolerations

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesmonitoringoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesmonitoringoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesmonitoringoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the monitoring module

## .spec.distribution.modules.monitoring.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.monitoring.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.monitoring.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.monitoring.prometheus

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [remoteWrite](#specdistributionmodulesmonitoringprometheusremotewrite)     | `array`  | Optional |
| [resources](#specdistributionmodulesmonitoringprometheusresources)         | `object` | Optional |
| [retentionSize](#specdistributionmodulesmonitoringprometheusretentionsize) | `string` | Optional |
| [retentionTime](#specdistributionmodulesmonitoringprometheusretentiontime) | `string` | Optional |
| [storageSize](#specdistributionmodulesmonitoringprometheusstoragesize)     | `string` | Optional |

## .spec.distribution.modules.monitoring.prometheus.remoteWrite

### Description

Set this option to ship the collected metrics to a remote Prometheus receiver.

`remoteWrite` is an array of objects that allows configuring the [remoteWrite](https://prometheus.io/docs/specs/remote_write_spec/) options for Prometheus. The objects in the array follow [the same schema as in the prometheus operator](https://prometheus-operator.dev/docs/operator/api/#monitoring.coreos.com/v1.RemoteWriteSpec).

## .spec.distribution.modules.monitoring.prometheus.resources

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [limits](#specdistributionmodulesmonitoringprometheusresourceslimits)     | `object` | Optional |
| [requests](#specdistributionmodulesmonitoringprometheusresourcesrequests) | `object` | Optional |

## .spec.distribution.modules.monitoring.prometheus.resources.limits

### Properties

| Property                                                                    | Type     | Required |
|:----------------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmodulesmonitoringprometheusresourceslimitscpu)       | `string` | Optional |
| [memory](#specdistributionmodulesmonitoringprometheusresourceslimitsmemory) | `string` | Optional |

## .spec.distribution.modules.monitoring.prometheus.resources.limits.cpu

### Description

The cpu limit for the loki pods

## .spec.distribution.modules.monitoring.prometheus.resources.limits.memory

### Description

The memory limit for the opensearch pods

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

The memory request for the opensearch pods

## .spec.distribution.modules.monitoring.prometheus.retentionSize

### Description

The retention size for the k8s Prometheus instance.

## .spec.distribution.modules.monitoring.prometheus.retentionTime

### Description

The retention time for the K8s Prometheus instance.

## .spec.distribution.modules.monitoring.prometheus.storageSize

### Description

The storage size for the k8s Prometheus instance.

## .spec.distribution.modules.monitoring.prometheusAgent

### Properties

| Property                                                                    | Type     | Required |
|:----------------------------------------------------------------------------|:---------|:---------|
| [remoteWrite](#specdistributionmodulesmonitoringprometheusagentremotewrite) | `array`  | Optional |
| [resources](#specdistributionmodulesmonitoringprometheusagentresources)     | `object` | Optional |

## .spec.distribution.modules.monitoring.prometheusAgent.remoteWrite

### Description

Set this option to ship the collected metrics to a remote Prometheus receiver.

`remoteWrite` is an array of objects that allows configuring the [remoteWrite](https://prometheus.io/docs/specs/remote_write_spec/) options for Prometheus. The objects in the array follow [the same schema as in the prometheus operator](https://prometheus-operator.dev/docs/operator/api/#monitoring.coreos.com/v1.RemoteWriteSpec).

## .spec.distribution.modules.monitoring.prometheusAgent.resources

### Properties

| Property                                                                       | Type     | Required |
|:-------------------------------------------------------------------------------|:---------|:---------|
| [limits](#specdistributionmodulesmonitoringprometheusagentresourceslimits)     | `object` | Optional |
| [requests](#specdistributionmodulesmonitoringprometheusagentresourcesrequests) | `object` | Optional |

## .spec.distribution.modules.monitoring.prometheusAgent.resources.limits

### Properties

| Property                                                                         | Type     | Required |
|:---------------------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmodulesmonitoringprometheusagentresourceslimitscpu)       | `string` | Optional |
| [memory](#specdistributionmodulesmonitoringprometheusagentresourceslimitsmemory) | `string` | Optional |

## .spec.distribution.modules.monitoring.prometheusAgent.resources.limits.cpu

### Description

The cpu limit for the loki pods

## .spec.distribution.modules.monitoring.prometheusAgent.resources.limits.memory

### Description

The memory limit for the opensearch pods

## .spec.distribution.modules.monitoring.prometheusAgent.resources.requests

### Properties

| Property                                                                           | Type     | Required |
|:-----------------------------------------------------------------------------------|:---------|:---------|
| [cpu](#specdistributionmodulesmonitoringprometheusagentresourcesrequestscpu)       | `string` | Optional |
| [memory](#specdistributionmodulesmonitoringprometheusagentresourcesrequestsmemory) | `string` | Optional |

## .spec.distribution.modules.monitoring.prometheusAgent.resources.requests.cpu

### Description

The cpu request for the prometheus pods

## .spec.distribution.modules.monitoring.prometheusAgent.resources.requests.memory

### Description

The memory request for the opensearch pods

## .spec.distribution.modules.monitoring.type

### Description

The type of the monitoring, must be ***none***, ***prometheus***, ***prometheusAgent*** or ***mimir***.

- `none`: will disable the whole monitoring stack.
- `prometheus`: will install Prometheus Operator and a preconfigured Prometheus instace, Alertmanager, a set of alert rules, exporters needed to monitor all the components of the cluster, Grafana and a series of dashboards to view the collected metrics, and more.
- `prometheusAgent`: wil install Prometheus operator, an instance of Prometheus in Agent mode (no alerting, no queries, no storage), and all the exporters needed to get metrics for the status of the cluster and the workloads. Useful when having a centralized (remote) Prometheus where to ship the metrics and not storing them locally in the cluster.
- `mimir`: will install the same as the `prometheus` option, and in addition Grafana Mimir that allows for longer retention of metrics and the usage of Object Storage.

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value             |
|:------------------|
|`"none"`           |
|`"prometheus"`     |
|`"prometheusAgent"`|
|`"mimir"`          |

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

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.monitoring.x509Exporter.overrides.tolerations

### Properties

| Property                                                                               | Type     | Required |
|:---------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesmonitoringx509exporteroverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesmonitoringx509exporteroverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesmonitoringx509exporteroverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesmonitoringx509exporteroverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.monitoring.x509Exporter.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.monitoring.x509Exporter.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.monitoring.x509Exporter.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.monitoring.x509Exporter.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.networking

### Properties

| Property                                                           | Type     | Required |
|:-------------------------------------------------------------------|:---------|:---------|
| [cilium](#specdistributionmodulesnetworkingcilium)                 | `object` | Optional |
| [overrides](#specdistributionmodulesnetworkingoverrides)           | `object` | Optional |
| [tigeraOperator](#specdistributionmodulesnetworkingtigeraoperator) | `object` | Optional |
| [type](#specdistributionmodulesnetworkingtype)                     | `string` | Required |

## .spec.distribution.modules.networking.cilium

### Properties

| Property                                                       | Type     | Required |
|:---------------------------------------------------------------|:---------|:---------|
| [maskSize](#specdistributionmodulesnetworkingciliummasksize)   | `string` | Required |
| [overrides](#specdistributionmodulesnetworkingciliumoverrides) | `object` | Optional |
| [podCidr](#specdistributionmodulesnetworkingciliumpodcidr)     | `string` | Required |

## .spec.distribution.modules.networking.cilium.maskSize

## .spec.distribution.modules.networking.cilium.overrides

### Properties

| Property                                                                      | Type     | Required |
|:------------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulesnetworkingciliumoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesnetworkingciliumoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.networking.cilium.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.networking.cilium.overrides.tolerations

### Properties

| Property                                                                         | Type     | Required |
|:---------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesnetworkingciliumoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesnetworkingciliumoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesnetworkingciliumoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesnetworkingciliumoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.networking.cilium.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.networking.cilium.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.networking.cilium.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.networking.cilium.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.networking.cilium.podCidr

### Constraints

**pattern**: the string must match the following regular expression:

```regexp
^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}\/(3[0-2]|[1-2][0-9]|[0-9])$
```

[try pattern](https://regexr.com/?expression=^\(\(25[0-5]|\(2[0-4]|1\d|[1-9]|\)\d\)\.?\b\){4}\\/\(3[0-2]|[1-2][0-9]|[0-9]\)$)

## .spec.distribution.modules.networking.overrides

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [ingresses](#specdistributionmodulesnetworkingoverridesingresses)       | `object` | Optional |
| [nodeSelector](#specdistributionmodulesnetworkingoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulesnetworkingoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.networking.overrides.ingresses

## .spec.distribution.modules.networking.overrides.nodeSelector

### Description

The node selector to use to place the pods for the security module

## .spec.distribution.modules.networking.overrides.tolerations

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesnetworkingoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesnetworkingoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesnetworkingoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesnetworkingoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the monitoring module

## .spec.distribution.modules.networking.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.networking.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.networking.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

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

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.networking.tigeraOperator.overrides.tolerations

### Properties

| Property                                                                                 | Type     | Required |
|:-----------------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulesnetworkingtigeraoperatoroverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulesnetworkingtigeraoperatoroverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulesnetworkingtigeraoperatoroverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulesnetworkingtigeraoperatoroverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.networking.tigeraOperator.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.networking.tigeraOperator.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.networking.tigeraOperator.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.networking.tigeraOperator.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.networking.type

### Description

The type of networking to use, either ***none***, ***calico*** or ***cilium***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"none"`  |
|`"calico"`|
|`"cilium"`|

## .spec.distribution.modules.policy

### Properties

| Property                                               | Type     | Required |
|:-------------------------------------------------------|:---------|:---------|
| [gatekeeper](#specdistributionmodulespolicygatekeeper) | `object` | Optional |
| [kyverno](#specdistributionmodulespolicykyverno)       | `object` | Optional |
| [overrides](#specdistributionmodulespolicyoverrides)   | `object` | Optional |
| [type](#specdistributionmodulespolicytype)             | `string` | Required |

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

| Value    |
|:---------|
|`"deny"`  |
|`"dryrun"`|
|`"warn"`  |

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

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.policy.gatekeeper.overrides.tolerations

### Properties

| Property                                                                         | Type     | Required |
|:---------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulespolicygatekeeperoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulespolicygatekeeperoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulespolicygatekeeperoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulespolicygatekeeperoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.policy.gatekeeper.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.policy.gatekeeper.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.policy.gatekeeper.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.policy.gatekeeper.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.policy.kyverno

### Properties

| Property                                                                                          | Type      | Required |
|:--------------------------------------------------------------------------------------------------|:----------|:---------|
| [additionalExcludedNamespaces](#specdistributionmodulespolicykyvernoadditionalexcludednamespaces) | `array`   | Optional |
| [installDefaultPolicies](#specdistributionmodulespolicykyvernoinstalldefaultpolicies)             | `boolean` | Required |
| [overrides](#specdistributionmodulespolicykyvernooverrides)                                       | `object`  | Optional |
| [validationFailureAction](#specdistributionmodulespolicykyvernovalidationfailureaction)           | `string`  | Required |

## .spec.distribution.modules.policy.kyverno.additionalExcludedNamespaces

### Description

This parameter adds namespaces to Kyverno's exemption list, so it will not enforce the constraints on them.

## .spec.distribution.modules.policy.kyverno.installDefaultPolicies

### Description

If true, the default policies will be installed

## .spec.distribution.modules.policy.kyverno.overrides

### Properties

| Property                                                                   | Type     | Required |
|:---------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulespolicykyvernooverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulespolicykyvernooverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.policy.kyverno.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.policy.kyverno.overrides.tolerations

### Properties

| Property                                                                      | Type     | Required |
|:------------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulespolicykyvernooverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulespolicykyvernooverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulespolicykyvernooverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulespolicykyvernooverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.policy.kyverno.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.policy.kyverno.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.policy.kyverno.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.policy.kyverno.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.policy.kyverno.validationFailureAction

### Description

The validation failure action to use for the kyverno module

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value     |
|:----------|
|`"audit"`  |
|`"enforce"`|

## .spec.distribution.modules.policy.overrides

### Properties

| Property                                                            | Type     | Required |
|:--------------------------------------------------------------------|:---------|:---------|
| [ingresses](#specdistributionmodulespolicyoverridesingresses)       | `object` | Optional |
| [nodeSelector](#specdistributionmodulespolicyoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulespolicyoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.policy.overrides.ingresses

## .spec.distribution.modules.policy.overrides.nodeSelector

### Description

The node selector to use to place the pods for the security module

## .spec.distribution.modules.policy.overrides.tolerations

### Properties

| Property                                                               | Type     | Required |
|:-----------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulespolicyoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulespolicyoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulespolicyoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulespolicyoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the monitoring module

## .spec.distribution.modules.policy.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.policy.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.policy.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.policy.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.policy.type

### Description

The type of security to use, either ***none***, ***gatekeeper*** or ***kyverno***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value        |
|:-------------|
|`"none"`      |
|`"gatekeeper"`|
|`"kyverno"`   |

## .spec.distribution.modules.tracing

### Properties

| Property                                              | Type     | Required |
|:------------------------------------------------------|:---------|:---------|
| [minio](#specdistributionmodulestracingminio)         | `object` | Optional |
| [overrides](#specdistributionmodulestracingoverrides) | `object` | Optional |
| [tempo](#specdistributionmodulestracingtempo)         | `object` | Optional |
| [type](#specdistributionmodulestracingtype)           | `string` | Required |

## .spec.distribution.modules.tracing.minio

### Properties

| Property                                                       | Type     | Required |
|:---------------------------------------------------------------|:---------|:---------|
| [overrides](#specdistributionmodulestracingminiooverrides)     | `object` | Optional |
| [rootUser](#specdistributionmodulestracingminiorootuser)       | `object` | Optional |
| [storageSize](#specdistributionmodulestracingminiostoragesize) | `string` | Optional |

## .spec.distribution.modules.tracing.minio.overrides

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulestracingminiooverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulestracingminiooverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.tracing.minio.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.tracing.minio.overrides.tolerations

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulestracingminiooverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulestracingminiooverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulestracingminiooverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulestracingminiooverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.tracing.minio.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.tracing.minio.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.tracing.minio.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.tracing.minio.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.tracing.minio.rootUser

### Properties

| Property                                                         | Type     | Required |
|:-----------------------------------------------------------------|:---------|:---------|
| [password](#specdistributionmodulestracingminiorootuserpassword) | `string` | Optional |
| [username](#specdistributionmodulestracingminiorootuserusername) | `string` | Optional |

## .spec.distribution.modules.tracing.minio.rootUser.password

### Description

The password for the minio root user

## .spec.distribution.modules.tracing.minio.rootUser.username

### Description

The username for the minio root user

## .spec.distribution.modules.tracing.minio.storageSize

### Description

The storage size for the minio pods

## .spec.distribution.modules.tracing.overrides

### Properties

| Property                                                             | Type     | Required |
|:---------------------------------------------------------------------|:---------|:---------|
| [ingresses](#specdistributionmodulestracingoverridesingresses)       | `object` | Optional |
| [nodeSelector](#specdistributionmodulestracingoverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulestracingoverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.tracing.overrides.ingresses

## .spec.distribution.modules.tracing.overrides.nodeSelector

### Description

The node selector to use to place the pods for the security module

## .spec.distribution.modules.tracing.overrides.tolerations

### Properties

| Property                                                                | Type     | Required |
|:------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulestracingoverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulestracingoverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulestracingoverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulestracingoverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the monitoring module

## .spec.distribution.modules.tracing.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.tracing.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.tracing.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.tracing.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.tracing.tempo

### Properties

| Property                                                                 | Type     | Required |
|:-------------------------------------------------------------------------|:---------|:---------|
| [backend](#specdistributionmodulestracingtempobackend)                   | `string` | Optional |
| [externalEndpoint](#specdistributionmodulestracingtempoexternalendpoint) | `object` | Optional |
| [overrides](#specdistributionmodulestracingtempooverrides)               | `object` | Optional |
| [retentionTime](#specdistributionmodulestracingtemporetentiontime)       | `string` | Optional |

## .spec.distribution.modules.tracing.tempo.backend

### Description

The backend for the tempo pods, must be ***minio*** or ***externalEndpoint***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"minio"`           |
|`"externalEndpoint"`|

## .spec.distribution.modules.tracing.tempo.externalEndpoint

### Properties

| Property                                                                               | Type      | Required |
|:---------------------------------------------------------------------------------------|:----------|:---------|
| [accessKeyId](#specdistributionmodulestracingtempoexternalendpointaccesskeyid)         | `string`  | Optional |
| [bucketName](#specdistributionmodulestracingtempoexternalendpointbucketname)           | `string`  | Optional |
| [endpoint](#specdistributionmodulestracingtempoexternalendpointendpoint)               | `string`  | Optional |
| [insecure](#specdistributionmodulestracingtempoexternalendpointinsecure)               | `boolean` | Optional |
| [secretAccessKey](#specdistributionmodulestracingtempoexternalendpointsecretaccesskey) | `string`  | Optional |

## .spec.distribution.modules.tracing.tempo.externalEndpoint.accessKeyId

### Description

The access key id of the external tempo backend

## .spec.distribution.modules.tracing.tempo.externalEndpoint.bucketName

### Description

The bucket name of the external tempo backend

## .spec.distribution.modules.tracing.tempo.externalEndpoint.endpoint

### Description

The endpoint of the external tempo backend

## .spec.distribution.modules.tracing.tempo.externalEndpoint.insecure

### Description

If true, the external tempo backend will not use tls

## .spec.distribution.modules.tracing.tempo.externalEndpoint.secretAccessKey

### Description

The secret access key of the external tempo backend

## .spec.distribution.modules.tracing.tempo.overrides

### Properties

| Property                                                                  | Type     | Required |
|:--------------------------------------------------------------------------|:---------|:---------|
| [nodeSelector](#specdistributionmodulestracingtempooverridesnodeselector) | `object` | Optional |
| [tolerations](#specdistributionmodulestracingtempooverridestolerations)   | `array`  | Optional |

## .spec.distribution.modules.tracing.tempo.overrides.nodeSelector

### Description

The node selector to use to place the pods for the minio module

## .spec.distribution.modules.tracing.tempo.overrides.tolerations

### Properties

| Property                                                                     | Type     | Required |
|:-----------------------------------------------------------------------------|:---------|:---------|
| [effect](#specdistributionmodulestracingtempooverridestolerationseffect)     | `string` | Required |
| [key](#specdistributionmodulestracingtempooverridestolerationskey)           | `string` | Required |
| [operator](#specdistributionmodulestracingtempooverridestolerationsoperator) | `string` | Optional |
| [value](#specdistributionmodulestracingtempooverridestolerationsvalue)       | `string` | Optional |

### Description

The tolerations that will be added to the pods for the cert-manager module

## .spec.distribution.modules.tracing.tempo.overrides.tolerations.effect

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value              |
|:-------------------|
|`"NoSchedule"`      |
|`"PreferNoSchedule"`|
|`"NoExecute"`       |

## .spec.distribution.modules.tracing.tempo.overrides.tolerations.key

### Description

The key of the toleration

## .spec.distribution.modules.tracing.tempo.overrides.tolerations.operator

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value    |
|:---------|
|`"Exists"`|
|`"Equal"` |

## .spec.distribution.modules.tracing.tempo.overrides.tolerations.value

### Description

The value of the toleration

## .spec.distribution.modules.tracing.tempo.retentionTime

### Description

The retention time for the tempo pods

## .spec.distribution.modules.tracing.type

### Description

The type of tracing to use, either ***none*** or ***tempo***

### Constraints

**enum**: the value of this property must be equal to one of the following values:

| Value   |
|:--------|
|`"none"` |
|`"tempo"`|

## .spec.distributionVersion

### Constraints

**minimum length**: the minimum number of characters for this string is: `1`

## .spec.plugins

### Properties

| Property                           | Type     | Required |
|:-----------------------------------|:---------|:---------|
| [helm](#specpluginshelm)           | `object` | Optional |
| [kustomize](#specpluginskustomize) | `array`  | Optional |

## .spec.plugins.helm

### Properties

| Property                                     | Type    | Required |
|:---------------------------------------------|:--------|:---------|
| [releases](#specpluginshelmreleases)         | `array` | Optional |
| [repositories](#specpluginshelmrepositories) | `array` | Optional |

## .spec.plugins.helm.releases

### Properties

| Property                                       | Type     | Required |
|:-----------------------------------------------|:---------|:---------|
| [chart](#specpluginshelmreleaseschart)         | `string` | Required |
| [name](#specpluginshelmreleasesname)           | `string` | Required |
| [namespace](#specpluginshelmreleasesnamespace) | `string` | Required |
| [set](#specpluginshelmreleasesset)             | `array`  | Optional |
| [values](#specpluginshelmreleasesvalues)       | `array`  | Optional |
| [version](#specpluginshelmreleasesversion)     | `string` | Optional |

## .spec.plugins.helm.releases.chart

### Description

The chart of the release

## .spec.plugins.helm.releases.name

### Description

The name of the release

## .spec.plugins.helm.releases.namespace

### Description

The namespace of the release

## .spec.plugins.helm.releases.set

### Properties

| Property                                  | Type     | Required |
|:------------------------------------------|:---------|:---------|
| [name](#specpluginshelmreleasessetname)   | `string` | Required |
| [value](#specpluginshelmreleasessetvalue) | `string` | Required |

## .spec.plugins.helm.releases.set.name

### Description

The name of the set

## .spec.plugins.helm.releases.set.value

### Description

The value of the set

## .spec.plugins.helm.releases.values

### Description

The values of the release

## .spec.plugins.helm.releases.version

### Description

The version of the release

## .spec.plugins.helm.repositories

### Properties

| Property                                 | Type     | Required |
|:-----------------------------------------|:---------|:---------|
| [name](#specpluginshelmrepositoriesname) | `string` | Required |
| [url](#specpluginshelmrepositoriesurl)   | `string` | Required |

## .spec.plugins.helm.repositories.name

### Description

The name of the repository

## .spec.plugins.helm.repositories.url

### Description

The url of the repository

## .spec.plugins.kustomize

### Properties

| Property                              | Type     | Required |
|:--------------------------------------|:---------|:---------|
| [folder](#specpluginskustomizefolder) | `string` | Required |
| [name](#specpluginskustomizename)     | `string` | Required |

## .spec.plugins.kustomize.folder

### Description

The folder of the kustomize plugin

## .spec.plugins.kustomize.name

### Description

The name of the kustomize plugin

