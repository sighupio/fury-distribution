// Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package config_test

import (
	"testing"

	"github.com/go-playground/validator/v10"

	"github.com/sighupio/fury-distribution/pkg/apis/config"
)

func TestValidateAwsRegion(t *testing.T) {
	t.Parallel()

	testCases := []struct {
		desc   string
		region string
		want   bool
	}{
		{
			desc:   "valid region",
			region: "eu-south-1",
			want:   true,
		},
		{
			desc:   "invalid region",
			region: "xx-yyyy-123",
			want:   false,
		},
	}
	for _, tC := range testCases {
		t.Run(tC.desc, func(t *testing.T) {
			t.Parallel()

			validate := validator.New()
			if err := validate.RegisterValidation("aws-region", config.ValidateAwsRegion); err != nil {
				t.Fatalf("could not register aws-region validation: %v", err)
			}

			err := validate.Var(tC.region, "aws-region")
			if tC.want {
				if err != nil {
					t.Errorf("got %v, want nil", err)
				}
			} else {
				if err == nil {
					t.Errorf("got nil, want error")
				}
			}
		})
	}
}
