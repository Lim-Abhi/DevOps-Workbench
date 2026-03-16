#!/bin/bash

# Script Program to move files larger than 20MB to archive folder and zip it

# Variables
path="/home/user"  #Required Path
file_size=20       #Required Size
depth=1 	   #Used with find cmd and 1 means within that path only not subfolder
RUN=0 	           #Control flag and 1 means simple dry run(Nothing would happen)

# Check if the directory exists or not
if [ ! -d "$path" ]   # -d means directory and "" if files have spacing(safer)
then
    echo "Directory does not exist on the path!!!"
    exit 1
fi

# Create an archive folder if not present
if [ ! -d "$path/archive" ]
then
    mkdir "$path/archive"
fi

# Find files larger than 20MB and store them in archive dir as zip
for files in $(find "$path" -maxdepth "$depth" -type f -size +"${file_size}"M) #size + (greater than)
do
    if [ "$RUN" -eq 0 ]
    then
        gzip "$files" || exit 1
        mv "$files.gz" "$path/archive" || exit 1
        echo "$files archived successfully in $path/archive on $(date)"
    else
	    echo "Dry Run: $files would be archived"
	    echo "Generally Used to prevent accidental loss"
    fi
done
