// Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package config

import (
	"regexp"
	"strings"

	"github.com/Al-Pragliola/go-version"
	"github.com/go-playground/validator/v10"
	regions "github.com/jsonmaur/aws-regions/v2"
)

const (
	apiVersionString = "^kfd\\.sighup\\.io\\/v\\d+((alpha|beta)\\d+)?$"
	eksVersionString = "^\\d+\\.\\d+$"
)

var (
	apiVersionRegex = regexp.MustCompile(apiVersionString)
	eksVersionRegex = regexp.MustCompile(eksVersionString)
)

func NewValidator() *validator.Validate {
	var err error

	validate := validator.New()

	if err = validate.RegisterValidation("api-version", ValidateAPIVersion); err != nil {
		return nil
	}

	if err = validate.RegisterValidation("cluster-kind", ValidateClusterKind); err != nil {
		return nil
	}

	if err = validate.RegisterValidation("eks-version", ValidateEksVersion); err != nil {
		return nil
	}

	if err = validate.RegisterValidation("permissive-semver", ValidatePermissiveSemVer); err != nil {
		return nil
	}

	if err = validate.RegisterValidation("permissive-constraint", ValidatePermissiveConstraint); err != nil {
		return nil
	}

	if err = validate.RegisterValidation("aws-region", ValidateAwsRegion); err != nil {
		return nil
	}

	return validate
}

func ValidateAPIVersion(fl validator.FieldLevel) bool {
	return apiVersionRegex.MatchString(fl.Field().String())
}

func ValidateClusterKind(fl validator.FieldLevel) bool {
	return fl.Field().String() == "EKSCluster"
}

func ValidatePermissiveSemVer(fl validator.FieldLevel) bool {
	v := strings.TrimPrefix(fl.Field().String(), "v")

	_, err := version.NewVersion(v)

	return err == nil
}

func ValidatePermissiveConstraint(fl validator.FieldLevel) bool {
	c := strings.TrimPrefix(fl.Field().String(), "v")

	_, err := version.NewConstraint(c)

	return err == nil
}

func ValidateEksVersion(fl validator.FieldLevel) bool {
	return eksVersionRegex.MatchString(fl.Field().String())
}

func ValidateAwsRegion(fl validator.FieldLevel) bool {
	_, err := regions.LookupByCode(fl.Field().String())

	return err == nil
}
