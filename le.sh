#!/bin/bash
# Script for Hyperion v3.x for Linux exploit suggester
# Usage ./le.sh kernel mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# eg. ./bw.sh 8.8.8.8 or www.google.com
# First argument $1: $ker Linxc kernel use uname -a
# second argumnet $2 mydir
# User Input from  command line arguments
ker="$1" # linux kernel number e.g 2.6.1 try uname -a
udir="$2" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# linux exploit suggester
linux-exploit-suggester -k $ker > lexploit.txt
# cat le.txt | grep CVE les.txt
sed -1 '1i Linux Exploit Code Available\n----------------------------------' lexploit.txt

# local storage ready for upload to client's container
mkdir $udir
mv lexploit.txt /$udir/lexploit.txt
echo " Your results are stored in directory $udir "
sleep 10
