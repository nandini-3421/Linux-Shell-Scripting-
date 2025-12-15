#!/bin/bash

LOGDIR="$HOME/security_monitor"
mkdir -p "$LOGDIR"

LOGFILE="$LOGDIR/scan_$(date +%F_%H-%M).log"

echo "===== SECURITY SCAN STARTED: $(date) =====" >> "$LOGFILE"

# 1. TOP CPU PROCESSES
echo "[1] Top CPU Processes:" >> "$LOGFILE"
ps -eo pid,ppid,%cpu,cmd --sort=-%cpu | head -n 10 >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"

# 2. TOP RAM PROCESSES
echo "[2] Top RAM Processes:" >> "$LOGFILE"
ps -eo pid,ppid,%mem,cmd --sort=-%mem | head -n 10 >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"

# 3. WORLD-WRITABLE FILE CHECK
echo "[3] World-Writable Files:" >> "$LOGFILE"
find / -type f -perm /002 2>/dev/null | head -n 20 >> "$LOGFILE"
echo "(showing only first 20 entries)" >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"

# 4. CHECK FILE CHANGES IN /etc (last 15 mins)
echo "[4] Recently Modified System Files (/etc):" >> "$LOGFILE"
find /etc -type f -mmin -15 2>/dev/null >> "$LOGFILE"
echo "------------------------------------------" >> "$LOGFILE"

# 5. CHECK CURRENTLY LOGGED-IN USERS
echo "[5] Active Users:" >> "$LOGFILE"
who >> "$LOGFILE"
