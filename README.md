# Hyperion v3.1 For Archlinux/Blackarch or Kali (recommended).
Install ArchLinux, then convert to BlackArch, see https://www.blackarch.org/downloads.html, or use Kali Linux in VirtualBox. <br/>
Backend scripts used to drive results-based automated IT Security system for arcadeusops.com. Written in Bash and Python3. <br/>
Written by Nathan Jones nathan.jones@arcadeusops.com <br/>
ins31.sh is the install script but edit to suit your preferences.<br/>
test.sh is a short script to confirm all is working ok. <br/>

# Usage
* Most scripts take two command line arguments, the IP address or domain name, and directory to store reports. <br/>
* For example ./server mysite.com mystuff . See READMEscripts.md for details of command line arguments. <br/>
* Reports are in a custom directory which is displayed at command prompt after completion. <br/>

# Hyperion v3.1 Scripts
# Python port scanner
pythonscan.sh follow on screen prompts

# Vulnerabilities
exploit.sh - nmap and searchsploit (exploitdb) for exploit discovery. <br/>
le.sh - Linux exploit suggester. <br/>
we.sh - Windows exploit suggester. <br/>
back.sh - tests for ShellShock and HeartBleed issues as well as testing VNC and CITRX setups for backdoors/malware. <br/>

# Run All
runall.sh - customise what scripts you want by running this single command line input. incomplete; in development. <br/>

# Firewall
firewall.sh - firewall fingerprinting and WAF detection using nmap and WAFWoof. <br/>
fw1.sh - firewall bypass test and firewall rules detection using nmap. <br/>

# Servers
cloud.sh - uses nmap to test any cloud server. <br/>
db.sh -  test any database server for vulnerabilities via nmap. (See webapp.sh for SQLmap tests) <br/>
ftp.sh - nmap tests for any FTP server. <br/>
mail.sh - POP mail server tests with nmap. <br/>
mail1.sh - SMTP mail server tests nmap and ismtp. <br/>
server.sh - nmap test for Linix/Windows servers in general. <br/>
win.sh -  NetBIOS, SMB, User Accounts, and backdoor tests on Windows servers. <br/>
win1.sh - performs tests on AD/LDAP Windows servers. <br/>

# Content Management Systems
cms.sh -  performs general CMS tests using WafWoof and Wapiti not listed below, such as SilverStripe. <br/>
cms1.sh - WordPress scans. <br/>
cms2.sh - Joomla tests. <br/>
cms3.sh - Drupal tests. <br/>

# Malware
mal.sh - malware attack vector detection using nmap detection methods. <br/>

# VPN
vpn.sh - performs tests on VPNs using IKE and PPTP protocols. <br/>

# DOS Attacks (Stress Testing)
DOS.sh - uses pyflooder.py to perform HTTP Flood DOS attacks. <br/>
DOS1.sh - searches for possible DOS vector attack surfaces using nmap. <br/>

# Web Apps
webapp.sh - Web Apps tests using nmap, SQLMap, OWASP ZAP , and RapidScan. <br/>
uni.sh - uses Uniscan to discover LFI RFI and RCE vulnerabilities on Web Apps. <br/>
bw.sh - vulnerability assessment for Web Apps using OWASP BlackWidow. <br/>
websec.sh - Golismero web security scan. <br/>

# Crypto
dr.sh - nmap scripts to test for SSL vulnerabilities of POODLE and DROWN. <br/>

## Ethical Notice
The original code is written by ArcadeusOPS, who are not responsible for misuse of this data gathering tool. <br/>
Do not use these scripts to navigate websites/devices that take part in any activity that is identified as illegal under the laws and regulations of your government. STAY LEGAL !!<br/>

## License
MIT License
Copyright (c) ArcadeusOPS

# TODO Future Test Scripts in Bash, Python, Lua or C++
simlink attacks https://www.anvilventures.com/blog/defeating-secure-boot-with-symlink-attacks.html <br/>
Vulnerability Analysis using Nessus and OpenVAS via command line <br/>
Keylogger detection eg https://thegeekpage.com/detect-keylogger-rat/ <br/>

# Server Setup
SSH private key exchange rather than public key/password logon

# UPDATES
Lynis see https://docs.nextcloudpi.com/en/how-to-update-lynis/

# Bugs
Send issues to info@arcadeusops.com stating nature of issue. A screenshot will help too. Thanks.

# CPD
Part of EC-Council ECE/CPD Credits
