#!/bin/bash
# Script for Hyperion v3.x that performs Uniscan tests fri LFI RFI and RCE vulnerabilities
# Usage ./uni.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# secondargumnet $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports

# uniscan
perl ./uniscan.pl -u https://$userIP/ -qweds > uni.txt
sed -i '1i LFI, RFI and RCE Detetcion from Janus Tests\n---------------------------------------' uniscan.txt

# local storage ready for upload to client's container
mkdir $udir
cd $udir
mv uniscan.txt /$udir/uniscan.txt
echo " Your results are stored in directory $udir "
sleep 10
