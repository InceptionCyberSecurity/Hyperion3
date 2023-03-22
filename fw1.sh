#!/bin/bash
# Script for Hyperion v3.x for nmap firewall bypass scans and tests
# Usage ./fw1.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argument $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# nmap vuln on firewall
sudo nmap -vv -p - $userIP --script vuln --script vulners -p - -oX usernmap.xml
xslproc usernmap.xml -o usermapfw.html

# are firewall filters and rules performing as intended? simple Nmap firewall audit
sudo nmap –v -p - –sA –n $userIP –oX fwaudit.xml
xsltproc fwaudit.xml -o fwaudit.html
# The above Nmap TCP ACK scan (-sA) will establish whether packets can pass through your firewall unfiltered. To speed up the scan, the –n
# option can be used to prevent reverse DNS resolution on the active IP addresses it finds. I would also use the –oA output option so you
# create a searchable file as well as an XML file to use for record keeping and reporting. You can use these output files to review the
# traffic flow through any unfiltered ports and then modify your firewall rule sets where necessary.
# One mistake many administrators make when allowing traffic through their firewall is trusting traffic based simply on its source port number,
# such as DNS replies from port 53 or FTP from port 20. To test firewall rules, however, you can use most of Nmap's TCP scans, including the
# SYN scan, with the spoof source port number option (--source-port or abbreviated just to –g). By providing the port number, the network
# mapper will send packets from that port where possible. The following example will run an FIN scan, which will use a spoofed source port
# number of 25 (SMTP) and save the output to file firewallreport.txt. Now you can see if a particular port is allowing all traffic through:

# FIN scan
sudo nmap -p - –sF –g 25 $userIP -oX fin.xml
xsltproc fin.xml -o fin.html

# fragmented traffic bypass firewall
sudo nmap –sS -p - --scan-delay 500 –f $userIP -oX frag.xml
xsltproc frag.xml -o frag.html
clear

# local storage ready for upload to client's container
mkdir $udir
mv usernmapfw.html /$udir/usernmapfw.html.txt
mv fwaudit.html /$udir/fwaudit.html
mv fin.html /$udir/fin.html
mv frag.html /$udir/frag.html
echo " Your results are stored in directory $udir "
sleep 10
