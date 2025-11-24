#!/usr/bin/env bash

# section02-04-lockup-and-stall-demo.sh
#
# This script creates heavy CPU load using multiple busy-loop workers to
# simulate CPU starvation of interactive tasks WITHOUT intentionally
# triggering kernel lockups.
#
# Observe while it runs:
# - `vmstat 1` r (runqueue) and cs (context switches).
# - `mpstat -P ALL 1` near-100% CPU usage on many cores.
# - Noticeable lag when interacting with a shell.
#
# SAFETY:
# - Intended for NON-PRODUCTION systems.
# - Run time and intensity are configurable; the script stops cleanly.

set -euo pipefail

WORKERS="${1:-$(nproc)}"
DURATION_SECONDS="${2:-45}"

echo "[section02-04] Spawning ${WORKERS} CPU-busy workers for ${DURATION_SECONDS}s..." >&2

echo "[section02-04] In another terminal, run:\n  - vmstat 1\n  - mpstat -P ALL 1\n  - Try typing commands and note responsiveness" >&2

echo "[section02-04] Press Ctrl+C to stop early." >&2

worker() {
  local end
  end=$((SECONDS + DURATION_SECONDS))
  while (( SECONDS < end )); do
    # Tight integer math to keep CPUs saturated.
    : $(( (13*17*23*29) ^ (RANDOM & 255) ))
  done
}

pids=()
for _ in $(seq 1 "${WORKERS}"); do
  worker &
  pids+=("$!")
done

wait "${pids[@]}" || true

echo "[section02-04] Workers completed. System should recover quickly." >&2
