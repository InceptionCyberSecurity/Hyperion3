#!/bin/bash
# Script for Hyperion v3.x that performs SMTP server tests
# Usage ./mail1.sh 8.8.8.8 S mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argument $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# nmap vuln
sudo nmap -vv $userIP --script vuln --script vulners -p - -oX usernmap.xml
xslproc usernmap.xml -o usermapsmtpvul.html

# SMTP
sudo nmap -vv -p - --script=smtp* $userIP -oX usernmap2.xml
xslproc usernmap2.xml -o usermapsmtp.html

# SMTP user enumeration (RCPT TO and VRFY), internal spoofing, and relay.
smtp-user-enum -v -M VRFY -U commonusers.txt -t $userIP > smtp.txt

cat smtp.txt | grep exists smtp1.txt
sed -1 '1i SMTP Mail Server Output\n---------------------------' ismtp1.txt
cd ..

# local storage ready for upload to client's container
mkdir $udir
mv usermapsmtpvul.html /$udir/usermapsmtpvul.html
mv usermapsmtp.html /$udir/usermapsmtp.html
mv smtp1.txt /$udir/smtp1.txt
echo " Your results are stored in directory $udir "
sleep 10
