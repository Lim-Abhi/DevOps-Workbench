#!/bin/bash

#Script to add user from root and providing them pwd to change on first login
 
#Execute the script with sudo privileges only
if [[ "${UID}" -ne 0 ]]                       			#0 means as root
then
        echo "Please run as sudo or root."
        exit 1
fi

#Make sure to pass username as parameter
if [[ "${#}" -lt 1 ]]   		      			#${#} means total arg
then
        echo "Pass username and description for user as parameters..."
        echo "Syntax: ${0} [username] [description]" 		# ${0} means filename
        exit 1
fi

#Store username
user_name="${1}" 				      		# ${1} means first arg

#Shift to get description
shift
descp="${@}"       		              			# Rem all spaces char to descp

#Create user
useradd -c "$descp" -m -s /bin/bash "$user_name"   		#/bin/bash to provide with user shell

#Check if user creation was successful
if [[ "${?}" -ne 0 ]]                          			# ? meaning if last cmd true, then 0
then
        echo "User creation failed."
        exit 1
fi

#Generate password
password=$(date +%s%N)

#Set password
echo "$user_name:$password" | chpasswd   

if [[ "${?}" -ne 0 ]]
then
    echo "Password setting failed."
    exit 1
fi

#Force password change on first login
passwd -e "$user_name"   					# e means expire change on next login

#Display info
echo "UserName: $user_name"
echo "Password: $password"
echo "HostName: $(hostname)"
