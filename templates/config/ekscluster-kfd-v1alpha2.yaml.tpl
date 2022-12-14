# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

apiVersion: kfd.sighup.io/v1alpha2
kind: EKSCluster
metadata:
  name: {{.Name}}
spec:
  distributionVersion: {{.DistributionVersion}}
  toolsConfiguration:
    terraform:
      state:
        s3:
          bucketName: example-bucket
          keyPrefix: example-cluster/
          region: eu-west-1
  region: eu-west-1
  tags:
    env: "example"
    k8s: "example2"
  infrastructure:
    vpc:
      network:
        cidr: 10.1.0.0/16
        subnetsCidrs:
          private:
            - 10.1.0.0/20
            - 10.1.16.0/20
            - 10.1.32.0/20
          public:
            - 10.1.48.0/24
            - 10.1.49.0/24
            - 10.1.50.0/24
      vpn:
        instances: 2
        port: 1194
        instanceType: t3.micro
        diskSize: 50
        operatorName: sighup
        dhParamsBits: 2048
        vpnClientsSubnetCidr: 172.16.0.0/16
        ssh:
          publicKeys:
            - "ssh-ed25519 XYZ"
            - "{file://relative/path/to/ssh.pub}"
          githubUsersName:
            - johndoe
          allowedFromCidrs:
            - 0.0.0.0/0
  kubernetes:
    vpcId: vpc-0123456789abcdef0
    subnetIds:
      - subnet-0123456789abcdef0
      - subnet-0123456789abcdef1
      - subnet-0123456789abcdef2
    apiServerEndpointAccess:
      type: private
      allowedCidrs:
        - 10.1.0.0/16
    nodeAllowedSshPublicKey: "ssh-ed25519 XYZ"
    nodePools:
      - name: worker
        ami:
          id: ami-0123456789abcdef0
          owner: "123456789012"
        size:
          min: 1
          max: 3
        subnetIds:
          - subnet-0123456789abcdef0
          - subnet-0123456789abcdef1
          - subnet-0123456789abcdef2
        instance:
          type: t3.micro
          spot: false
          volumeSize: 50
        attachedTargetGroups:
          - arn:aws:elasticloadbalancing:eu-west-1:123456789012:targetgroup/example-external-nginx/0123456789abcdee
          - arn:aws:elasticloadbalancing:eu-west-1:123456789012:targetgroup/example-internal-nginx/0123456789abcdef
        labels:
          nodepool: worker
          node.kubernetes.io/role: worker
        taints:
          - node.kubernetes.io/role=worker:NoSchedule
        tags:
          k8s.io/cluster-autoscaler/node-template/label/nodepool: "worker"
          k8s.io/cluster-autoscaler/node-template/label/node.kubernetes.io/role: "worker"
        additionalFirewallRules:
          - name: traffic_80_from_172_31_0_0_16
            type: ingress
            cidrBlocks:
              - 172.31.0.0/16
            protocol: TCP
            ports:
              from: 80
              to: 80
            tags: {}
    awsAuth:
      additionalAccounts:
        - "777777777777"
        - "88888888888"
      users:
        - username: "johndoe"
          groups:
            - system:masters
          userarn: "arn:aws:iam::123456789012:user/johndoe"
      roles:
        - username: "example"
          groups:
            - example:masters
          rolearn: "arn:aws:iam::123456789012:role/k8s-example-role"
  distribution:
    common:
      nodeSelector:
        node.kubernetes.io/role: infra
      tolerations:
        - effect: NoSchedule
          key: node.kubernetes.io/role
          value: infra
    modules:
      ingress:
        overrides:
          nodeSelector: null
          tolerations: null
          ingresses:
            forecastle:
              disableAuth: false
              host: ""
              ingressClass: ""
        baseDomain: example.dev
        nginx:
          type: single
          tls:
            provider: certManager
            secret:
              cert: "{file://relative/path/to/ssl.crt}"
              key: "{file://relative/path/to/ssl.key}"
              ca: "{file://relative/path/to/ssl.ca}"
        certManager:
          clusterIssuer:
            name: letsencrypt-fury
            type: http01
        dns:
          public:
            name: "example.dev"
            create: false
          private:
            name: "internal.example.dev"
            vpcId: "vpc-0123456789abcdef0"
      logging:
        overrides:
          nodeSelector: null
          tolerations: null
          ingresses:
            opensearch-dashboards:
              disableAuth: false
              host: ""
              ingressClass: ""
            cerebro:
              disableAuth: false
              host: ""
              ingressClass: ""
        opensearch:
          type: single
          resources:
            requests:
              cpu: ""
              memory: ""
            limits:
              cpu: ""
              memory: ""
          storageSize: "150Gi"
      monitoring:
        overrides:
          nodeSelector: null
          tolerations: null
          ingresses:
            prometheus:
              disableAuth: false
              host: ""
              ingressClass: ""
            alertmanager:
              disableAuth: false
              host: ""
              ingressClass: ""
            grafana:
              disableAuth: false
              host: ""
              ingressClass: ""
            goldpinger:
              disableAuth: false
              host: ""
              ingressClass: ""
        prometheus:
          resources:
            requests:
              cpu: ""
              memory: ""
            limits:
              cpu: ""
              memory: ""
      policy:
        overrides:
          nodeSelector: null
          tolerations: null
          ingresses:
            gpm:
              disableAuth: false
              host: ""
              ingressClass: ""
        gatekeeper:
          additionalExcludedNamespaces: []
      dr:
        overrides:
          nodeSelector: null
          tolerations: null
      auth:
        overrides:
          nodeSelector: null
          ingresses:
            pomerium:
              host: ""
              ingressClass: ""
            dex:
              host: ""
              ingressClass: ""
          tolerations: null
        provider:
          type: none
          basicAuth:
            username: admin
            password: "{env://KFD_BASIC_AUTH_PASSWORD}"
        pomerium:
          secrets:
            COOKIE_SECRET: "{env://KFD_AUTH_POMERIUM_COOKIE_SECRET}"
            IDP_CLIENT_SECRET: "{env://KFD_AUTH_POMERIUM_IDP_CLIENT_SECRET}"
            SHARED_SECRET: "{env://KFD_AUTH_POMERIUM_SHARED_SECRET}"
        dex:
          connectors:
            - type: github
              id: github
              name: GitHub
              config:
                clientID: "{env://KFD_AUTH_DEX_CONNECTORS_GITHUB_CLIENT_ID}"
                clientSecret: "{env://KFD_AUTH_DEX_CONNECTORS_GITHUB_CLIENT_SECRET}"
                redirectURI: https://login.example.dev/callback
                loadAllGroups: false
                teamNameField: slug
                useLoginAsID: false
