#!/bin/bash
# Script for Hyperion v3.x that performs VPN tests IKE and pptp
# Usage ./vpn.sh 8.8.8.8 500 mydir - as single command line argument but can use website instead of IP address eg google.com for 8.8.8.8.
# First argument $1: $usIP user IP
# Second Argument $2: $usport VPN port number
# third argumnet $3 mu=ydir
# User Input from  command line arguments
userIP="$1" # IP address eg 8.8.8.8
userport="$2" # user search term
udir="$3" # directory for reports

# iker.py to analyse the security of the key exchange phase in IPsec based VPNs
python iker.py -v -o $userIP > ik.txt
sed -i "1i IKE-Scan that checks for security flaws\n---------------------------------------" ik.txt

# VPN scan script
sudo nmap -sU -p 50, 500, 1701, 1723, 4500, $userport --script ike-version $userIP -oX uservpn.xml
xsltproc uservpn.xml -o uservpnall.html

# IKE VPN fingerprinting test; find valid transformation
ike-scan $userIP --verbose  --showbackoff --patterns /usr/share/ike-scan/ike-backoff-patterns $userIP > uv.txt
cat uv.txt | grep handshake > uvpn.txt
sed -i "1i IKE-SCAN Results\n-------------------" uvpn1.txt

# vuln vulnerability scan
sudo nmap -vv --script vuln --script vulners $userIP -oX usernmap.xml
xsltproc usernmap.xml -o UNmapvpn.html

# pptp vpn scan
sudo nmap -vv -sV 50, 500, 1701, 1723, 4500, $userport --script pptp-version $userIP -oX pptp.xml
xsltproc pptp.xml -o pptp.html

# vuln vulnerability scan
sudo nmap -vv --script vuln --script vulners $userIP -oX usernmap.xml
xsltproc usernmap.xml -o UrNmapVPN.html

# VPN Port check/scan
sudo nmap -sU -p --script ike-version $userport $userIP -oX vpncheck.xml
xsltproc vpncheck.xml -o vpncheck.html

# CISCO ASA SSL VPN scan CVE2014-2128
sudo nmap -vv 50, 500, 1701, 1723, 4500, $userport --script http-vuln-cve2014-2128 $userIP -oX ciscoasa.xml
xsltproc ciscoasa.xml -o ciscoasa.html

# CISCO Anyconnect VPN scan
sudo nmap -vv 50, 500, 1701, 1723, 4500, $userport --script http-cisco-anyconnect $userIP -oX ciscoany.xml
xsltproc ciscoany.xml -o ciscoany.html

# Pulse SSL VPN scan
sudo nmap -n 50, 500, 1701, 1723, 4500, $userport --script http-pulse_ssl_vpn -n $userIP -oXpulse.xml
xsltproc pulse.xml -o pulse.html

# brute force VPN for ID's
ike-scan -P -M -A -n --id=administrator $userIP > fa.txt
cat ik.txt fa.txt | grep handshake > fake.txt
sed -i "1i IKE-SCAN Fake ID Brute Force Results\n -------------------------------------" fake.txt

cat ik.txt uvpn1.txt > outputvpnall.txt

# local storage ready for upload to client's container
mkdir $udir

mv outputvpnall.txt /$udir/outputvpnall.txt
mv uservpnall.html /$udir/uservpnall.html
mv UNmapvpn.html /$udir/UNmapvpn.html
mv pptp.html /$udir/pptp.html
mv UrNmapVPN.html /$udir/UrNmamVPN.html
mv vpncheck.html /$udir/vpncheck.html
mv ciscoasa.html /$udir/ciscoasa.html
mv ciscoany.html /$udir/ciscoany.html
mv /pulse.html /$udir/pulse.html
mv /fake.txt /$udir/fake.txt
echo " Your results are stored in directory $udir "
sleep 10
