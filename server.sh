#!/bin/bash
# Script for Hyperion v3.x that performs general server tests
# Usage ./server.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argument $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports

# nmap vuln
sudo nmap -vv $userIP --script vuln --script vulners -p - -oX usernmap.xml
xslproc usernmap.xml -o usernmapServer.htm

# OS detection
sudo nmap -vv -O --osscan-guess --fuzzy $userIP -oX os.xml
xsltproc os.xml -o os.html

# servers, service detection
sudo nmap -vv sV --allports --version-all --version-trace $userIP -oX serv.xml
xsltproc serv.xml -o services.html

# local storage ready for upload to client's container
cd /
cd root
mkdir $udir
cd $udir
mv /root/usernmapServer.html /root/$udir/usernmapServer.html
mv /root/os.html /root/$udir/os.html
mv /root/services.html /root/$udir/services.html
echo " Your results are stored in directory $udir "
sleep 10
cd /
cd root
