#!/bin/bash
# Script for Hyperion v3.x that performs Drupal tests
# Usage ./cms3.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argumnet $2 mydir
# # User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports

# WAF
wafw00f $userIP > w.txt
cat w.txt | grep WAF > waf.txt
sed -i '1i WafWoof Results\n----------------------' waf.txt

# Drupal  can chnage scan to drupal wordpress silverstripe joomla moodle
cd droopescan
droopescan scan drupal -u https://$userIP > dr.txt
cat dr.txt | grep drupal > droop.txt
sed -i '1i DroopeScan Results\n-------------------' droop.txt
mv droop1.txt /root
cd ..

# drupwn
cd drupwn
drupwn --mode enum --target https://$userIP > enum.txt
cat enum.txt | grep CVE > enum1.txt
sed -i '1i Drupwn Enumeratipon\n------------------------' enum1.txt
mv enum1.txt /root

drupwn --mode exploit --target https://$userIP > exp.txt
cat exp.txt | grep CVE > exp1.txt
sed -i '1i Drupwn Exploits\n----------------------' exp1.txt
mv exp1.txt /root
cd ..

# whatweb
whatweb -v -a 4 -l --logxml=what.xml $userIP
xsltproc what.xml > whatcms3.html

# text file combine
cat waf.txt enum1.txt exp1.tct droop.txt > outputcms3.txt

# local storage ready for upload to client's container
mkdir $udir
mv outputcms3.txt /$udir/outputcms3.txt
mv whatcms3.html /$udir/whatcms3.html
echo " Your results are stored in directory $udir "
sleep 10
