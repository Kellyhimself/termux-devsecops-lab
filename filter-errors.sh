#!/bin/bash

# Day 2 - Log Filter Script
# Filters ERROR lines from a system log

echo "Reading log file..."
grep "ERROR" syslog.txt | sort | uniq > filtered-errors.txt

echo "Filtered errors saved to: filtered-errors.txt"
cat filtered-errors.txt
