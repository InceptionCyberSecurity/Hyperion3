#!/bin/bash
# Script for Hyperion v3.x that performs tests al ALL cloud servers
# Usage ./cloud.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
#second argumnet $2 my directory
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports

# nmap vuln
sudo nmap -vv $userIP --script vuln --script vulners --script discovery -p - -oX vuln.xml
xslproc vuln.xml -o cloudvuln.html

# local storage ready for upload to client's container
cd /
cd root
mkdir $udir
cd $udir
mv /root/cloudvuln.html /root/$udir/cloudvuln.html
echo " Your results are stored in directory $udir "
sleep 10
cd /
cd root
