# Ingress Module Network Policies

## Components
- Nginx Ingress Controller (single/dual mode)
- Cert-manager
- Forecastle

## Namespaces
- ingress-nginx
- cert-manager

## Network Policies List

### Cert-manager
- deny-all
- all-egress-kube-dns
- cert-manager-egress-kube-apiserver
- cert-manager-webhook-ingress-kube-apiserver
- cert-manager-egress-https
- cert-manager-ingress-prometheus-metrics
- acme-http-solver-ingress-lets-encrypt

### Ingress-nginx
- deny-all
- all-egress-kube-dns
- forecastle-ingress-nginx
- forecastle-egress-kube-apiserver
- nginx-egress-all
- all-ingress-nginx
- nginx-ingress-prometheus-metrics

## Configurations
- [Single Nginx](single.md)
- [Dual Nginx](dual.md)
