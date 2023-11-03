# Kubernetes Fury Distribution NEXT Upgrade Guide

**TODO: replace OLD and NEXT with the actual versions.**

This guide describes the steps to follow to upgrade the Kubernetes Fury Distribution (KFD) from OLD to NEXT.

If you are running a custom set of modules, or different versions than the ones included with each release of KFD, please refer to each module's release notes.

Notice that the guide will not cover changes related to the cloud provider, ingresses or pod placement changes. Only changes related to KFD and its modules.

> ⛔️ **IMPORTANT**
> we strongly recommend reading the whole guide before starting the upgrade process to identify possible blockers.

## Upgrade procedure

### 1. Using furyctl

Change `.spec.distributionVersion` on your `furyctl.yaml` file with the new `NEXT`.

Validate the schema using the new `NEXT` `furyctl` version:

```bash
furyctl validate config
```

Update the cluster IaC files and folders with:

```bash
furyctl apply --config /path/to/furyctl.yaml --dry-run
```

Enter the cluster's infrastructure terraform folder located at `~/.furyctl/<CLUSTER_NAME>/infrastructure/terraform`,
and then run the following commands:

```bash
# Ensure all terraform modules are up to date
terraform init -upgrade

# Check out the changes, take note of the bucket name
terraform plan

# Export the bucket name as an environment variable
export BUCKET_NAME="<BUCKET_NAME>"

# Import the new bits of terraform state brought by the new version of the eks installer
terraform import module.vpn[0].aws_s3_bucket_ownership_controls.furyagent "${BUCKET_NAME}"
terraform import module.vpn[0].aws_s3_bucket_server_side_encryption_configuration.furyagent "${BUCKET_NAME}"
terraform import module.vpn[0].aws_s3_bucket_versioning.furyagent "${BUCKET_NAME}"

# Apply the remaining changes
terraform apply
```

Run furyctl again to apply any remaning changes:

```bash
furyctl apply --config /path/to/furyctl.yaml
```

### 2. Using KFD directly

There are no changes on the modules since the version OLD.
