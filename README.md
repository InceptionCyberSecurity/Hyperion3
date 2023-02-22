# Hyperion v3.1 For Archlinux/Blackarch or Kali. Can be used in Ubuntu with changes given in Comments.
Install ArchLinux, then convert to BlackArch, see https://www.blackarch.org/downloads.html, or use Kali Linux in VirtualBox.
Backend scripts used to drive results-based automated IT Security system for arcadeusops.com. Written in Bash and Python3.
Written by Nathan Jones nathan.jones@arcadeusops.com

ins31.sh is the install script but edit to suit your preferences.
test.sh is a short script to confirm all is working ok.

# Usage
* Most scripts take two command line arguments, the IP address or domain name, and directory to store reports.
* For example ./server mysite.com mydirectory. See READMEscripts.md for details of command line arguments.
* Reports are in a custom directory which is displayed at command prompt after completion.

# Hyperion v3.1 Scripts

# Python port scanner
pythonscan.sh follow on screen prompts

# Vulnerabilities
exploit.sh - nmap and searchsploit (exploitdb) for exploit discovery.
le.sh - Linux exploit suggester.
we.sh - Windows exploit suggester.
back.sh - tests for ShellShock and HeartBleed issues as well as testing VNC and CITRX setups for backdoors/malware.

# Firewall
firewall.sh - firewall fingerprinting and WAF detection using nmap and WAFWoof.
fw1.sh - firewall bypass test and firewall rules detection using nmap.

# Servers
cloud.sh - uses nmap to test any cloud server.
db.sh -  test any database server for vulnerabilities via nmap. (See webapp.sh for SQLmap tests)
ftp.sh - nmap tests for any FTP server.
mail.sh - POP mail server tests with nmap.
mail1.sh - SMTP mail server tests nmap and ismtp.
server.sh - nmap test for Linix/Windows servers in general.
win.sh -  NetBIOS, SMB, User Accounts, and backdoor tests on Windows servers.
win1.sh - performs tests on AD/LDAP Windows servers.

# Content Management Systems
cms.sh -  performs general CMS tests using WafWoof and Wapiti not listed below, such as SilverStripe.
cms1.sh - WordPress scans.
cms2.sh - Joomla tests.
cms3.sh - Drupal tests.

# Malware
mal.sh - malware attack vector detection using nmap detection methods.

# VPN
vpn.sh - performs tests on VPNs using IKE and PPTP protocols.

# DOS Attacks (Stress Testing)
DOS.sh - uses pyflooder.py to perform HTTP Flood DOS attacks.
DOS1.sh - searches for possible DOS vector attack surfaces using nmap.

# Web Apps
webapp.sh - Web Apps tests using nmap, SQLMap, OWASP ZAP , and RapidScan.
uni.sh - uses Uniscan to discover LFI RFI and RCE vulnerabilities on Web Apps.
bw.sh - vulnerability assessment for Web Apps using OWASP BlackWidow.
websec.sh - Golismero web security scan

# Crypto
dr.sh - nmap scripts to test for SSL vulnerabilities of POODLE and DROWN.

## Ethical Notice
The original code is written by ArcadeusOPS, who are not responsible for misuse of this data gathering tool. Do not use these scripts to navigate websites/devices that take part in any activity that is identified as illegal under the laws and regulations of your government. STAY LEGAL !!

## License
MIT License
Copyright (c) ArcadeusOPS

# TODO Future Test Scripts in Bash, Python, Lua or C++
simlink attacks https://www.anvilventures.com/blog/defeating-secure-boot-with-symlink-attacks.html
VPS tests https://blog.eldernode.com/how-to-test-security-of-vps/ and https://www.anvilventures.com/blog/defeating-secure-boot-with-symlink-attacks.html
APIs eg Shodan https://nmap.org/nsedoc/scripts/shodan-api.html
Vulnerability Analysis using Nessus and OpenVAS via command line
DNS Servers --script dns* or finalrecon. Possibly add dedicated OSINT script.
Buffer Overflow nmap exploit script for Windows Server/IIS  eg  https://exploit.kitploit.com/2017/04/ms-iis-60-buffer-overflow-nse-script.html
Keylogger detection eg https://thegeekpage.com/detect-keylogger-rat/
Remote Access Trojan RAT detection eg https://redcanary.com/blog/detecting-remote-access-trojan/ and https://github.com/nict-csl/NanoCoreRAT-Analysis
Include OSINT scripts ??

# Server Setup
SSH private key exchange rather than public key/password logon

# UPDATES
Lynis see https://docs.nextcloudpi.com/en/how-to-update-lynis/
