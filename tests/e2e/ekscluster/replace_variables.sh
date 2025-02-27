#!/bin/bash
set -e
DISTRIBUTION_VERSION=""
CLUSTER_NAME=""
FURYCTL_YAML=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -d|--distribution-version)
      DISTRIBUTION_VERSION="$2"
      shift 2
      ;;
    -c|--cluster-name)
      CLUSTER_NAME="$2"
      shift 2
      ;;
    -f|--furyctl-yaml)
      FURYCTL_YAML="$2"
      shift 2
      ;;
    -h|--help)
      echo "Usage: $0 [options]"
      echo "Options:"
      echo "  -d, --distribution-version   Specify the distribution version"
      echo "  -c, --cluster-name           Specify the cluster name"
      echo "  -f, --furyctl-yaml           Specify the furyctl YAML file path"
      echo "  -h, --help                   Show this help message"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use -h or --help for usage information"
      exit 1
      ;;
  esac
done

# Check if all required arguments are provided
if [ -z "$DISTRIBUTION_VERSION" ] || [ -z "$CLUSTER_NAME" ] || [ -z "$FURYCTL_YAML" ]; then
    echo "Error: Missing required arguments"
    echo "Usage: $0 -d <distribution_version> -c <cluster_name> -f <furyctl_yaml>"
    exit 1
fi

yq -eiy ".spec.distributionVersion = \"$DISTRIBUTION_VERSION\"" $FURYCTL_YAML
yq -eiy ".metadata.name = \"$CLUSTER_NAME\"" $FURYCTL_YAML
yq -eiy ".spec.toolsConfiguration.terraform.state.s3.keyPrefix = \"$CLUSTER_NAME\"" $FURYCTL_YAML
yq -eiy ".spec.tags.env = \"$CLUSTER_NAME\"" $FURYCTL_YAML
if [ yq '.spec.distribution.modules.dr.velero.eks | has("bucketName")' $FURYCTL_YAML == 'true' ]; then
  yq -eiy ".spec.distribution.modules.dr.velero.eks.bucketName = \"$CLUSTER_NAME\"" $FURYCTL_YAML
fi