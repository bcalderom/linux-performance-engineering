#!/usr/bin/env bash

# section02-01-cpu-architecture-demo.sh
#
# This script creates a simple CPU-bound workload so you can observe:
# - One or more logical CPUs running at (or near) 100% in tools like `top` and `mpstat`.
# - How utilization compares to the total number of logical CPUs (`lscpu`).
#
# SAFETY:
# - Intended for NON-PRODUCTION systems only.
# - Load is bounded and stops when the script exits.

set -euo pipefail

WORKERS="${1:-1}"
DURATION_SECONDS="${2:-30}"

echo "[section02-01] Spawning ${WORKERS} CPU-bound worker(s) for ${DURATION_SECONDS}s..." >&2

echo "[section02-01] Tip: In another terminal, run:\n  - lscpu\n  - top or htop\n  - mpstat -P ALL 1 (if available)" >&2

echo "[section02-01] Press Ctrl+C to stop early." >&2

worker() {
  local end
  end=$((SECONDS + DURATION_SECONDS))
  # Tight floating-point loop to keep the CPU busy.
  while (( SECONDS < end )); do
    : $(( 13*17*23/7 ))
  done
}

pids=()
for _ in $(seq 1 "${WORKERS}"); do
  worker &
  pids+=("$!")
done

wait "${pids[@]}" || true

echo "[section02-01] Workers completed." >&2
