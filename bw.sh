#!/bin/bash
# Script for Hyperion v3.x for OWASP BlackWidow webapp scanner
# Usage ./bw.sh 8.8.8.8 443 directory - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argumnet $2 port
# third argumnet $3 directory
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
uport="$2" # target open port
udir="$3" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# Blackwidow
cd BlackWidow
blackwidow -d $userIP -l 5 -s y -v y -p $uport
cd /
cd /usr/share/blackwidow/${userIP}_${uport}
cat *.txt > bw.txt
sed -i '1i BlackWidow OWASP Top 10 Results\n----------------------------------' bw.txt
# blackwidow -u https://target.com - crawl target.com with 3 levels of depth.
# blackwidow -d target.com -l 5 -v y - crawl the domain: target.com with 5 levels of depth with verbose logging enabled.
# blackwidow -d target.com -l 5 -c 'test=test' - crawl the domain: target.com with 5 levels of depth using the cookie 'test=test'
# blackwidow -d target.com -l 5 -s y -v y - crawl the domain: target.com with 5 levels of depth and fuzz all unique parameters for OWASP vulnerabilities with verbose logging on.
# injectx.py -u https://test.com/uers.php?user=1&admin=true -v y - Fuzz all GET parameters for common OWASP vulnerabilities with verbose logging enabled.
# cd ${userdom}_80
# local storage ready for upload to client's container
mkdir $udir
cd $udir
mv bw.txt /$udir/bw.txt
echo " Your results are stored in directory $udir "
sleep 10
