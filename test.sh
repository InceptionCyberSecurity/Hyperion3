#!/bin/bash
# Test script for Hyperion v3.x that attempts Nmap scan/enumeration on all ports with Safe Scripts
# Usage ./test.sh 8.8.8.8 mydir as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8
# First argument: $usIP  either IP address or domain name
# Second arguement: $udir user directory

# User Input from  command line arguments
usIP="$1" # IP address eg 8.8.8.8
udir="$2" # user directory

# quick nmap port scan
echo " "
echo " The script is running and may take a while ............"
echo " "
sudo nmap -p - -sC $usIP -oX test.xml
xsltproc test.xml -o test.html

# local storage for upload to client container
mkdir $udir
mv test.html /$udir/test.html
rm test.xml
echo " The results are stored in directory /tmp/$udir "
