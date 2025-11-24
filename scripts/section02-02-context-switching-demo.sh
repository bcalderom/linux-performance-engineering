#!/usr/bin/env bash

# section02-02-context-switching-demo.sh
#
# This script creates many short-lived and blocking processes to
# increase context switches and runqueue length so you can observe:
# - `vmstat 1` r (runqueue) and cs (context switches per second).
# - `pidstat -w 1` per-process context switch rates.
#
# SAFETY:
# - Intended for NON-PRODUCTION systems.
# - Load is moderate and bounded by the configured workers and duration.

set -euo pipefail

WORKERS="${1:-20}"
DURATION_SECONDS="${2:-30}"

echo "[section02-02] Spawning ${WORKERS} chattier workers for ${DURATION_SECONDS}s..." >&2

echo "[section02-02] In another terminal, run:\n  - vmstat 1\n  - pidstat -w 1" >&2

echo "[section02-02] Press Ctrl+C to stop early." >&2

end=$((SECONDS + DURATION_SECONDS))

worker() {
  while (( SECONDS < end )); do
    # Short sleep and trivial work to force frequent wakeups and scheduling.
    sleep 0.01
    : $(( RANDOM % 1000 ))
  done
}

pids=()
for _ in $(seq 1 "${WORKERS}"); do
  worker &
  pids+=("$!")
done

wait "${pids[@]}" || true

echo "[section02-02] Workers completed." >&2
