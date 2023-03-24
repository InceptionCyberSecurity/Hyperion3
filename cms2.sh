#!/bin/bash
# Script for Hyperion v3.x that performs Joomla tests
# Usage ./cms2.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argument $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# WAF
wafw00f $userIP > w.txt
cat w.txt | grep WAF > waf.txt
sed -i '1i WafWoof Results\n----------------------' waf.txt
# Joomla
joomscan -u http://$userIP > j.txt
catjr.txt | grep joomla > joom.txt
sed -i '1i Joomla Scan Results\n---------------------' joom.txt
# whatweb
whatweb -v -a 4 -l --logxml=what.xml $userIP
xsltproc what.xml > whatcms2.html
# text file combine
cat waf.txt joom.txt > outputcms2.txt
# local storage ready for upload to client's container
mkdir $udir
mv outputcms2.txt /$udir/outputcms2.txt
mv whatcms2.html /$udir/whatcms2.html
echo " Your results are stored in directory $udir "
sleep 10
