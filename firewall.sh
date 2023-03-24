#!/bin/bash
# Script for Hyperion v3.x for web application firewall test
# Usage ./firewall.sh 8.8.8.8  mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argumnet $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# WAF detect/fingerprint
sudo nmap -p 80, 443 --script http-waf-detect --script=http-waf-fingerprint $userIP -oX waffy.xml
xsltproc waffy.html -o waffy.html
# WAFWoof web app firewall confirmation
wafw00f $userIP > waf1.txt
cat waf1.txt | grep WAF > waf2.txt
sed -i '1i Web application Firewall Detection\n-------------------------------------' waf2.txt
# test firewall rules
sudo nmap -sS -Pn -p- -T4 -vv --reason -oX fwrules.xml $userIP
xslproc fwrules.xml -o fwrules.html
# local storage ready for upload to client's container
mkdir $udir
mv waf2.txt /$udir/waf2.txt
mv waffy.html /$udir/waffy.html
mv fwrules.html /$udir/fwrules.html
echo " Your results are stored in directory $udir "
sleep 10
