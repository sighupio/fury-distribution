// Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package config

import (
	"regexp"
	"strings"

	"github.com/go-playground/validator/v10"
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
	validate := validator.New()

	err := validate.RegisterValidation("api-version", ValidateAPIVersion)
	if err != nil {
		return nil
	}

	err = validate.RegisterValidation("cluster-kind", ValidateClusterKind)
	if err != nil {
		return nil
	}

	err = validate.RegisterValidation("eks-version", ValidateEksVersion)
	if err != nil {
		return nil
	}

	err = validate.RegisterValidation("permissive-semver", ValidatePermissiveSemVer)
	if err != nil {
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
	version := strings.TrimPrefix(fl.Field().String(), "v")

	err := validator.New().Var(version, "semver")

	return err == nil
}

func ValidateEksVersion(fl validator.FieldLevel) bool {
	return eksVersionRegex.MatchString(fl.Field().String())
}
