// Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package config

type Furyctl struct {
	ApiVersion string `yaml:"apiVersion"`
	Kind       string `yaml:"kind"`
	Spec       struct {
		DistributionVersion string `yaml:"distributionVersion"`
	} `yaml:"spec"`
}

type KFD struct {
	Version        string        `yaml:"version"`
	Modules        KFDModules    `yaml:"modules"`
	Kubernetes     KFDKubernetes `yaml:"kubernetes"`
	FuryctlSchemas KFDSchemas    `yaml:"furyctlSchemas"`
	Tools          KFDTools      `yaml:"tools"`
}

type KFDModules struct {
	Auth       string `yaml:"auth"`
	Dr         string `yaml:"dr"`
	Ingress    string `yaml:"ingress"`
	Logging    string `yaml:"logging"`
	Monitoring string `yaml:"monitoring"`
	Opa        string `yaml:"opa"`
}

type KFDProvider struct {
	Version   string `yaml:"version"`
	Installer string `yaml:"installer"`
}

type KFDKubernetes struct {
	Eks KFDProvider `yaml:"eks"`
}

type KFDSchemas struct {
	Eks []struct {
		ApiVersion string `yaml:"apiVersion"`
		Kind       string `yaml:"kind"`
	} `yaml:"eks"`
}

type KFDTools struct {
	Ansible   string `yaml:"ansible"`
	Furyagent string `yaml:"furyagent"`
	Kubectl   string `yaml:"kubectl"`
	Kustomize string `yaml:"kustomize"`
	Terraform string `yaml:"terraform"`
}
