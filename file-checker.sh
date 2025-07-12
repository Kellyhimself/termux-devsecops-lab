#!/bin/bash

# Day 4: File Checker Script with if-else and flags

# Show help
if [ "$1" == "-h" ]; then
  echo "Usage: ./file-checker.sh [filename]"
  echo "Checks if a file exists and logs the result."
  exit 0
fi

# Show usage
if [ "$1" == "-u" ]; then
  echo "Enter the filename as the first argument."
  echo "Example: ./file-checker.sh myfile.txt"
  exit 0
fi

# Check if filename is provided
if [ -z "$1" ]; then
  echo "❌ Error: No filename provided."
  echo "Run with -h for help."
  exit 1
fi

file=$1
timestamp=$(date)

# Check if file exists
if [ -f "$file" ]; then
  echo "$timestamp ✅ File '$file' exists." | tee -a checker.log
else
  echo "$timestamp ❌ File '$file' not found." | tee -a checker.log
fi
