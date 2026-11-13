#!/usr/bin/env bash
set -euo pipefail

failed=0
# --- settings (limits, log path, service list) ---
DISK_LIMIT=80
MEM_LIMIT=90
SERVICES=(nginx cloudflared)
LOG_FILE="/home/maano-lab/sentinel/logs/healthcheck.log"
mkdir -p "$(dirname "$LOG_FILE")"

# --- report function ---       Step 2
report() {
    local status="$1"
    local message="$2"

    if [ "$status" = "FAIL" ]; then
        failed=1
    fi

    echo "$(date '+%Y-%m-%d %H:%M:%S') [$status] $message" | tee -a "$LOG_FILE"
}

# --- disk check ---            Step 1
disk_used=$(df --output=pcent / | tail -1 | tr -d ' %')
if [ "$disk_used" -gt "$DISK_LIMIT" ]; then
    report "FAIL" "disk / at ${disk_used}% (limit ${DISK_LIMIT}%)"
else
    report "PASS" "disk / at ${disk_used}% (limit ${DISK_LIMIT}%)"
fi

# --- memory check ---          Step 3
read -r total available < <(free -m | awk 'NR==2 {print $2, $7}')
used_pct=$(( (total - available) * 100 / total ))
if [ "$used_pct" -gt "$MEM_LIMIT" ]; then
    report "FAIL" "memory at ${used_pct}% (limit ${MEM_LIMIT}%)"
else
    report "PASS" "memory at ${used_pct}% (limit ${MEM_LIMIT}%)"
fi

# --- load check ---            Step 4
load=$(awk '{print $1}' /proc/loadavg)
cores=$(nproc)
overload=$(awk -v l="$load" -v c="$cores" \
    'BEGIN { if (l > c) print "yes"; else print "no" }')
if [ "$overload" = "yes" ]; then
    report "FAIL" "load ${load} exceeds ${cores} cores"
else
    report "PASS" "load ${load} on ${cores} cores"
fi

# --- service checks ---        Step 5
for svc in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$svc"; then
        report "PASS" "$svc is active"
    else
        report "FAIL" "$svc is not active"
    fi
done

# --- exit with result ---      Step 6
exit "$failed"
