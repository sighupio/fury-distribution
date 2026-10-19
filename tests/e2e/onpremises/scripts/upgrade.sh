#!/usr/bin/env bash
# Copyright (c) 2017-present SIGHUP s.r.l All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.

# Upgrade the cluster to the target distribution version with furyctl, using the
# rendered furyctl_upgrade.yaml. Run after install.sh (which left the pki +
# kubeconfig in config/ and a working cluster at the base version). The longhorn StorageClass
# already exists from the base install, so a single apply rolls out everything.
set -uo pipefail

SCRIPTS="$(cd "$(dirname "$0")" && pwd)"
ONPREM="$(dirname "$SCRIPTS")"
E2E_DIR="${E2E_DIR:-$ONPREM}"
DISTRO_LOCATION="${DISTRO_LOCATION:-/drone/src}"
export KUBECONFIG="$E2E_DIR/config/kubeconfig"

if [ -n "${DIAG_DIR:-}" ] && mkdir -p "$DIAG_DIR" 2>/dev/null; then
  exec > >(tee -a "$DIAG_DIR/upgrade-${DRONE_BUILD_NUMBER:-local}.log") 2>&1
fi

cd "$E2E_DIR/config" || exit 1

# POD_RUNNING_CHECK_TIMEOUT (Immutable): its pod wait retries every 15s, not 30s, so
# furyctl's 300s default is only 150s.
timeout_flag=()
[ -n "${POD_RUNNING_CHECK_TIMEOUT:-}" ] && timeout_flag=(--pod-running-check-timeout "$POD_RUNNING_CHECK_TIMEOUT")

upgrade() {
  rm -rf /tmp/furyctl-* 2>/dev/null || true
  furyctl apply -D --upgrade --force upgrades --config furyctl_upgrade.yaml --distro-location "$DISTRO_LOCATION" "${timeout_flag[@]}"
}

show_not_ready() {
  echo ">>> pods not Ready after the failed upgrade"
  kubectl get pods -A -o wide | awk 'NR == 1 || $4 != "Completed" && !($4 == "Running" && split($3, r, "/") == 2 && r[1] == r[2])' || true
  kubectl get events -A --sort-by=.lastTimestamp | tail -50 || true
}

wait_stalled_deployments() {
  local i stalled=""
  for i in $(seq 1 60); do
    stalled="$(kubectl get deployments -A --no-headers \
      -o custom-columns='NS:.metadata.namespace,NAME:.metadata.name,REASON:.status.conditions[?(@.type=="Progressing")].reason' |
      awk '$3 == "ProgressDeadlineExceeded" { printf "%s/%s ", $1, $2 }')" || true
    [ -z "$stalled" ] && return 0
    echo ">>> waiting for the rollout of the Deployments past their progress deadline ($i/60): $stalled"
    sleep 20
  done
  echo ">>> still past their progress deadline after 20m: $stalled"
}

# Single attempt: an upgrade failure (e.g. a node drain blocked by a PDB) is
# deterministic -- retrying only burns the pipeline's clock.
# UPGRADE_RESUME=1 (Immutable): after the node reboots a Deployment can pass its progress
# deadline while still rolling; wait for it, then furyctl resumes from the failed phase.
echo ">>> furyctl upgrade"
upgrade
rc=$?

if [ "$rc" -ne 0 ] && [ "${UPGRADE_RESUME:-}" = "1" ]; then
  show_not_ready
  wait_stalled_deployments
  echo ">>> furyctl upgrade (resume from the failed phase)"
  upgrade
  rc=$?
fi

[ "$rc" -ne 0 ] && show_not_ready
exit "$rc"
