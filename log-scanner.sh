#!/bin/bash

# Day 5: Log Scanner Tool

# Check if file is provided
if [ -z "$1" ]; then
  echo "❌ Please provide a log file to scan."
  exit 1
fi

file=$1

# Check if file exists
if [ ! -f "$file" ]; then
  echo "❌ File '$file' not found."
  exit 1
fi

echo "🔍 Scanning log file: $file"
echo "-----------------------------"
keywords=("ERROR" "WARNING" "FAILED")

for word in "${keywords[@]}"
do
  count=$(grep -c "$word" "$file")
  echo "$word: $count"
done

echo "-----------------------------"
echo "✅ Scan complete. Summary above."
