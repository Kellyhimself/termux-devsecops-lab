#!/data/data/com.termux/files/usr/bin/bash

# Simple Port Scanner
# Usage: ./basic-port-scan.sh <host>

TARGET=$1

if [ -z "$TARGET" ]; then
  echo "Usage: $0 <host>"
  exit 1
fi

echo "Scanning common ports on $TARGET ..."
for port in 22 80 443 8080 3306 5432; do
  timeout 1 bash -c "echo > /dev/tcp/$TARGET/$port" 2>/dev/null &&
  echo "Port $port is OPEN" ||
  echo "Port $port is CLOSED"
done
