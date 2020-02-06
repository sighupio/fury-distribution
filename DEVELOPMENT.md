# Fury Distribution

## Pending work

- Document it
- Document how to extend it
- Extend furyctl to orchestrate the installation:
  - Opcional CNI as we can install this distribution on top of Cloud Providers
  - Optional HA ElasticSearch deployment
  - Optional Dual Ingress
    - Be careful with the cert-manager cluster-issuer
  - Optional Velero Cloud (aws, gke, aks)
    - If choosen a cloud DR deployment, a terraform module has to be instantiate to create "cloud-credentials" and 
    VolumeSnapshotsLocation/BackupLocation CRDs from the output of the module.
