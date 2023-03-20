#!/bin/bash
# Script for Hyperion v3.x for Windows exploit suggester THIS IS FOR PRIVESCS !!
# Usage ./we.sh 8.8.8.8 WinOS mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $ker Windows version
# second argument $2 mydir
# User Input from  command line arguments
winos="$1" # a loose representaion of Windows OS eg windows xp home edition sp2
udir="$2" # directory for reports

# windows-exploit-suggester https://github.com/AonCyberLabs/Windows-Exploit-Suggester
# on victim Windows machine run systeminfo > systeminfo.txt
windows-exploit-suggester --update
# update to Microsoft exploit database
windows-exploit-suggester --database 2021-06-10-mssb.xls --ostext ''$winos'' > wes.txt
sed -i '1i Windows Exploit Code form Janus Tests\n---------------------------------------' wexploit.txt

# local storage ready for upload to client's container
mkdir $udir
mv wexploit.txt /$udir/wexploit.txt
echo " Your results are stored in directory $udir "
sleep 10
