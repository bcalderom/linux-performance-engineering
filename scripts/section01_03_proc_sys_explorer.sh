#!/usr/bin/env bash
# section01_03_proc_sys_explorer.sh
# Read-only exploration of /proc, /sys, and related kernel-relevant paths.

set -euo pipefail

echo "[INFO] /proc/meminfo (first 10 lines)"
cat /proc/meminfo | head

echo
echo "[INFO] /proc/cpuinfo (first 10 lines)"
cat /proc/cpuinfo | head

echo
echo "[INFO] /proc/loadavg"
cat /proc/loadavg

echo
PID=$$
echo
echo "[INFO] Inspecting current shell process at /proc/$PID"
ls "/proc/$PID" | head

echo
echo "[INFO] /proc/$PID/status (first 15 lines)"
cat "/proc/$PID/status" | head -n 15

echo
echo "[INFO] Open file descriptors for PID $PID (first 10)"
ls -l "/proc/$PID/fd" | head

echo
echo "[INFO] Network interfaces from /sys/class/net"
ls /sys/class/net

echo
for IFACE in /sys/class/net/*; do
  [ -d "$IFACE" ] || continue
  name=$(basename "$IFACE")
  echo "--- Interface: $name ---"
  [ -r "$IFACE/mtu" ] && echo "MTU: $(cat "$IFACE/mtu")"
  if [ -r "$IFACE/speed" ]; then
    echo "Speed: $(cat "$IFACE/speed")"
  else
    echo "Speed: not exposed via sysfs"
  fi
  echo
done

echo "[INFO] Exploration complete. No changes were made to the system."
