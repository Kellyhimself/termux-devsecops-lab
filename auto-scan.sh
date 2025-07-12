#!/bin/bash

# Day 6: Auto Log Scanner via cron

logfile="$HOME/termux-devsecops-lab/sample-log.txt"
output="$HOME/termux-devsecops-lab/auto-scan.log"
timestamp=$(date)

keywords=("ERROR" "WARNING" "FAILED")

echo "[$timestamp]" >> $output
for word in "${keywords[@]}"
do
  count=$(grep -c "$word" $logfile)
  echo "$word: $count" >> $output
done
echo "------------------------" >> $output
