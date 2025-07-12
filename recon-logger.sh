#!/bin/bash
# recon-logger.sh - Automated Nmap Recon Script (DevSecOps Edition)
# Usage: ./recon-logger.sh target.com or ./recon-logger.sh 192.168.1.1

TARGET="$1"
if [ -z "$TARGET" ]; then
  echo "Usage: $0 <target>"
  exit 1
fi

# Create a timestamped log file
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
LOGFILE="$HOME/termux-devsecops-lab/recon-$TARGET-$TIMESTAMP.txt"

echo "Scanning $TARGET at $TIMESTAMP..."
echo "[+] Saving to: $LOGFILE"

# Perform scan
nmap -p 22,80,443 --script vuln "$TARGET" -oN "$LOGFILE"

echo "[+] Scan complete."
