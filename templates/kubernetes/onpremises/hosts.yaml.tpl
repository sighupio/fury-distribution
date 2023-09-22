{{- $dnsZone := .spec.kubernetes.dnsZone -}}
{{- $controlPlaneAddress := .spec.kubernetes.controlPlaneAddress -}}

all:
  children:
    {{- if .spec.kubernetes.loadBalancers.enabled }}
    haproxy:
      hosts:
        {{- range $h := .spec.kubernetes.loadBalancers.hosts }}
        {{ $h.name }}:
          ansible_host: "{{ $h.ip }}"
          kubernetes_hostname: "{{ $h.name }}.{{ $dnsZone }}"
        {{- end }}
      vars:
        keepalived_cluster: {{ .spec.kubernetes.loadBalancers.keepalived.enabled }}
        keepalived_interface: "{{ .spec.kubernetes.loadBalancers.keepalived.interface }}"
        keepalived_ip: "{{ .spec.kubernetes.loadBalancers.keepalived.ip }}"
        keepalived_virtual_router_id: "{{ .spec.kubernetes.loadBalancers.keepalived.virtualRouterId }}"
        keepalived_passphrase: "{{ .spec.kubernetes.loadBalancers.keepalived.passphrase }}"
    {{- end }}
    master:
      hosts:
        {{- $etcdInitialCluster := list }}
        {{- range $h := .spec.kubernetes.masters.hosts }}
        {{- $etcdUri := print $h.name "=https://" $h.name "." $dnsZone ":2380" }}
        {{- $etcdInitialCluster = append $etcdInitialCluster $etcdUri }}
        {{ $h.name }}:
          ansible_host: "{{ $h.ip }}"
          kubernetes_apiserver_advertise_address: "{{ $h.ip }}"
          kubernetes_hostname: "{{ $h.name }}.{{ $dnsZone }}"
        {{- end }}
      vars:
        dns_zone: "{{ $dnsZone }}"
        etcd_initial_cluster: "{{ $etcdInitialCluster | join "," }}"
        kubernetes_cluster_name: "{{ .metadata.name }}"
        kubernetes_control_plane_address: "{{ $controlPlaneAddress }}"
        kubernetes_pod_cidr: "{{ .spec.kubernetes.podCidr }}"
        kubernetes_svc_cidr: "{{ .spec.kubernetes.svcCidr }}"
    nodes:
      children:
        {{- range $n := .spec.kubernetes.nodes }}
        {{ $n.name }}:
          hosts:
          {{- range $h := $n.hosts }}
            {{ $h.name }}:
              ansible_host: "{{ $h.ip }}"
              kubernetes_hostname: "{{ $h.name }}.{{ $dnsZone }}"
          {{- end }}
          vars:
            kubernetes_role: "worker"
            kubernetes_control_plane_address: "{{ $controlPlaneAddress }}"
            kubernetes_taints:
              {{ $n.taints | toYaml | indent 14 | trim }}
      {{- end }}
    ungrouped: {}
  vars:
    ansible_python_interpreter: python3
    ansible_ssh_private_key_file: "{{ .spec.kubernetes.ssh.keyPath }}"
    ansible_user: "{{ .spec.kubernetes.ssh.username }}"
    kubernetes_kubeconfig_path: ./
    kubernetes_version: "{{ .kubernetes.version }}"
    {{- if (index .spec.kubernetes "proxy") }}
    http_proxy: "{{ .spec.kubernetes.proxy.http }}"
    https_proxy: "{{ .spec.kubernetes.proxy.https }}"
    no_proxy: "{{ .spec.kubernetes.proxy.noProxy }}"
    {{- end }}