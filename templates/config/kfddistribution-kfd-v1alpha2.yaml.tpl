# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

---
apiVersion: kfd.sighup.io/v1alpha2
kind: KFDDistribution
metadata:
  # The name of the cluster, will be also used as a prefix for all the other resources created
  name: {{.Name}}
spec:
  # This value defines which KFD version will be installed and in consequence the Kubernetes version to use to create the cluster,
  # it supports git tags and branches
  distributionVersion: {{.DistributionVersion}}
  # This section describes how the KFD distribution will be installed
  distribution:
    # This common configuration will be applied to all the packages that will be installed in the cluster
    # common:
    #   # The node selector to use to place the pods for all the KFD packages
    #   nodeSelector:
    #     node.kubernetes.io/role: infra
    #   # The tolerations that will be added to the pods for all the KFD packages
    #   tolerations:
    #     - effect: NoSchedule
    #       key: node.kubernetes.io/role
    #       value: infra
    # This section contains all the configurations for all the KFD core modules
    modules:
      networking:
        # this type defines if we need to install the networking in the cluster, type available: none, cilium, calico
        type: none
      # This section contains all the configurations for the ingress module
      ingress:
        # This optional key is used to override automatic parameters
        #overrides:
        #  # This key is used to override the spec.distribution.common.nodeSelector settings. Set to a custom value or use an empty object {} to not add the common node selector.
        #  nodeSelector: null
        #  # This key is used to override the spec.distribution.common.tolerations settings. Set to a custom value or use an empty object {} to not add the common tolerations.
        #  tolerations: null
        #  # This key is used to override some parameters on the ingresses managed by this module
        #  ingresses:
        #    forecastle:
        #      # if authentication is globally enabled, it can be disabled for this ingress.
        #      disableAuth: false
        #      # the host can be overridden, by default is directory.{.spec.distribution.modules.ingress.baseDomain}
        #      host: ""
        #      # the ingressClass can be overridden if needed
        #      ingressClass: ""
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
            # the custom solvers configurations
            # solvers:
            #   - http01:
            #       ingress:
            #         class: nginx
      # This section contains all the configurations for the logging module
      logging:
        # This optional key is used to override automatic parameters
        #overrides:
        #  # This key is used to override the spec.distribution.common.nodeSelector setting. Set to a custom value or use an empty object {} to not add the common node selector.
        #  nodeSelector: null
        #  # This key is used to override the spec.distribution.common.tolerations setting. Set to a custom value or use an empty object {} to not add the common tolerations.
        #  tolerations: null
        #  # This key is used to override some parameters on the ingresses managed by this module
        #  ingresses:
        #    opensearchDashboards:
        #      # if authentication is globally enabled, it can be disabled for this ingress.
        #      disableAuth: false
        #      # the host can be overridden, by default is opensearch-dashboards.{.spec.distribution.modules.ingress.baseDomain}
        #      host: ""
        #      # the ingressClass can be overridden if needed
        #      ingressClass: ""
        #    cerebro:
        #      # if authentication is globally enabled, it can be disabled for this ingress.
        #      disableAuth: false
        #      # the host can be overridden, by default is cerebro.{.spec.distribution.modules.ingress.baseDomain}
        #      host: ""
        #      # the ingressClass can be overridden if needed
        #      ingressClass: ""
        #    minio:
        #      # if authentication is globally enabled, it can be disabled for this ingress.
        #      disableAuth: false
        #      # the host can be overridden, by default is minio.{.spec.distribution.modules.ingress.baseDomain}
        #      host: ""
        #      # the ingressClass can be overridden if needed
        #      ingressClass: ""
        # can be opensearch or loki or none, with none, nothing from the logging module will be installed
        type: opensearch
        # configurations for the opensearch package
        opensearch:
          # the type of opensearch to install, can be single or triple
          type: single
          ## optional settings to override requests and limits
          #resources:
          #  requests:
          #    cpu: ""
          #    memory: ""
          #  limits:
          #    cpu: ""
          #    memory: ""
          # the PVC size used by opensearch, for each pod
          storageSize: "150Gi"
        # configurations for the minio-ha package
        minio:
          # the PVC size for each minio disk, 6 disks total
          storageSize: "20Gi"
        # configurations for the loki package
        # loki:
          ## optional settings to override requests and limits, common for each component
          #resources:
          #  requests:
          #    cpu: ""
          #    memory: ""
          #  limits:
          #    cpu: ""
          #    memory: ""
      # This section contains all the configurations for the monitoring module
      monitoring:
        # This optional key is used to override automatic parameters
        #overrides:
        #  # This key is used to override the spec.distribution.common.nodeSelector setting. Set to a custom value or use an empty object {} to not add the common node selector.
        #  nodeSelector: null
        #  # This key is used to override the spec.distribution.common.tolerations setting. Set to a custom value or use an empty object {} to not add the common tolerations.
        #  tolerations: null
        #  # This key is used to override some parameters on the ingresses managed by this module
        #  ingresses:
        #    prometheus:
        #      # if authentication is globally enabled, it can be disabled for this ingress.
        #      disableAuth: false
        #      # the host can be overridden, by default is prometheus.{.spec.distribution.modules.ingress.baseDomain}
        #      host: ""
        #      # the ingressClass can be overridden if needed
        #      ingressClass: ""
        #    alertmanager:
        #      # if authentication is globally enabled, it can be disabled for this ingress.
        #      disableAuth: false
        #      # the host can be overridden, by default is alertmanager.{.spec.distribution.modules.ingress.baseDomain}
        #      host: ""
        #      # the ingressClass can be overridden if needed
        #      ingressClass: ""
        #    grafana:
        #      # if authentication is globally enabled, it can be disabled for this ingress.
        #      disableAuth: false
        #      # the host can be overridden, by default is grafana.{.spec.distribution.modules.ingress.baseDomain}
        #      host: ""
        #      # the ingressClass can be overridden if needed
        #      ingressClass: ""
        # configurations for the prometheus package
        #prometheus:
        #  # optional settings to override requests and limits
        #  resources:
        #    requests:
        #      cpu: ""
        #      memory: ""
        #    limits:
        #      cpu: ""
        #      memory: ""
        # configurations for the alertmanager package
        alertmanager:
          # The webhook url to send deadman switch monitoring, for example to use with healthchecks.io
          deadManSwitchWebhookUrl: ""
          # The slack webhook url to send alerts
          slackWebhookUrl: https://slack.com
      # This section contains all the configurations for the policy (opa) module
      policy:
        # type can be gatekeeper or none
        type: gatekeeper
        # This optional key is used to override automatic parameters
        #overrides:
        #  # This key is used to override the spec.distribution.common.nodeSelector setting. Set to a custom value or use an empty object {} to not add the common node selector.
        #  nodeSelector: null
        #  # This key is used to override the spec.distribution.common.tolerations setting. Set to a custom value or use an empty object {} to not add the common tolerations.
        #  tolerations: null
        #  # This key is used to override some parameters on the ingresses managed by this module
        #  ingresses:
        #    gpm:
        #      # if authentication is globally enabled, it can be disabled for this ingress.
        #      disableAuth: false
        #      # the host can be overridden, by default is gpm.{.spec.distribution.modules.ingress.baseDomain}
        #      host: ""
        #      # the ingressClass can be overridden if needed
        #      ingressClass: ""
        # configurations for the gatekeeper package
        gatekeeper:
          # This parameter adds namespaces to Gatekeeper's exemption list, so it will not enforce the constraints on them.
          additionalExcludedNamespaces: []
      # This section contains all the configurations for the Disaster Recovery module
      dr:
        # type can be none or on-premises
        type: on-premises
        # Configurations for the velero package
        velero: {}
        # This optional key is used to override automatic parameters
        #overrides:
        #  # This key is used to override the spec.distribution.common.nodeSelector setting. Set to a custom value or use an empty object {} to not add the common node selector.
        #  nodeSelector: null
        #  # This key is used to override the spec.distribution.common.tolerations setting. Set to a custom value or use an empty object {} to not add the common tolerations.
        #  tolerations: null
      # This section contains all the configurations for the auth module
      auth:
        # This optional key is used to override automatic parameters
        #overrides:
        #  # This key is used to override the spec.distribution.common.nodeSelector setting. Set to a custom value or use an empty object {} to not add the common node selector.
        #  nodeSelector: null
        #  # This key is used to override the spec.distribution.common.tolerations setting. Set to a custom value or use an empty object {} to not add the common tolerations.
        #  tolerations: null
        #  ingresses:
        #    pomerium:
        #      # the host can be overridden, by default is pomerium.{.spec.distribution.modules.ingress.baseDomain}
        #      host: ""
        #      # the ingressClass can be overridden if needed
        #      ingressClass: ""
        #    dex:
        #      # the host can be overridden, by default is login.{.spec.distribution.modules.ingress.baseDomain}
        #      host: ""
        #      # the ingressClass can be overridden if needed
        #      ingressClass: ""
        provider:
          # The authentication type used for the infrastructure ingresses (all the ingress for the distribution) can be none, basicAuth, sso
          type: none
          # configuration for the basicAuth if .spec.distribution.modules.auth.provider.type is basicAuth
          basicAuth:
            # The username
            username: admin
            # The password
            password: "{env://KFD_BASIC_AUTH_PASSWORD}"
        # The base domain used for all the auth ingresses, if in the nginx dual configuration, it should be the same as the .spec.distribution.modules.ingress.dns.public.name zone
        baseDomain: example.dev
        # Configuration for the pomerium package, used only if .spec.distribution.modules.auth.provider.type is sso
        #pomerium:
        #  # Additional policy configuration
        #  policy: |
        #    - from: https://myapp.example.dev
        #      to: http://myapp.svc.cluster.local:8000
        #      cors_allow_preflight: true
        #      timeout: 30s
        #  # Secrets configurations for pomerium and dex (pomerium connect to dex proxy for the SSO process)
        #  secrets:
        #    COOKIE_SECRET: "{env://KFD_AUTH_POMERIUM_COOKIE_SECRET}"
        #    IDP_CLIENT_SECRET: "{env://KFD_AUTH_POMERIUM_IDP_CLIENT_SECRET}"
        #    SHARED_SECRET: "{env://KFD_AUTH_POMERIUM_SHARED_SECRET}"
        ## Configuration for the pomerium package, used only if .spec.distribution.modules.auth.provider.type is sso
        #dex:
        #  # Dex connectors configuration
        #  connectors:
        #    - type: github
        #      id: github
        #      name: GitHub
        #      config:
        #        clientID: "{env://KFD_AUTH_DEX_CONNECTORS_GITHUB_CLIENT_ID}"
        #        clientSecret: "{env://KFD_AUTH_DEX_CONNECTORS_GITHUB_CLIENT_SECRET}"
        #        redirectURI: https://login.example.dev/callback
        #        loadAllGroups: false
        #        teamNameField: slug
        #        useLoginAsID: false
    # Custom Patches to add or override fields in the generated manifests
    #customPatches:
    #  configMapGenerator:
    #  - name: a-configmap
    #    files:
    #      - /path/to/config.example
    #  - name: b-configmap
    #    envs:
    #      - /path/to/envs.env
    #  patches:
    #  - target:
    #      group: ""
    #      version: v1
    #      kind: Service
    #      name: cluster-autoscaler
    #      namespace: kube-system
    #    path: /path/to/patch.yaml
    #  patchesStrategicMerge:
    #  - |
    #    ---
    #    apiVersion: v1
    #    kind: Service
    #    metadata:
    #      labels:
    #        label1: value1
    #      name: cluster-autoscaler
    #      namespace: kube-system
    #  secretGenerator:
    #  - name: a-secret
    #    files:
    #      - /path/to/config.example
    #  - name: b-secret
    #    envs:
    #      -  /path/to/envs.env
  # Plugins to be installed
  # plugins:
  #   # Helm releases and repositories to be installed
  #   helm:
  #     repositories:
  #       - name: prometheus-community
  #         url: https://prometheus-community.github.io/helm-charts
  #     releases:
  #       - name: prometheus
  #         namespace: prometheus
  #         chart: prometheus-community/prometheus
  #         version: "24.3.0"
  #         set:
  #           - name: server.replicaCount
  #             value: 2
  #         values:
  #           - path/to/values.yaml
  #   # Kustomize projects to be installed
  #   kustomize:
  #     - name: kustomize-project
  #       folder: path/to/kustomize/project
