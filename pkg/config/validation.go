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
	apiVersionString   = "^kfd\\.sighup\\.io\\/v\\d+((alpha|beta)\\d+)?$"
	eksVersionString   = "^\\d+\\.\\d+$"
	s3BucketNameString = "(?!(^xn--|.+-s3alias$))^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$"
)

var (
	apiVersionRegex   = regexp.MustCompile(apiVersionString)
	eksVersionRegex   = regexp.MustCompile(eksVersionString)
	s3BucketNameRegex = regexp.MustCompile(s3BucketNameString)
	awsRegions        = map[string]bool{
		"af-south-1":     true,
		"ap-east-1":      true,
		"ap-northeast-1": true,
		"ap-northeast-2": true,
		"ap-northeast-3": true,
		"ap-south-1":     true,
		"ap-southeast-1": true,
		"ap-southeast-2": true,
		"ap-southeast-3": true,
		"ca-central-1":   true,
		"eu-central-1":   true,
		"eu-north-1":     true,
		"eu-south-1":     true,
		"eu-west-1":      true,
		"eu-west-2":      true,
		"eu-west-3":      true,
		"me-central-1":   true,
		"me-south-1":     true,
		"sa-east-1":      true,
		"us-east-1":      true,
		"us-east-2":      true,
		"us-west-1":      true,
		"us-west-2":      true,
	}
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

	err = validate.RegisterValidation("s3-bucket-name", ValidateS3BucketName)
	if err != nil {
		return nil
	}

	err = validate.RegisterValidation("s3-key-length", ValidateS3KeyLength)
	if err != nil {
		return nil
	}

	err = validate.RegisterValidation("aws-region", ValidateAwsRegion)
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

func ValidateS3BucketName(fl validator.FieldLevel) bool {
	return s3BucketNameRegex.MatchString(fl.Field().String())
}

func ValidateS3KeyLength(fl validator.FieldLevel) bool {
	return len(fl.Field().String()) <= 37
}

func ValidateAwsRegion(fl validator.FieldLevel) bool {
	return awsRegions[fl.Field().String()]
}
