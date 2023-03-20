#!/bin/bash
# Script for Hyperion v3.x that performs malware scans
# Usage ./mal.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argumnet $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports

# malware category
sudo nmap -v -sU -sT $userIP --script malware -p - -oX file.xml
xsltproc file.xml -o malware.html

# eternalblue WannaCry and Petya ransomware
sudo nmap -sV --script=http-malware-host $userIP -oX mw.xml
xsltproc mw.xml -o malwarehost.html

sudo nmap -p445 --script smb-vuln-ms17-010 $userIP -oX eb.xml
xsltproc eb.xml -o eternalblue.html

# local storage
mkdir $udir
mv malware.html /$udir/malware.html
mv malwarehost.html /$udir/malwarehost.html
mv eternalblue.html /$udir/eternalblue.html
echo " Your results are stored in directory $udir "
sleep 10
