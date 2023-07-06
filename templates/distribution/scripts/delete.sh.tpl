#!/usr/bin/env sh

set -e

kustomizebin="{{ .paths.kustomize }}"
kubectlbin="{{ .paths.kubectl }}"
yqbin="{{ .paths.yq }}"

if [ "$1" = "true" ]; then
  dryrun="--dry-run=server"
else
  dryrun=""
fi

if [ -n "$2" ]; then
  kubeconfig="--kubeconfig=$2"
else
  kubeconfig=""
fi

kubectlcmd="$kubectlbin $dryrun $kubeconfig"

$kustomizebin build --load_restrictor LoadRestrictionsNone . > out.yaml

# list generated with: kustomize build . | yq 'select(.kind == "CustomResourceDefinition") | .spec.group' | sort | uniq
{{- if eq .spec.distribution.common.provider.type "eks" }}
< out.yaml $yqbin 'select(.kind == "Ingress")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -
{{- if eq .spec.distribution.modules.ingress.dns.public.create true }}
publicHostedZone="$(aws route53 list-hosted-zones --query "HostedZones[*].[Id,Name]" --output text | grep '\t{{.spec.distribution.modules.ingress.dns.public.name}}.$' | awk '{print $1}' | cut -d'/' -f3)"
{{- end}}
{{- if eq .spec.distribution.modules.ingress.dns.private.create true }}
privateHostedZone="$(aws route53 list-hosted-zones --query "HostedZones[*].[Id,Name]" --output text | grep '\t{{.spec.distribution.modules.ingress.dns.private.name}}.$' | awk '{print $1}' | cut -d'/' -f3)"
{{- end}}

retry_counter=0

while [ $retry_counter -le 10 ]; do
  if [ -n "$publicHostedZone" ]; then
    publicRecords="$(aws route53 list-resource-record-sets --hosted-zone-id "$publicHostedZone" --query "ResourceRecordSets[?Type != 'NS' && Type != 'SOA'].Type" --output text)"
  fi

  if [ -n "$privateHostedZone" ]; then
    privateRecords="$(aws route53 list-resource-record-sets --hosted-zone-id "$privateHostedZone" --query "ResourceRecordSets[?Type != 'NS' && Type != 'SOA'].Type" --output text)"
  fi

  if [ -z "$publicRecords" ] && [ -z "$privateRecords" ]; then
    break
  fi

  if [ $retry_counter -eq 10 ]; then
    echo "Timeout waiting for DNS records to be deleted."
    exit 1
  fi

  echo "Waiting for DNS records to be deleted..."
  sleep 20

  retry_counter=$((retry_counter+1))
done

{{- end }}
echo "Ingresses deleted"
< out.yaml $yqbin 'select(.apiVersion == "acme.cert-manager.io/*" or .apiVersion == "cert-manager.io/*" or .apiVersion == "config.gatekeeper.sh/*" or .apiVersion == "expansion.gatekeeper.sh/*" or .apiVersion == "externaldata.gatekeeper.sh/*" or .apiVersion == "forecastle.stakater.com/*" or .apiVersion == "logging-extensions.banzaicloud.io/*" or .apiVersion == "logging.banzaicloud.io/*" or .apiVersion == "monitoring.coreos.com/*" or .apiVersion == "mutations.gatekeeper.sh/*" or .apiVersion == "status.gatekeeper.sh/*" or .apiVersion == "templates.gatekeeper.sh/*" or .apiVersion == "velero.io/*")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -
echo "CRDs deleted"
< out.yaml $yqbin 'select(.kind == "StatefulSet")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f -
echo "StatefulSets deleted"
$kubectlcmd delete -n logging deployments -l app.kubernetes.io/instance=loki-distributed
echo "Logging loki deployments deleted"
$kubectlcmd delete --ignore-not-found --wait --timeout=180s -n monitoring --all persistentvolumeclaims
echo "Monitoring PVCs deleted"
$kubectlcmd delete --ignore-not-found --wait --timeout=180s -n logging --all persistentvolumeclaims
echo "Logging PVCs deleted"
echo "Waiting 3 minutes"
sleep 180
< out.yaml $yqbin 'select(.kind == "Service" and .spec.type == "LoadBalancer")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f - || true
echo "LoadBalancer Services deleted"
< out.yaml $yqbin 'select(.kind != "CustomResourceDefinition")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f - || true
echo "Resources deleted"
< out.yaml $yqbin 'select(.kind == "CustomResourceDefinition")' | $kubectlcmd delete --ignore-not-found --wait --timeout=180s -f - || true
echo "CRDs deleted"
