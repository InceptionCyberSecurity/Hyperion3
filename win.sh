#!/bin/bash
# Script for Hyperion v3.x that performs NetBIOS, SMB, USer Accounts, and backdoor tests on Windows servers
# Usage ./win.sh 8.8.8.8 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# second argument $2 mydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
udir="$2" # directory for reports
echo " "
echo " The script is running and may take a while ............"
echo " "
# SMB OS discovery SMB signing check smb vulnerability scripts SMB brute force
sudo nmap -p 139, 445 --script smb-os-discovery --script smb-security-mode --script smb-vuln-* --script smb-brute -–script-args userdb=common_pass.txt,passdb=common_users.txt $userIP -oX smb.xml
xsltproc smb.xml -o smb.html

# IIS web server name disclosure  MS08-067 (netapi) vulnerability check MS08-067 (netapi) vulnerability check
sudo nmap -p 80, 445 --script http-iis-short-name-brute --script smb-vuln-ms08-067 --script smb-vuln-ms08-067 $userIP -oX api.xml
xsltproc api.xml -o api.html

# Netbios and MAC address lookup
sudo nmap -sU -p 137 --script nbstat $userIP -oX net.xml
xsltproc net.xml -o net.html

# Enumerating user accounts Enumerating window shares
sudo nmap -p 139, 445 --script smb-enum-users --script smb-enum-shares –script-args smbusername=vagrant,smbpassword=vagrant $userIP -oX enum.xml
xsltproc enum.xml -o enum.html

# Detecting shadow brokers double pulsar smb
sudo nmap -p 445 --script smb-double-pulsar-backdoor -oX pulsar.xml $userIP -vv
xsltproc pulsar.xml -o pulsar.html

# rdpscan CVE-2019-0708 bluekeep vuln
#sudo ./rdpscan $userIP > rdp.txt
#cat rdp.txt | grep vulnerable > rdp1.txt
#sed -i '1i Windows SMB, RDP BlueKeep Assessment\n----------------------------------' > rdp1.txt

# nmap vuln
sudo nmap -vv $userIP --script vuln --script vulners -p - -oX vuln.xml
xsltproc vuln.xml -o vuln.html

# local storage ready for upload to client's container
mkdir $udir
mv smb.html /$udir/smb.html
mv api.html /$udir/api.html
mv net.html /$udir/net.html
mv enum.html /$udir/enum.html
mv pulsar.html /$udir/pulsar.html
mv vuln.html /$udir/vuln.html
#mv /root/rdp1.txt /root/$udir/rdp1.txt
echo " Your results are stored in directory $udir "
sleep 10
