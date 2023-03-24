#!/bin/bash
# Script for Hyperion v3.x that performs tests on AD/LDAP on Windows devices
# Usage ./win1.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argument $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# convert IP short form
# userIP=$(dig $usIP +short)
# echo "Your IP address is: " $userIP # for testing only remove for headless operation
# echo ""
# sleep 10
# find active directory; enumerate domains
sudo nmap -vv -sU -sS -sV --script smb-enum-domains.nse --script smb-enum-domains.nse -p 389, 445, U:137, T:139 $userIP -oX unmap.xml
xsltproc unmap.xml -o unmapAD.html
# LDAP search
sudo sudo nmap -p 389 --script ldap-search --script-args 'ldap.username="cn=ldaptest,cn=users,dc=cqure,dc=net",ldap.password=ldaptest,
ldap.qfilter=users,ldap.attrib=sAMAccountName' $userIP -oX usernmap.xml
xsltproc usernmap.xml -o usernmapLDAP.html
sudo nmap -p 389 --script ldap-search --script-args 'ldap.username="cn=ldaptest,cn=users,dc=cqure,dc=net",ldap.password=ldaptest,ldap.qfilter=custom,ldap.searchattrib="operatingSystem",ldap.searchvalue="Windows *Server*",ldap.attrib={operatingSystem,whencreated,OperatingSystemServicePack}' $userIP -oX umap1.xml
xsltproc umap1.xml -o umapLDAP1.html
# nmap vuln
sudo nmap -vv $userIP --script vuln --script vulners -p - -oX usernmap2.xml
xslproc usernmap2.xml -o usermapvulnWIN.html
# local storage ready for upload to client's container
mkdir $udir
mv runmapAD.html /$udir/unmapAD.html
mv usermapLDAP.html /$udir/usermapLDAP.html
mv umapLDAP1.html /$udir/umapLDAP1.html
mv usernmapvulnWIN.html /$udir/usernmapvulnWIN.html
echo " Your results are stored in directory $udir "
sleep 10
