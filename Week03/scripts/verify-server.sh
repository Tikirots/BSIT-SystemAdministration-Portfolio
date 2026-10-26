#!/usr/bin/env bash
# Read-only observation helper. Run inside the installed Ubuntu VM.
# Does not install packages, upgrade the OS, or claim a successful deployment.
set -uo pipefail
umask 077
if [[ ! -d /run/systemd/system ]]; then
  printf '%s\n' 'Run this on the installed Ubuntu VM with systemd, not a container.' >&2
  exit 2
fi
if [[ ! -r /etc/os-release ]]; then
  printf '%s\n' 'Cannot identify the guest operating system.' >&2
  exit 2
fi
. /etc/os-release
if [[ "${ID:-}" != ubuntu ]]; then
  printf '%s\n' 'This helper is intended for the Ubuntu lab VM.' >&2
  exit 2
fi
lab_timestamp=$(date -u +%Y%m%dT%H%M%SZ)
lab_log="week03-verification-${lab_timestamp}-$$.txt"
run_check() {
  local label=$1
  shift
  printf '\n--- %s ---\n' "$label"
  "$@"
  local result=$?
  printf '[command exit status: %s]\n' "$result"
}
{
  printf 'Week 3 observations; UTC time: %s\n' "$lab_timestamp"
  printf 'These observations do not replace installer screenshots or update evidence.\n'
  run_check 'Account' whoami
  run_check 'Hostname' hostname
  run_check 'OS release' cat /etc/os-release
  run_check 'IP addresses' ip addr
  run_check 'Routes' ip route
  run_check 'DNS lookup' getent hosts google.com
  run_check 'Required internet test' ping -c 4 -W 3 google.com
  run_check 'Disk and filesystems' lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS
  run_check 'SSH daemon status' systemctl status ssh --no-pager
  run_check 'SSH socket status' systemctl status ssh.socket --no-pager
  printf '\nFirmware boot mode: '
  if [[ -d /sys/firmware/efi ]]; then printf 'UEFI\n'; else printf 'Legacy BIOS\n'; fi
  printf 'Reboot-required marker: '
  if [[ -e /var/run/reboot-required ]]; then printf 'present\n'; else printf 'not present\n'; fi
  printf 'APT update/upgrade: run and record separately; not executed by this helper.\n'
  printf 'Host-to-guest SSH login: test from the Windows host separately.\n'
} 2>&1 | tee "$lab_log"
lab_capture_status=${PIPESTATUS[1]}
if (( lab_capture_status != 0 )); then
  printf '%s\n' 'Could not write the observation log.' >&2
  exit 1
fi
printf '\nSaved %s. Review for private data before sharing.\n' "$lab_log"
