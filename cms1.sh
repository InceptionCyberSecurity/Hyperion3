#!/bin/bash
# Script for Hyperion v3.x that performs Wordpress scans
# Usage ./cms1.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argumnet $2 my dir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports

# WAF
wafw00f $userIP > w.txt
cat w.txt | grep WAF > waf.txt
sed -i '1i WafWoof Results\n----------------------' waf.txt

# Wordpress
wpscan --url $userIP > p.txt
cat p.txt | grep users > wp.txt
sed -i '1i WPScan Results\n----------------------' wp.txt

wpscan --url $userIP --enumerate u > w1.txt
cat w1.txt | grep users > wp1.txt
sed -i '1i WPScan Users Results Users\n------------------------------' wp1.txt

wpscan --url $userIP --enumerate p > w2.txt
cat w2.txt | grep plugins > wp2.txt
sed -i '1i WPScan Plugins Results Plugins\n-----------------------------' wp2.txt

wpscan --url $userIP --enumerate t > w3.txt
cat w3.txt | grep theme > wp3.txt
sed -i '1i WPScan Themes Results Themes\n----------------------------' wp3.txt

# whatweb
whatweb -v -a 4 -l --logxml=what.xml $userIP
xsltproc what.xml > whatcms1.html

# text file combine
cat waf.txt wp.txt wp1.txt wp2.txt wp3.txt > outputcms1.txt

# local storage ready for upload to client's container
mkdir $udir
mv outputcms1.txt /$udir/outputcms1.txt
mv whatcms1.html /$udir/whatcms1.html
echo " Your results are stored in directory $udir "
sleep 10
