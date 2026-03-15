#!/bin/bash

figlet "Disk Monitoring"

diskUsage=$(df -h | grep '/dev/sdd' | awk '{print $5}' | tr -d %) #Select required disk and tr to remove %



if [[ $diskUsage -gt 80 ]];
then
	echo "Disk Space is Running Out..."
else
	echo "Enough Disk Space At the Moment..."
fi

echo "Disk Usage: $diskUsage %"

