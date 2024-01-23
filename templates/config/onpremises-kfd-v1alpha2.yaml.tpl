# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: kfd.sighup.io/v1alpha2
kind: OnPremises
metadata:
  # The name of the cluster, will be also used as a prefix for all the other resources created
  name: {{.Name}}
spec:
  # This value defines which KFD version will be installed and in consequence the Kubernetes version to use to create the cluster,
  # it supports git tags and branches
  distributionVersion: {{.DistributionVersion}}
  # This section describes how the cluster will be created
  kubernetes:
    pkiFolder: ./pki
    ssh:
      username: johndoe
      keyPath: /youruserpath/.ssh/id_ed25519
    # this zone will be concatenated to the - name on each host to generate kubernetes_hostname in the hosts.yaml file, and also for the etcd initial cluster value
    dnsZone: example.dev
    controlPlaneAddress: control-planelocal.example.dev:6443
    podCidr: 172.16.128.0/17
    svcCidr: 172.16.0.0/17
    proxy:
      http: http://test.example.dev:3128
      https: https://test.example.dev:3128
      noProxy: "localhost,127.0.0.1,172.16.0.0/17,172.16.128.0/17,10.0.0.0/8,.example.dev"
    loadBalancers:
      enabled: true
      hosts:
        - name: haproxy1
          ip: 192.168.1.200
        - name: haproxy2
          ip: 192.168.1.202
      keepalived:
        enabled: true
        interface: eth1
        ip: 192.168.1.201/24
        virtualRouterId: "201"
        passphrase: "123aaaccc321"
      stats:
        username: admin
        password: password
    masters:
      hosts:
        - name: master1 
          ip: 192.168.1.210
        - name: master2
          ip: 192.168.1.220
        - name: master3
          ip: 192.168.1.230
    nodes:
      - name: infra
        hosts:
          - name: infra1
            ip: 192.168.1.100
          - name: infra2
            ip: 192.168.1.101
        taints:
          - key: node.kubernetes.io/role
            value: infra
            effect: NoSchedule
      - name: worker
        hosts:
          - name: worker1
            ip: 192.168.1.104
          - name: worker2
            ip: 192.168.1.105
  # This section describes how the KFD distribution will be installed
  distribution:
    # This common configuration will be applied to all the packages that will be installed in the cluster
    common:
      # The node selector to use to place the pods for all the KFD packages
      nodeSelector:
        node.kubernetes.io/role: infra
      # The tolerations that will be added to the pods for all the KFD packages
      tolerations:
        - effect: NoSchedule
          key: node.kubernetes.io/role
          value: infra
    # This section contains all the configurations for all the KFD core modules
    modules:
      networking:
        # this type defines if we need to install the networking in the cluster, type available: cilium, calico
        type: "calico"
      # This section contains all the configurations for the ingress module
      ingress:
        # the base domain used for all the KFD ingresses, if in the nginx dual configuration, it should be the same as the .spec.distribution.modules.ingress.dns.private.name zone
        baseDomain: internal.example.dev
        # configurations for the nginx ingress controller package
        nginx:
          # type defines if the nginx should be configured as single or dual (internal + external) or none, with none no ingress controller will be deployed and also no ingress resource will be created
          type: dual
          # the tls section defines how the tls for the ingresses should be managed
          tls:
            # provider can be certManager, secret
            provider: certManager
            # if provider is set as secret, this key will be used to create the certificate in the cluster
            # secret:
              # the certificate file content or you can use the file notation to get the content from a file
              # cert: "{file://relative/path/to/ssl.crt}"
              # the key file, a file notation can be used to get the content from a file
              # key: "{file://relative/path/to/ssl.key}"
              # the ca file, a file notation can be used to get the content from a file
              # ca: "{file://relative/path/to/ssl.ca}"
        # configuration for the cert-manager package
        certManager:
          # the configuration for the clusterIssuer that will be created
          clusterIssuer:
            # the name of the clusterIssuer
            name: letsencrypt-fury
            # the email used during issuing procedures
            email: example@sighup.io
            # you can configure the clusterIssuer by specifing type (can be only http01) or custom solvers
            type: http01
      # This section contains all the configurations for the logging module
      logging:
        # can be opensearch or loki or none, with none, nothing from the logging module will be installed
        type: loki
        # configurations for the minio-ha package
        minio:
          # the PVC size for each minio disk, 6 disks total
          storageSize: "20Gi"
        # configurations for the loki package
      # This section contains all the configurations for the monitoring module
      monitoring:
        # can be prometheus or mimir or none, with none, nothing from the monitoring module will be installed
        type: "prometheus"
      # This section contains all the configurations for the tracing module
      tracing:
        # can be tempo or none, with none, nothing from the tracing module will be installed
        type: tempo
        # configurations for the minio-ha package
        minio:
          # the PVC size for each minio disk, 6 disks total
          storageSize: "20Gi"
      # This section contains all the configurations for the policy (opa) module
      policy:
        # type can be gatekeeper, kyverno or none
        type: gatekeeper
        # configurations for the gatekeeper package
        gatekeeper:
          # This parameter adds namespaces to Gatekeeper's exemption list, so it will not enforce the constraints on them.
          additionalExcludedNamespaces: []
          installDefaultPolicies: true
          enforcementAction: deny
      # This section contains all the configurations for the Disaster Recovery module
      dr:
        # type can be none or on-premises
        type: on-premises
        # Configurations for the velero package
        velero: {}
      # This section contains all the configurations for the auth module
      auth:
        provider:
          # The authentication type used for the infrastructure ingresses (all the ingress for the distribution) can be none, basicAuth, sso
          type: none
        # The base domain used for all the auth ingresses, if in the nginx dual configuration, it should be the same as the .spec.distribution.modules.ingress.dns.public.name zone
        baseDomain: example.dev
    # Custom Patches to add or override fields in the generated manifests
    #customPatches: {}
  # Plugins to be installed
  #plugins: {}