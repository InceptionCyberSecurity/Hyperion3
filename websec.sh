#!/bin/bash
# Script for Hyperion v3.x that performs web security test using Gilosmero (integration with CWE CVE and OWASP)
# Usage ./websec.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argumentt $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8 or domain name
udir="$2" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# nmap vuln
sudo nmap -vv $userIP --script vuln --script vulners --script http* -p - -oX usernmap.xml
xslproc usernmap.xml -o usermapWebApp.html

# golismero grab Nmap results, scan host found and write an HTML report:
sudo golismero scan -i usernmap.xml -o gorep.html

# local storage ready for upload to client's container
mkdir $udir
mv /usermapWebApp.html /$udir/usermapWebApp.html
mv gorep.html /$udir/gorep.html
echo " Your results are stored in directory $udir "
sleep 10
