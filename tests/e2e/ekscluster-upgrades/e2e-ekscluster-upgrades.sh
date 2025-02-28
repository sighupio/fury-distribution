#!/usr/bin/env sh
# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

set -e

echo "----------------------------------------------------------------------------"
echo "Executing furyctl for the initial setup 1.30.0"
tests/e2e/ekscluster/furyctl_apply.expect tests/e2e/ekscluster-upgrades/manifests/furyctl-init-cluster-1.30.0.yaml

echo "----------------------------------------------------------------------------"
echo "Executing upgrade to 1.31.0"
tests/e2e/ekscluster-upgrades/furyctl_upgrade.expect tests/e2e/ekscluster-upgrades/manifests/furyctl-init-cluster-1.31.0.yaml --outdir "$PWD" --force upgrades --disable-analytics
