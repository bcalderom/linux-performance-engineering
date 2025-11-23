#!/usr/bin/env bash
# section01_01_inspect_linux_basics.sh
# Safe, read-only inspection of basic Linux properties and a simple syscall profile.

set -euo pipefail

echo "[INFO] Kernel and OS identification"
uname -a
if [ -r /etc/os-release ]; then
  echo
  echo "[INFO] /etc/os-release:"
  cat /etc/os-release
fi

echo
echo "[INFO] CPU summary (lscpu | head)"
if command -v lscpu >/dev/null 2>&1; then
  lscpu | head
else
  echo "lscpu not available"
fi

echo
echo "[INFO] Memory summary (free -h)"
if command -v free >/dev/null 2>&1; then
  free -h
else
  echo "free not available"
fi

echo
echo "[INFO] Filesystem summary (df -hT | head)"
df -hT | head || true

if command -v strace >/dev/null 2>&1; then
  echo
  echo "[INFO] Syscall profile of 'ls /tmp' (strace -c)"
  strace -c ls /tmp 2>&1 | sed 's/^/    /'
else
  echo
  echo "[WARN] strace not installed; skipping syscall profile."
fi
