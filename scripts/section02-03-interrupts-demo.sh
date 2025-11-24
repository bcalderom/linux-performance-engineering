#!/usr/bin/env bash

# section02-03-interrupts-demo.sh
#
# This script generates modest, continuous network traffic so you can observe:
# - Changes to /proc/interrupts counters for your NIC or loopback device.
# - Increases in %si/%irq time on specific CPUs in `top` or `mpstat -P ALL`.
#
# SAFETY:
# - Intended for NON-PRODUCTION systems and test networks.
# - Defaults to using loopback (127.0.0.1) to avoid external traffic.

set -euo pipefail

TARGET_HOST="${1:-127.0.0.1}"
PACKET_SIZE="${2:-1400}"
INTERVAL="${3:-0.01}"
DURATION_SECONDS="${4:-30}"

echo "[section02-03] Sending ICMP traffic to ${TARGET_HOST} for ${DURATION_SECONDS}s..." >&2

echo "[section02-03] In another terminal, run:\n  - watch -n 1 'grep -i \"eth\\|enp\\|wlp\" /proc/interrupts || head -n 10 /proc/interrupts'\n  - mpstat -P ALL 1" >&2

echo "[section02-03] Press Ctrl+C to stop early." >&2

end=$((SECONDS + DURATION_SECONDS))

while (( SECONDS < end )); do
  # Use ping with a single packet to generate traffic on each iteration.
  ping -q -c 1 -s "${PACKET_SIZE}" "${TARGET_HOST}" >/dev/null 2>&1 || true
  sleep "${INTERVAL}"
done

echo "[section02-03] Traffic generation completed." >&2
