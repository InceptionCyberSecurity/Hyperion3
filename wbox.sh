#!/bin/bash
# whitekbox test with target IP or domain, OS version, device type, installed apps for Archlinux/Blackarch
# Usage ./wbox.sh 8.8.8.8 mydir as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8. UserName search term for Sherlock.
# First argument $1: $usIP user IP
# Second Argument $2: $udir directory to store reports
third argument
fourth argument
fifth argumnet

# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports
dev=  # device type eg ftp server, web server
uos= # OS version eg Ubuntu 20.04, Windows 10
uapps= # array of user apps eg [outlook,apache,]


wbox.sh - for whitebox tetsing with given target and other info like OS/kernel version, open ports, device type.

nmap

zap-cli

blackwidow

wapiti

w3af

skipfish

arachni

sqlmap

wfuzz

grendel-scan

grabber

sonarqube (code review)

Nessus/OpenVAS command line





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
