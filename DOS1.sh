#!/bin/bash
# Script for Hyperion v3.x that performs DOS vector tests using nmap
# Usage ./DOS1.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argumnet $2 mydir

# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports

# nmap dos
sudo nmap -vv $userIP --script dos* -p - -oX dos.xml
xsltproc dos.xml -o dos1.html

# local storage ready for upload to client's container
mkdir $udir
mv dos1.html /$udir/dos1.html
echo " Your results are stored in directory $udir "
sleep 10
