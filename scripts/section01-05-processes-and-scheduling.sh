#!/usr/bin/env bash
# section01_02_process_tree_and_scheduling.sh
# Demonstrate a short-lived CPU-bound workload and inspect its scheduling behavior.

set -euo pipefail

if ! command -v ps >/dev/null 2>&1; then
  echo "ps command not found; aborting" >&2
  exit 1
fi

cleanup() {
  if [[ -n "${WORK_PID-}" ]] && kill -0 "$WORK_PID" 2>/dev/null; then
    kill "$WORK_PID" 2>/dev/null || true
    wait "$WORK_PID" 2>/dev/null || true
  fi
}
trap cleanup EXIT

# Start a CPU-bound loop in the background for a limited time.
echo "[INFO] Starting short-lived CPU-bound workload..."
(
  end=$((SECONDS + 15))
  while [ "$SECONDS" -lt "$end" ]; do
    : $((RANDOM * RANDOM))
  done
) &
WORK_PID=$!
echo "[INFO] Worker PID: $WORK_PID"

sleep 1

echo
echo "[INFO] ps snapshot for worker (PID, PPID, STAT, %CPU, COMMAND)"
ps -o pid,ppid,stat,%cpu,cmd -p "$WORK_PID" || true

if command -v top >/dev/null 2>&1; then
  echo
  echo "[INFO] One-shot top snapshot (press q to exit if it goes interactive)"
  top -b -n 1 | head -n 20 || true
else
  echo
  echo "[WARN] top not available; skipping top snapshot."
fi

wait "$WORK_PID" 2>/dev/null || true

echo
echo "[INFO] Workload finished; cleanup complete."
