// Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package config

type Furyctl struct {
	ApiVersion string      `yaml:"apiVersion" validate:"required,api-version"`
	Kind       string      `yaml:"kind" validate:"required,cluster-kind"`
	Spec       FuryctlSpec `yaml:"spec" validate:"required"`
}

type FuryctlSpec struct {
	DistributionVersion string `yaml:"distributionVersion" validate:"required,permissive-semver"`
}

type KFD struct {
	Version        string        `yaml:"version" validate:"required,permissive-semver"`
	Modules        KFDModules    `yaml:"modules" validate:"required"`
	Kubernetes     KFDKubernetes `yaml:"kubernetes" validate:"required"`
	FuryctlSchemas KFDSchemas    `yaml:"furyctlSchemas" validate:"required"`
	Tools          KFDTools      `yaml:"tools" validate:"required"`
}

type KFDModules struct {
	Auth       string `yaml:"auth" validate:"required,permissive-semver"`
	Dr         string `yaml:"dr" validate:"required,permissive-semver"`
	Ingress    string `yaml:"ingress" validate:"required,permissive-semver"`
	Logging    string `yaml:"logging" validate:"required,permissive-semver"`
	Monitoring string `yaml:"monitoring" validate:"required,permissive-semver"`
	Opa        string `yaml:"opa" validate:"required,permissive-semver"`
}

type KFDProvider struct {
	Version   string `yaml:"version" validate:"required"`
	Installer string `yaml:"installer" validate:"required,permissive-semver"`
}

type KFDKubernetes struct {
	Eks KFDProvider `yaml:"eks" validate:"required"`
}

type KFDSchemas struct {
	Eks []struct {
		ApiVersion string `yaml:"apiVersion" validate:"required,api-version"`
		Kind       string `yaml:"kind" validate:"required,cluster-kind"`
	} `yaml:"eks"`
}

type KFDTools struct {
	Ansible   string `yaml:"ansible" validate:"required,permissive-semver"`
	Furyagent string `yaml:"furyagent" validate:"required,permissive-semver"`
	Kubectl   string `yaml:"kubectl" validate:"required,permissive-semver"`
	Kustomize string `yaml:"kustomize" validate:"required,permissive-semver"`
	Terraform string `yaml:"terraform" validate:"required,permissive-semver"`
}
