#!/bin/bash
# Script for Hyperion v3.x for SSL vulns POODLE and DROWN
# Usage ./dr.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argumnet $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports

sudo sudo nmap -sV --script=sslv2-drown $userIP -oX dr.xml
xsltproc dr.xml -o drown.html

sudo nmap -sV --version-light --script ssl-poodle -p 443 $userIP -oX po.xml
xsltproc po.xml -o poodle.html

# local storage ready for upload to client's container
cd /
cd root
mkdir $udir
cd $udir
mv /root/drown.html /root/$udir/drown.html
mv /root/poodle.html /root/$udir/poodle.html
echo " Your results are stored in directory $udir "
sleep 10
cd /
cd root
