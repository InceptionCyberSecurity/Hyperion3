#!/bin/bash
# blackbox test with IP or domain only for Archlinux/Blackarch
# Usage ./bbox.sh 8.8.8.8 mydir as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8. UserName search term for Sherlock.
# First argument $1: $usIP user IP or domain name
# Second Argument $2: $udir directory to store reports
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8 or google.com
udir="$2" # directory for reports 

# nmap aggressive vulnerability scan
sudo nmap -vv -p- -A -T4 --script vuln --script http* --script malware --script safe --script dos --script discovery --script exploit --script brute $userIP -oX ntest.xml
xsltproc ntest.xml -o ntest.html

# zap-cli https://github.com/Grunny/zap-cli
zap-cli quick-scan -s xss,sqli --spider -r -e "some_regex_pattern" http://$userIP

# blackwidow
blackwidow -d target.com -l 5 -s y -v y - # crawl the domain: target.com with 5 levels of depth and fuzz all unique parameters for OWASP vulnerabilities with verbose logging on.

# wapiti report in html
python wapiti -u http://$userIP/

# skipfish
skipfish -o $udir http://$userIP/

# sqlmap
sqlmap -u "http://$userIP/?p=1&forumaction=search" --dbs

# wfuzz
wfuzz -c -z file,/usr/share/wfuzz/wordlist/general/common.txt --hc 404 http://$userIP/FUZZ

# grabber
grabber –spider 1 –sql –xss –url http://$userIP





bbox.sh - for blackbox tetsing with IP/doman name only known.



# local storage ready for upload to client's container
cd /
cd root
mkdir $udir
mv /root/shellshock.html /root/$udir/shellshock.html
mv /root/shellshock1.html /root/$udir/shellshock1.html
echo " Your results are stored in directory $udir "
sleep 10
cd /
cd root
