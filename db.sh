#!/bin/bash
# Script for Hyperion v3.x that performs database server tests using SQL cripts and nmap
# Usage ./db.sh 8.8.8.8  mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argument $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# nmap vuln
sudo nmap -vv $userIP --script vuln --script vulners -p - -oX unmap.xml
xslproc unmap.xml -o unmapdb.html
# nmap
sudo nmap -p - --script ms-sql-info --script mysql-databases --script ms-sql-query --script-args mssql.username=sa,mssql.password=sa,ms-sql-query.query="SELECT * FROM master..syslogins" --script ms-sql-empty-password --script ms-sql-hasdbaccess --script ms-sql-tables --script-args mssql.usernam=sa --script ms-sql-xp-cmdshell --script-args mssql.username=sa --script ms-sql-xp-cmdshell --script-args=ms-sql-xp-cmdshell.cmd='net users',mssql.username=sa --script ms-sql-dump-hashes --script-args mssql.username=sa $userIP -oX us.xml
xslproc us.xml -o nmapdb.html
# local storage ready for upload to client's container
mkdir $udir
mv unmapdb.html /$udir/unmapdb.html
mv nmapdb.html /$udir/nmapdb.html
echo " Your results are stored in directory $udir "
sleep 10
