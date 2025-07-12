#!/bin/bash

# Day 3: Dynamic Banner Generator

# Check if user provided a name as argument
if [ -z "$1" ]; then
  read -p "Enter your name: " username
else
  username=$1
fi

echo "Generating banner for $username..."

# Create the banner message
banner="⚠️  Unauthorized access is prohibited!
👤  Logged in as: $username
📅  Login time: $(date)
-----------------------------------------"

# Save to file
echo "$banner" > banner.txt

# Show the banner
cat banner.txt
