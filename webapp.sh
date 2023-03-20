#!/bin/bash
# Script for Hyperion v3.x that performs tests on webapp using nmap, SQLMap, OWASPZAP, RapidScan
# Usage ./webapp.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argumentt $2 mydir
# third argument $3 page to attack
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8 or domain name
udir="$2" # directory for reports
logon="$3" # logon page to attack

# nmap vuln
sudo nmap -vv $userIP --script vuln --script vulners --script http* -p - -oX usernmap.xml
xslproc usernmap.xml -o usermapWebApp.html

# sqlmap
sqlmap -v -u "https://$userIP/$logon" -a --level=5 --risk=5 > sqli.txt
cat sql1.txt | grep 'ssl\|SSL\|OSVDB\|enabled\|open\|Server\|Running\|OS\|Target\|tcp\|udp\|interesting\|XSS\|Heartbleed\|Shellshock\|EternalBlue\|VULNERABLE\|vulnerable\|login\|admin\|CVE\|SSL\|DIRECTORY\|200\|E' > sql.txt
sed -i '1i SQLi Vulnerability\n --------------------' sqli.txt

# ZAP comamnd line SQLi XSS
zap-cli quick-scan -s xss,sqli,csrf --spider -r -e "some_regex_pattern" --report zapcli.html $userIP
zap-cli report -o ZAP.html -f html

# RapidScan Web App vuln scanning
./rapidscan.py --update
rm RS-Vulnerability-Report
python rapidscan.py $userIP
mv RS-Vulnerability-Report rapid.txt
sed -i '1i RapidScan Comprehensive Scan Results Results\n------------------------------------------------' rapid.txt

# local storage ready for upload to client's container
mkdir $udir

mv /usermapWebApp.html /$udir/usermapWebApp.html
mv sqli.txt /$udir/sqli.txt
mv ZAP.html /$udir/ZAP.html
mv rapid.txt /$udir/rapid.txt
echo " Your results are stored in directory $udir "
sleep 10
