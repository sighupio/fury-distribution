#!/usr/bin/env sh
# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

set -e

echo "----------------------------------------------------------------------------"
echo "Executing furyctl for the initial setup"
/tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-init-cluster.yaml --outdir "$PWD" -H --distro-location ./ --force
echo "Testing that the components are running"
bats -t tests/e2e-kfddistribution-init-cluster.sh

echo "----------------------------------------------------------------------------"
echo "Executing furyctl with the tempo migration to none"
/tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-2-migrate-from-tempo-to-none.yaml --outdir "$PWD" -H --distro-location ./ --force --skip-deps-download
bats -t tests/e2e-kfddistribution-2-migrate-from-tempo-to-none.sh

echo "----------------------------------------------------------------------------"
echo "Executing furyctl with the kyverno migration to none"
/tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-3-migrate-from-kyverno-to-none.yaml --outdir "$PWD" -H --distro-location ./ --force --skip-deps-download
bats -t tests/e2e-kfddistribution-3-migrate-from-kyverno-to-none.sh

echo "----------------------------------------------------------------------------"
echo "Executing furyctl with the velero migration to none"
/tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-4-migrate-from-velero-to-none.yaml --outdir "$PWD" -H --distro-location ./ --force --skip-deps-download
bats -t tests/e2e-kfddistribution-4-migrate-from-velero-to-none.sh

echo "----------------------------------------------------------------------------"
echo "Executing furyctl with the logging migration to none"
/tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-5-migrate-from-loki-to-none.yaml --outdir "$PWD" -H --distro-location ./ --force --skip-deps-download
bats -t tests/e2e-kfddistribution-5-migrate-from-loki-to-none.sh

echo "----------------------------------------------------------------------------"
echo "Executing furyctl with the mimir migration to none"
/tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-6-migrate-from-mimir-to-none.yaml --outdir "$PWD" -H --distro-location ./ --force --skip-deps-download
bats -t tests/e2e-kfddistribution-6-migrate-from-mimir-to-none.sh

echo "----------------------------------------------------------------------------"
echo "Executing furyctl with the nginx migration to none"
/tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-7-migrate-from-nginx-to-none.yaml --outdir "$PWD" -H --distro-location ./ --force --skip-deps-download
bats -t tests/e2e-kfddistribution-7-migrate-from-nginx-to-none.sh

echo "----------------------------------------------------------------------------"
echo "Executing furyctl with the auth basic to sso migration"
/tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-8-migrate-from-sso-to-none.yaml --outdir "$PWD" -H --distro-location ./ --force --skip-deps-download
bats -t tests/e2e-kfddistribution-8-migrate-from-sso-to-none.sh

echo "----------------------------------------------------------------------------"
echo "Executing furyctl with the auth basic to sso migration"
/tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-9-migrate-from-basicAuth-to-sso.yaml --outdir "$PWD" -H --distro-location ./ --force --skip-deps-download
bats -t tests/e2e-kfddistribution-9-migrate-from-basicAuth-to-sso.sh

echo "----------------------------------------------------------------------------"
echo "Executing furyctl testing safe migrations from none"
/tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-10-migrate-from-none-to-safe-values.yaml --outdir "$PWD" -H --distro-location ./ --skip-deps-download

echo "----------------------------------------------------------------------------"
echo "Executing furyctl testing kyverno uninstall policies"
/tmp/furyctl create cluster --config tests/e2e/kfddistribution/furyctl-11-migrate-from-kyverno-default-policies-to-disabled.yaml --outdir "$PWD" -H --distro-location ./ --skip-deps-download
bats -t tests/e2e-kfddistribution-11-migrate-from-kyverno-default-policies-to-disabled.sh