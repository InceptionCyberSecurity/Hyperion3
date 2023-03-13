#!/bin/bash
# Hyperion v3.x by ducatinat nathan.jones@arcadeusops.com; Kali/ArchLinux/Blackarch server where appropriate, otherise Ubuntu
# Docker https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04
# sudo pacman -S docker   sudo systemctl status docker    sudo docker version    sudo systemctl stop docker
export LC_ALL="en_US.UTF-8"
cd /
cd root
echo " Welcome to the Hyperion v3.1 Base Installation Script. This script will install all base requirements and pre-harden up the base server. "
echo " Read the comments in install.sh and decide if you want everything installed. Uncomment any app you do not wish installed, such as fail2ban. "
echo " Ctrl + C to abort. If not installation will automatically proceed within 15 seconds ....... "
# echo " IMPORTANT: Add multilib repos to /etc/pacman.conf before you start and "
# echo " install ArchLinux and BlackArch before you proceed. Happy Hacking!"
sleep 15
clear
# INSTALL BASE REQUITREMENTS
# install archlinux, include blackarch repos then follow https://www.blackarch.org/downloads.html and add multilib /etc/pacman.conf
# https://wiki.archlinux.org/index.php/Official_repositories#Enabling_multilib     DO THIS !!
# DO NOT INSTALL UNTIL ABOVE HAS BEEN DONE! pacman help at https://linuxhint.com/pacman_arch_linux/
# ##########################################################################################################################################################
# sudo pacman -S reflector
# get reflector to generate 30 fatstest mirrors. Change for local server location
# reflector --verbose --country 'France,Germany,Austria,Bulgaria,Denmark,Greece,Hungary,Russia,Sweden,Switzerland,UnitedKingdom,Poland,Netherlands,Estonia,Italy' --fastest 50  --protocol ftp --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist
# sudo pacman -S git docker apparmor wget
# sudo pacman -S sysstat clamav curl
# sudo pacman -S arch-audit nano htop ncdu
# sudo pacman -S libapache2-mod-evasive libapache2-mod-security2
# install Blackarch DO THIS FIRST!!!!!!
# curl -O https://blackarch.org/strap.sh
# echo 8bfe5a569ba7d3b055077a4e5ceada94119cccef strap.sh | sha1sum -c
# chmod +x strap.sh
# sudo ./strap.sh
# sudo pacman -Syu # update all packages
# after install run this but  WILL TAKE A FEW HOURS  =>   sudo pacman -S blackarch, then, sudo pacman -Syu
# update lynis
# git clone https://github.com/CISOfy/lynis
# when running  cd lynis  then  ./lynis audit system
sudp apt install git docker apparmor wget clamav curl nano htop ncdu libapache2-mod-evasive libapache2-mod-security2 python3-pip
chmod +x get-pip.py
python get-pip.py
# tecmint monitor
# wget https://tecmint.com/wp-content/scripts/tecmint_monitor.sh
# chmod 755 tecmint_monitor.sh
# ./tecmint_monitor.sh -i
# INSTALL SECURITY REQUIREMENTS to harden up base server
# Lynis already installed in Archlinux but not latest update => lynis audit system
sudo apparmor_status > apparmor.txt # look at this after install
# Apparmor logs to /var/log/syslog
# dmseg | grep -i 'apparmor.*denied' /var/log/syslog > apparmor_denied # use this to truncate syslog
# RAT detection
sudo apt install chkrootkit
chkrootkit > rtest.txt
cat rtest.txt | grep found > rootkit.txt
# arch audit
# arch-audit > aaudit.txt
# artillery honeypot
# sudo git clone https://github.com/BinaryDefense/artillery/ artillery/
# cd artillery
# python3 setup.py # answer Yes to all three questions
# configure Artillery as below
# nano /var/artillery/config
# change MONITOR_FOLDERS=”/var/www”,”/etc”,"/etc/passwd","/etc/shadow","/root"  for folders to be monitored
# change EXCLUDE="" for folders not monitored
# WHITELIST_IP=127.0.0.1,localhost,xxx.xxx.xxx.xxx <-Replace the x's with VPN IP address.
# PORTS="135,445,22,21,25,53,110" for ports to be honeypotted
# AUTO_UPDATE=ON
# ANTI_DOS_PORTS=22,80,443,1194
# ANTI_DOS=ON
# cd ..
# python restart_server.py
# to reset baned IP    cd /var/artilley  and run  ./reset-bans.py xxx.xxx.xxx.xxx
# ClamAV malware scanner https://ourcodeworld.com/articles/read/885/how-to-install-clamav-and-scan-for-viruses-with-the-command-line-cli-in-ubuntu-16-04
# sudo systemctl stop clamav-freshclam
# sudo freshclam
# sudo systemctl start clamav-freshclam
# sudo clamscan -i --detect-pua=yes -r / # manual scan
# configure then stop apache2 select No configuration or Local only for mail
# sudo nano /etc/apache2/mods-enabled/evasive.conf the follow https://phoenixnap.com/kb/apache-mod-evasive
# /etc/apache2/mods-enabled/security2.conf follow https://www.linuxbabe.com/security/modsecurity-apache-debian-ubuntu
sudo systemctl start apache2
sudo a2enmod security2
sudo systemctl disable apache2 && sudo systemctl stop apache2
sudo systemctl stop postfix
# prevent postfix from booting https://duckduckgo.com/?q=prevent+postfix+from+starting+at+boot&t=newext&atb=v268-1&ia=web
sudo update-rc.d postfix disable # to restart at boot sudo update-rc.d postfix enable. logs in /var/logs/mod_evasive
# iptables
sudo systemctl start iptables.service
# install UFW and configure https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-20-04
# sudo apt install ufw
# systemctl enable ufw
# sudo ufw default deny incoming
# sudo ufw default allow outgoing
# sudo ufw allow https # for API from front end
# sudo ufw allow 443 # for API from front end
# sudo ufw allow ssh
# sudo ufw allow 1965 # CHANGE TO UNUSUAL SSH PORT for added security
# sudo ufw allow from xxx.xxx.xxx.xx USE FOR VPN ACCESS ONLY
# sudo ufw enable
# run sudo ufw status verbose to check ufw is running after install
# sudo ufw reset
# fail2ban https://www.howtogeek.com/675010/how-to-secure-your-linux-computer-with-fail2ban/
# sudo apt install fail2ban
# sudo pacman -S -Syu
# sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
# sudo nano /etc/fail2ban/jail.local and edit according to instructions in howtogeek.com above
# sudo systemctl enable fail2ban
# sudo systemctl restart fail2ban
# test according to instructions in howtogeek.com above
# ssh key exchange rather than password at a later date ??
# END OF BASE and Security Install, contnued from baseinst31.sh
# VULNERABILITY REQUIREMENTS
git clone https://github.com/1N3/BlackWidow.git
cd BlackWidow
sudo bash install.sh
cd /
cd root
# THIS IS FOR OWASP ZAP headless
# OWASP ZAP command line https://www.zaproxy.org/docs/desktop/cmdline/
# zap-cli https://github.com/Grunny/zap-cli to setup $PATH and configure
# USAGE zap-cli quick-scan --self-contained --spider -r -s xss http://127.0.0.1/
# Need API key ???
pip install --upgrade zapcli
# spiderfoot OSINT
# git clone https://github.com/smicallef/spiderfoot.git
# cd spiderfoot
# pip3 install -r requirements.txt
# cd ..
# reconFTW https://github.com/six2dez/reconftw#a-in-your-pcvpsvm ./reconftw.sh -d target.com -a -o /root/RFTW
git clone https://github.com/six2dez/reconftw
cd reconftw/
./install.sh
cd ..
# sn1per https://github.com/1N3/Sn1per
git clone https://github.com/1N3/Sn1per
cd Sn1per
sudo ./install.sh
cd ..
echo "Hyperion 3.1 system installation is complete. Updating all ... "
sleep 5
sudo nmap --script-update
sudo nmap --script-updatedb
sudo pacman -Syu
echo ""
echo " Hyperion v3.1 full installation and server hardening has completed. "
echo " Server is now ready to reboot. Before completing install you need to :- "
echo " "
echo " Run Lynis audit report after full installation (lynis audit system). "
echo " Lynis report in /var/log/lynis-report.log. Do what Lynis suggests!"
echo " "
echo " Look at apparmor.txt and /var/log/syslog to confirm in complain mode."
echo " "
# echo " Run sudo ufw status verbose to check ufw is running after install. "
# echo " "
# echo " Edit /var/artillery/config and change to your liking. "
# echo " "
# echo " Test fail2ban is running after tweaking jail.local. "
# echo " "
echo " Copy Hyperion v3.1 scripts from HyperionV31 Github repo to "
echo " /root, then chmod +x *.sh, chmod +x *.py. Happy hacking! Rebooting now ....... "
sleep 5
sudo reboot
