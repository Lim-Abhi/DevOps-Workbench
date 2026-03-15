#!/bin/bash

#install figlet package for cool banners
figlet "RAM USAGE"


#Variables to store Total,Used and Free Memory
totalMemory=$(free -m | grep 'Mem' | awk '{print $2}')  #-m for MegaBytes,select Mem row and print that column with awk
usedMemory=$(free -m | grep 'Mem' | awk '{print $3}')
freeMemory=$(free -m | grep 'Mem' | awk '{print $4}')

#Read All Variables in One line
#read totalMemory usedMemory freeMemory <<< $(free -m | awk '/Mem:/ {print $2,$3,$4}')

memoryLimit=500

echo "Total Memory :$totalMemory MB"
echo "Used Memory :$usedMemory MB"
echo "Free Memory :$freeMemory MB"


if [[ $freeMemory -lt $memoryLimit ]];
then
	echo "Warning!!! Running Out Of Memory..."
fi

