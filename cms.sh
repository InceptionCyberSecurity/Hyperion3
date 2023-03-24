##!/bin/bash
# Script for Hyperion v3.x that performs general CMS tests using WafWoof and Wapiti
# Usage ./cms.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argument $2 my dir
echo " "
echo " The script is running and may take a while ............"
echo " "
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports
# CMS recon and enumeration
# General CMS Audit script using Firewall, HTTP/HTTPS and HTML scans. Good for any type of CMS. Uses many tools
# like WhatWeb, WafW00f. The installed CMS will be automatically detected.
# nmap vuln vulners  on CMS server
sudo nmap -vv $userIP --script vuln --script vulners –sV --script http-enum --script html-cms -p - -oX usernmap.xml
xslproc usernmap.xml -o usermapCMSall.html
# WAF
wafw00f $userIP > w.txt
cat w.txt | grep WAF > waf.txt
sed -i '1i WafWoof Results\n----------------------' waf.txt
# Wapiti
cd wapiti
python3 wapiti –u http://$userIP -f html -o /root/wapiti.html
cd ..
# whatweb
whatweb -v -a 4 -l --logxml=what.xml $userIP
xsltproc what.xml > whatcms.html
# rapidscan
sudo python2.7 ./rapidscan.py $userIP
 # cd to results directory
 # cat all txt files to output rapid.txt
 sed -i '1i Rapidscan Output\--------------------' rapid.txt
# text file combine
cat waf.txt rapid.txt > outputcms.txt
# local storage ready for upload to client's container
mkdir $udir
mv outputcms.txt /root/$udir/outputcms.txt
mv *.html /root/$udir/
echo " Your results are stored in directory $udir "
sleep 10
