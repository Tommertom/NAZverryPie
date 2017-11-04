#!/bin/bash
# NAZverryPie NAS installation script - Copyright (c) 2014 TomGrun
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
#
#  N A Z v e r r y P i e  - a friendlier installation script for RPI
#
# NAZverryPie installation script to turn your Raspberry Pi onto a NAS
# almost totally unattended. The NAS will be a home-type of
# NAS, mostly supporting nice user applications. So unlike FreeNAS etc.
# This type of NAS is most likely to be used by people wanting to try
# the Pi as replacement of the Synology home models for simple home use.
#
# Currently features the following modules:
# - NZBget
# - ownCloud
# - domoticz
# - Samba
# - OpenVPN
# - Small tools: vsftp, rsync
# - Ajent, duckdns, Tonido, openvpn, sonos controller
# - Simple wrapper page in HTML to access the modules and add your own components
#
# Tested against:
#    Raspberry Pi B+
#
# Prerequisites:
#	- Raspberry Pi
#	- Debian Wheezy installed from raspberrypi.org image repository and rapi-config completed (FS expanded)
#	- Internet connection for the Pi
#	- about 2 hours of time
#
# How to use:
#	- Write the debian image to your SD card and boot the RPI with it
#	- SSH to RPI and login as pi
#	- run raspi-config and expand the FS, then reboot
#	- wget  https://sourceforge.net/p/nazverrypie/code/ci/master/tree/nazverrypie.sh?format=raw -O nazverrypie.sh
#	- sudo bash nazverrypie.sh or sudo bash -x nazverrypie.sh if you like to see the commands going
#	- open another SSH and tail -f /home/pi/install.log
#	- enter the parameters requested
#
# Future plans: 
#		
#		TWEAKING
#		Raspi stripping (http://sirlagz.net/tag/raspbian-server-edition/)
# 		tuning of pi (memory, cpu), tempfs usage
# 		add monit for domoticz http://www.domoticz.com/wiki/Monitoring_domoticz?
#		adding initial users?
#		Get rid of all the sudo commands and make it one sudo only
#		
#		Discarded ideas:
#		Rsync webui https://sourceforge.net/projects/backupmon/   -> no linkages to CRON
#		Single Signon  --> too much work
#		wordpress (http://www.raspberrypi.org/learning/web-server-wordpress/)?  --> don't want to have it run as webserver to the outside
#		timecapsule (https://raymii.org/s/articles/Build_a_35_dollar_Time_Capsule_-_Raspberry_Pi_Time_Machine.html)? 
#		grive -> requires xwindows
#		Consider open media vault to cancel this project :) -> answer: NO, not flexible enough
#		spindown of HDD -> Kernel rebuild
# 		figure out abandonware Baked Linux Mod - Easily install servers & other software -> better wait for user feedback
#		replace apache by nginx? http://www.howtoforge.com/installing-nginx-with-php5-and-mysql-support-on-debian-squeeze -> too much work
#		via LEMP stack? https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-debian-7  -> too much work
#
#	C R E D I T S
#	
# This software uses many goodies out there on the web. Many well constructed and documented software provided.
# Special thanks to all the dedicated developers and users sharing their knowledge. During the construction
# of this software I tried to include the relevant websources as much as possible. If you feel like I have
# been using your knowledge, but have forgotten to acknowledge this: apologies and please let me know through the 
# forum on raspberrypie.org.
#
# Special thank you for all the users, experts and noobs on stackoverflow.com. I have been a regular visitor
# of this extremely useful site. So often, that it is not doable to include this in the source code.
#
#	
#
#

############# begin script ##############

# should always run as sudo
if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

# clear the variables, logs and helper files
sudo rm /home/pi/install.log &> /dev/null
menuitems=""
configitems="" 
installsummary=""
sudo rm stdin2percentagecounts.txt &> /dev/null

# installscript
rm /home/pi/nazpinstall.sh &> /dev/null
echo "#!/bin/bash" >> /home/pi/nazpinstall.sh
chmod 777 /home/pi/nazpinstall.sh

#
# start the interaction
#
# Welcome message
FUN=$(cat <<EOF
N A Z v e r r y P i e  - a friendlier installation script for RPI
\n
NAZverryPie installation script to turn your Raspberry Pi onto a NAS almost totally unattended. The NAS will be a home-type of NAS, mostly supporting nice user applications. So unlike FreeNAS etc. This type of NAS is most likely to be used by people wanting to try the Pi as replacement of the Synology home models for simple home use.
\n
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND
\n
(C) TomGrun - MIT License
\n
Please note, you need to have your FS expanded before runing this tool (and reboot). 
\n
Please select your next step. Press ESC to leave.
EOF
)

whiptail --yesno "$FUN" --yes-button "Continue" --no-button "Run raspi-config" 20 70 3>&1 1>&2 2>&3
input=$?
if [ "$input" = "255" ]; then exit; fi
if [ "$input" = "1" ]; then 
	sudo raspi-config
	sudo reboot
fi

# Get the package list if everything is ok
requestedpackages=$(whiptail --checklist --backtitle "N A Z v e r r y P i e - with Cream"  --title "Package selection" "Please select the packages to install." 0 0 12 \
               fstabwizard "Run FSTAB wizard to configure devices" on \
			   cleanpie "Clean the Pi of stuff (Xwindows etc.)" on \
			   webcamftp "Setup webcam with FTP users" on \
			   openvpn "OpenVPN (interactive install)" on \
			   customlinks "Configure menu items (e.g. router, google, etc.)" on \
			   owncloud "ownCloud personal cloud" on  \
               tonido "Tonido personal cloud" on  \
               vsftp "vsFTP daemon"   on   \
               mysql "MySQL (interactive install)"   on  \
               phpmyadmin "phpmyadmin (interactive install)"   on  \
               domoticz "Domoticz domotica"    on  \
               nzbget "NZBget"   on \
               samba "Samba"   on \
               minidlna "miniDLNA"   on \
			   webmin "webmin admin tool (ajenti preferred)" off \
			   ajenti "Ajenti admin tool (preferred over webmin)" on \
			   piwebagent "Pi Web Agent" on \
			   youtubedl "Youtube downloader" on \
			   sonos "SONOS web controller (including node.js)" on \
			   rsync "Rsync"   on 3>&1 1>&2 2>&3)
	   
#
# Now the changes will start, first some preparations
#

# prepare the samba config addition file
sudo rm /home/pi/smbconfigtail.conf &> /dev/null
cat <<EOF > /home/pi/smbconfigtail.conf

#### Sections added by NAZverryPie installer script

[WWW-ROOT]
path = /var/www
browseable=Yes
writeable=Yes

create mask=0777
directory mask=0777


EOF

# add the progress indicator script
sudo rm /home/pi/stdin2percentage.sh &> /dev/null
cat << 'EOF' > stdin2percentage.sh
#!/bin/bash
#
# Whipstreamprogress bar
# Show progress in whiptail gauge using counter on stdin and lines
# Part of NAZverryPie package
#
# COPYRIGHT
#
#
# Input
# $1 : number of lines expected in the stream
# $2 : logfile to redirect stdin to
# $3 : if y then it will output the counted lines to stdin2percentage.txt
#
# Output
# percentage for whiptail gauge 
#
# Usage in script:
# <process producing stdout> | whipstreamprogress.sh <linecount> <logfile> | whiptail --gauge <text> <heigth> <width>
#
linecount=0
totallines=$1

while read LINE; do
        echo "$LINE" >> $2
        linecount=$((linecount + 1))
        percentage=$(($linecount * 100 / $totallines))
        echo "$percentage"
done

# debugging purposes, to store the linecount for the specific process
if [ "$3" = "y" ]; then 
	echo "$(date) -> $linecount" >> stdin2percentagecounts.txt 
fi

echo "END-OF-STEPS $(date) >> $2"

EOF

# change to executable
sudo chmod 700 stdin2percentage.sh

#
# the IP adress of the RPI (taken from http://stackoverflow.com/questions/6829605/putting-ip-address-into-bash-variable-is-there-a-better-way)
#
# first try to find on the fixed ethernet, otherwise a wlan
ip=$(ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1)
 
# is it there, if not, try the wlan adapter
if [ -z "$ip" ]; then
     ip=$(ip -f inet -o addr show wlan0|cut -d\  -f 7 | cut -d/ -f 1)
fi
# and if everything is failing, ask for the ip
if [ -z "$ip" ]; then
	ip="127.0.0.1"
fi

#ask for confirmation
ip=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "IP configuration" "Confirm the IP adress (or hostname) for the Pie" 0 0 "$ip" 3>&1 1>&2 2>&3)
configitems+="\n\n\$nazverrypie['ip']='$ip';\n"

# the stylesheet
configitems+="\$nazverrypie['css']='nazverrypie.css';\n"

# Run the FSTAB wizard if requested
if [[ $requestedpackages == *fstabwizard* ]]; then
	sudo wget https://sourceforge.net/p/fstabwizard/code/ci/master/tree/fstabwizard.sh?format=raw -O fstabwizard.sh &> /dev/null

	# run it and ask for SAMBA entries
	bash fstabwizard.sh /home/pi/smbconfigtail.conf 
	
	# enfore mounting of fstab
	sudo mount -a &> /dev/null
fi

#
# Begin of userinteraction for configuration of the selected packages
# Will fill installsummary with a nice string to display the results of the configuration to be confirmed by the user
#
#
# Configure the HTML wrapper
#
titlename=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "HTML Wrapper" "Enter the name for the NAS" 10 50 "My NAZverryPie" 3>&1 1>&2 2>&3)
configitems+="\$nazverrypie['titlename']='$titlename';\n"
installsummary+="- Your homebrew NAZverryPie named $titlename\n"

#
# Personal webitems
#
if [[ $requestedpackages == *customlinks* ]]; then
	wantsitems=0
	
	whiptail --msgbox --backtitle "N A Z v e r r y P i e - with Cream" --title "Custom menu items" "Now going to ask you for all menu items to custom URLs you would like to add to the menu. First give the menu name and then the URL.\nPlease press ENTER to continue or ESC to cancel." 22 73
	
	# do it untilfinished
	while [ $wantsitems = 0 ]; do
		# ask the 
		itemlabel=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "Custom menu items" "Enter label for menu item" 10 50 "My Menu Item" 3>&1 1>&2 2>&3)
		itemurl=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "Custom menu items" "Enter URL to menu item (including HTTP or HTTPS!)" 10 50 'http://www.raspberrypi.org' 3>&1 1>&2 2>&3)

		# add the link
		menuitems+="\$menu_url['$itemlabel']='$itemurl';\n\$menu_class['$itemlabel']='text';\n\$menu_text['$itemlabel']=\"$itemlabel\";\n"
		
		# want more?
		whiptail --yesno "Do want to configure another menu item?" --yes-button "Yes" --no-button "No" 0 0 
		wantsitems=$?
	done
fi
#
# End Personal webitems
#


#
# IP camera's using FTP to store
#
if [[ $requestedpackages == *webcamftp* ]]; then
     wantsitems=0
     webcamcounter=0
    
     # do it until finished
     while [ $wantsitems = 0 ]; do
           webcamcounter+=1
    
           # ask the data
           webcamftpuser=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "FTP webcam setup" "Enter FTP username for webcam $webcamcounter" 0 0 "ipcamera$webcamcounter" 3>&1 1>&2 2>&3)
           webcamftpdirectory=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "FTP webcam setup" "Enter directory to store webcam files for $webcamftpuser" 0 0 "/media/mnt1/ipcamera$webcamcounter" 3>&1 1>&2 2>&3)
           webcamftppasswd=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "FTP webcam setup" "Enter password for user $webcamftpuser" 0 0 'welcome' 3>&1 1>&2 2>&3)
           itemlabel=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "FTP webcam setup" "Enter label for menu item in HTML wrapper" 0 0 "Camera $webcamcounter - frontdoor" 3>&1 1>&2 2>&3)
           itemurl=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "FTP webcam setup" "Enter URL to $itemlabel in HTML wrapper(including HTTP or HTTPS!)" 0 0 'http://my.ip.adress:port/' 3>&1 1>&2 2>&3)
 
           # add the user and the home directory. Set permissions for the directory so Samba can use them
           sudo mkdir -p "$webcamftpdirectory"
           sudo chmod -R 777 "$webcamftpdirectory"  
           sudo useradd -d "$webcamftpdirectory" "$webcamftpuser" # no shell access needed for this user (currently disabled - need to check how this works with vsftp)
		   echo -e "$webcamftppasswd\n$webcamftppasswd\n" | sudo passwd "$webcamftpuser"
 
           # add the link
		   menuitems+="\$menu_url['$itemlabel']='$itemurl';\n\$menu_class['$itemlabel']='text';\n\$menu_text['$itemlabel']=\"$itemlabel\";\n"  
 
           # add it to samba share
           # add the NZBget directory to SAMBA, in case the user wants to install SAMBA of course
echo "
[$itemlabel]
path = $webcamftpdirectory
browseable=Yes
writeable=Yes
create mask=0777
directory mask=0777" >> /home/pi/smbconfigtail.conf
 
           # want more?
           whiptail --yesno  --backtitle "N A Z v e r r y P i e - with Cream" --title "FTP webcam setup"  "Do want to configure another webcam?" --yes-button "Yes" --no-button "No" 0 0
           wantsitems=$?
     done
 
     # give some final information to end user
     whiptail --msgbox  --backtitle "N A Z v e r r y P i e - with Cream" --title "FTP webcam setup"  "Finished setting up FTP users for webcam. Please note, you need to login your webcam's site to configure the FTP upload to the respective directories. You may be required (for instance with Dericam) to add an upload directory (such as ftpupload) in the configuration, otherwise the upload will fail. In case you doubt whether it works, please use a simple ftp client to access the Pi with the user so you can check if ftp access actually works. If so, the problems is mostly with your webcam setup." 0 0
fi
#
# End IP webcam
#
 


#
# OpenVPN
#
if [[ $requestedpackages == *openvpn* ]]; then
	openvpnserver=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "OpenVPN" "Enter OpenVPN Server Name" 10 50 "MyOpenVPNServer" 3>&1 1>&2 2>&3)
	wanip=`wget -q -O - http://ip.keithscode.com`	
	wanip=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "WAN IP configuration" "Confirm the WAN IP adress for your Pie" 0 0 "$wanip" 3>&1 1>&2 2>&3)
	openvpnwanport=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "OpenVPN" "Enter OpenVPN Port (WAN and local)" 10 50 "1194" 3>&1 1>&2 2>&3)
	
	whiptail --msgbox  --backtitle "N A Z v e r r y P i e - with Cream"  "Please note: in order for your Pi to accept OpenVPN clients from the WAN, you need to make sure your router does port forwarding from port $openvpnwanport (outside) to the same port on your Pi on $ip." 0 0
	
	installsummary+="- OpenVPN $openvpnserver on $wanip, port $openvpnwanport\n"
fi


#
# Domoticz
#
if [[ $requestedpackages == *domoticz* ]]; then
	domoticzport=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "Domoticz" "Enter Domoticz port" 10 50 "8080" 3>&1 1>&2 2>&3)
	whiptail --yesno --backtitle "N A Z v e r r y P i e - with Cream" --title "Domoticz" "Do you want ZWave support" --yes-button "Yes" --no-button "No" 10 70
	domoticzwantzwave=$?
	
	installsummary+="- Domoticz on port $domoticzport\n"
	if [ "$domoticzwantzwave" = "0" ]; then installsummary+="    With ZWave support\n"; else installsummary+="    With no ZWave support\n"; fi
	
	# add the link url for the html wrapper
	menuitems+="\$menu_url['domoticz']='http://$ip:$domoticzport';\n\$menu_class['domoticz']='domoticz';\n\$menu_text['domoticz']='';\n"  
 
	#menuitems+="\$nazverrymenu['domoticz']='<a href=\"http://$ip:$domoticzport\" target=nazverrymain>domoticz</a>';\n"
fi



#
# PiWeb agent
#
if [[ $requestedpackages == *piwebagent* ]]; then
	installsummary+="- Pi Web Agent (user admin/passwd admin)\n"; 
	
	# add the link url for the html wrapper
	#menuitems+="\$nazverrymenu['piwebagent']='<a href=\"https://$ip:8003\" target=_piwebagent>Pi Web Agent</a>';\n"
	menuitems+="\$menu_url['piwebagent']='https://$ip:8003';\n\$menu_class['piwebagent']='piwebagent';\n\$menu_text['piwebagent']='';\n"  
fi


#
# SONOS controller 
#
if [[ $requestedpackages == *sonos* ]]; then
	installsummary+="- Sonos Web Controller on port 8090\n"; 
	
	# add the link url for the html wrapper
	menuitems+="\$menu_url['sonos']='https://$ip:8090';\n\$menu_class['sonos']='sonos';\n\$menu_text['sonos']='';\n"  
fi

#
# tonido personal cloud
#
if [[ $requestedpackages == *tonido* ]]; then
	installsummary+="- Tonido Personal Cloud\n"; 
	
	# add the link url for the html wrapper
	#menuitems+="\$nazverrymenu['tonido']='<a href=\"https://$ip:8003\" target=_piwebagent>Pi Web Agent</a>';\n"
	menuitems+="\$menu_url['tonido']='https://$ip:10001';\n\$menu_class['tonido']='tonido';\n\$menu_text['tonido']='';\n"  
fi

#
# Clean stuff
#
if [[ $requestedpackages == *cleanpie* ]]; then
	installsummary+="- Clean the Pie (Xwindows, Wolfram etc.)\n"; 
fi

#
# webmin
#
if [[ $requestedpackages == *webmin* ]]; then
	echo "------------------------------------------------------------------------------------"
	echo -e "Installing Webmin\nYou will be required to set the password for user root.\nPlease type it now"
	sudo passwd root
	
	installsummary+="- webmin admin tool\n"
	
	# add the link url for the html wrapper
	#menuitems+="\$nazverrymenu['webmin']='<a href=\"https://$ip:10000/\" target=_webmin>webmin</a>';\n"
	menuitems+="\$menu_url['webmin']='https://$ip:10000/';\n\$menu_class['webmin']='webmin';\n\$menu_text['webmin']='';\n"  

fi


#
# NZBget
#
if [[ $requestedpackages == *nzbget* ]]; then
	nzbgetport=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "NZBget" "Enter NZBget port" 10 50 "6789" 3>&1 1>&2 2>&3)
	nzbgetpassword=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "NZBget" "Enter NZBget WEBUI password (user nzbget)" 10 50 "tegbzn6789" 3>&1 1>&2 2>&3)
	nzbgetmaindir=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "NZBget" "Enter NZBget directory" 10 50 "/media/mnt1/NZBget" 3>&1 1>&2 2>&3)
	
	# here is the code I tried to create a userfriendly directory selector But it fails on the whiptail arguments. need to check one day
	#input=$(whiptail --checklist "NZBget\nPlease select the partition to use packages to install" 10 40 8 $mountdialog "manual" "No need to mount, will do manual" off 3>&1 1>&2 2>&3)
	
	# if a mountpoint is given then ask for the main directory
	#if [ $input = "manual" ]; then 
	#else
	#		nzbgetmaindir=$(whiptail --inputbox "NZBget\nEnter NZBget root directory" 10 50 "$input/NZBget" 3>&1 1>&2 2>&3)
	#		sudo mkdir -p $nzbgetmaindir 
	#		installsummary+="- NZBget on $nzbgetport, $nzbgetpassword and maindir $nzbgetmaindir\n"
	#else
	#		installsummary+="- NZBget on $nzbgetport, $nzbgetpassword and you will manually configure maindir in /etc/nzbget.conf.\n"
	#fi
	
	# add the link url for the html wrapper
	#menuitems+="\$nazverrymenu['NZBget']='<a href=\"http://$ip:$nzbgetport\" target=_nzbget>NZBget</a>';\n"
	menuitems+="\$menu_url['NZBget']='http://$ip:$nzbgetport';\n\$menu_class['NZBget']='nzbget';\n\$menu_text['NZBget']='NZBget';\n"  
fi

#
# SAMBA
#
if [[ $requestedpackages == *samba* ]]; then
	smbpassword=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "Samba" "Enter SAMBA password (user pi)" 10 50 "raspberry" 3>&1 1>&2 2>&3)
	installsummary+="- SAMBA with password $smbpassword\n"
fi

#
# youtube downloader
#
if [[ $requestedpackages == *youtubedl* ]]; then
	youtubedldir=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "Youtube Downloader" "Enter Youtube Downloader directory for Video files" 10 50 "/media/mnt1/Download/youtube-dl" 3>&1 1>&2 2>&3)
	installsummary+="- Youtube downloader\n         using $youtubedldir as video dir\n"
	
	#menuitems+="\$nazverrymenu['YT Downloader']='<a href=\"http://$ip/youtube-dl-webui\" target=nazverrymain>YT Downloader</a>';\n"
	menuitems+="\$menu_url['YT Downloader']='http://$ip/youtube-dl-webui';\n\$menu_class['YT Downloader']='youtube-dl';\n\$menu_text['YT Downloader']='';\n"  

fi

#
# ownCloud
#
if [[ $requestedpackages == *owncloud* ]]; then
	installsummary+="- ownCloud\n"
	
	# need to add: ask for data directory and change rights to www-data sudo chown -R www-data:www-data 
	ownclouddatadir=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "ownCloud" "Enter ownCloud data directory (you need to reenter this when running ownCloud for the first time)." 10 50 "/media/mnt1/ownCloud" 3>&1 1>&2 2>&3)
	
	whiptail --msgbox --backtitle "N A Z v e r r y P i e - with Cream" --title "ownCloud" "Please note: ownCloud allows to install using SQLlite, but my experience shows that this gives synchronisation errors. Best to use MySQL database. If you want to reconfigure ownCloud: remove config.php from /var/www/owncloud/config" 0 0 
	
	# add the link url for the html wrapper
	#menuitems+="\$nazverrymenu['ownCloud']='<a href=\"http://$ip/owncloud\" target=nazverrymain>ownCloud</a>';\n"
	menuitems+="\$menu_url['ownCloud']='http://$ip/owncloud';\n\$menu_class['ownCloud']='owncloud';\n\$menu_text['ownCloud']='';\n"  

fi

#
# Rsync
#
if [[ $requestedpackages == *rsync* ]]; then
	installsummary+="- Rsync\n"
fi
#
# vsFTPd
#
if [[ $requestedpackages == *vsftp* ]]; then
	installsummary+="- vsFTP\n"
fi

#
# Ajenti
#
if [[ $requestedpackages == *ajenti* ]]; then
	installsummary+="- Ajenti\n"
	
	menuitems+="\$menu_url['ajenti']='https://$ip:8000';\n\$menu_class['ajenti']='ajenti';\n\$menu_text['ajenti']='';\n"  

fi

#
# MYSQL installation - TODO to bring into non-interactive part.
#
if [[ $requestedpackages == *mysql* ]]; then
	installsummary+="- MySQL (interactive)\n"
	
#	whiptail --msgbox --backtitle "N A Z v e r r y P i e - with Cream" --title "REMINDER" "The script will prompt for more info until MYSQL/phpmyadmin has been installed" 0 0 
fi

#
# phpmyadmin
#
if [[ $requestedpackages == *phpmyadmin* ]]; then

	# only do this if MySQL is available
	if [[ $requestedpackages == *mysql* ]]; then
		installsummary+="- phpmyadmin (interactive)\n"
		
		# add the link url for the html wrapper
		#menuitems+="\$nazverrymenu['myphpadmin']='<a href=\"http://$ip/phpmyadmin\" target=_phpmyadmin>myphpadmin</a>';\n"
		menuitems+="\$menu_url['phpmyadmin']='http://$ip/phpmyadmin';\n\$menu_class['phpmyadmin']='phpmyadmin';\n\$menu_text['phpmyadmin']='';\n"  

		
#		whiptail --msgbox --backtitle "N A Z v e r r y P i e - with Cream" --title "REMINDER" "The script will prompt for more info until MYSQL/phpmyadmin has been installed" 0 0 
	else
		# put dialog: you selected phpmyadmin, but not MySQL. That is strange
		whiptail --msgbox "You selected phpmyadmin, but not MySQL. Will not install phpmyadmin." 0 0
	fi
fi 

#
# minidlna
#
if [[ $requestedpackages == *minidlna* ]]; then
	friendlyname=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "miniDLNA" "Enter miniDLNA friendly name for others" 10 50 "My RaspPi DLNA" 3>&1 1>&2 2>&3)
	dlnamaindir=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "miniDLNA" "Enter miniDLNA directory" 10 50 "/media/mnt1/miniDLNA" 3>&1 1>&2 2>&3)
	installsummary+="- miniDLNA\n"
fi
#

#
# Wrapper
# prepare the PHP file for the wrapper  (twice in this script - for debugging purposes we do this already)
sudo rm /home/pi/configmenu_new.php &> /dev/null
echo -e "<?PHP\n" >> /home/pi/configmenu_new.php
echo -e ${configitems} >> /home/pi/configmenu_new.php
echo -e ${menuitems} >> /home/pi/configmenu_new.php
echo -e "\n?>" >> /home/pi/configmenu_new.php
#

#
# Do the final confirmation
whiptail --msgbox --backtitle "N A Z v e r r y P i e - with Cream" --title "Installation overview" "Will install the following:\n$installsummary\nPlease press ENTER to continue or ESC to cancel." 0 0
input=$?
if [ "$input" = "255" ]; then exit; fi
#
# end user interaction
#


#
# General preps: update everything that is needed
# And clear up stuff. Taken from http://sourceforge.net/p/domoticz/wiki/Preparing%20a%20Raspberry%20PI%20%28Debian-Wheezy%29%20for%20Domoticz/
#

# removing stuff, also to speed up the updates/upgrade
# taken from domoticz howto
if [[ $requestedpackages == *cleanpie* ]]; then
	sudo apt-get purge -y wolfram-engine gnome* x11-common* cups* weston wpagui x11-common x11-utils x11-xserver-utils xarchiver xfonts-utils xinit xml-core xpdf xserver-xorg xserver-xorg-core | ./stdin2percentage.sh 780 install.log y 2>&1 | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Getting rid of junk on table top" " " 5 40 0

	# further cleaning
	sudo apt-get -y clean | ./stdin2percentage.sh 10 install.log y 2>&1 | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Doing final mop-up of table top" " " 5 40 0
fi

# updating stuff
sudo apt-get -y update | ./stdin2percentage.sh 30 install.log y 2>&1 | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Updating the equipment" " " 5 40 0
#sudo apt-get -y upgrade | ./stdin2percentage.sh 335 install.log y 2>&1 | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Upgrading the gear" " " 5 40 0

# apache and php
sudo apt-get -y install apache2 php5 php5-gd php-xml-parser php5-intl 2>&1 | ./stdin2percentage.sh 177 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing Apache" " " 5 40 0 # this actually installs more
sudo apt-get -y install php5-sqlite php5-mysql smbclient curl libcurl3 php5-curl 2>&1 | ./stdin2percentage.sh 155 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Getting the P-H-P" " " 5 40 0 # this actually installs more

# update the php-ini to support large file upload

sudo sed -i "s|upload_max_filesize = 2M|upload_max_filesize = 4G|" /etc/php5/apache2/php.ini
sudo sed -i "s|post_max_size = 8M|post_max_size = 4G|" /etc/php5/apache2/php.ini

# make the directories for the installation
sudo mkdir /home/pi/installscripts &> /dev/null

#
# end general preps
#

#
# Start of installation scripts. Here the actual hard word for the RPI will start
# First do the interactive parts user does not need to wait at the console
#

#
# MYSQL installation - TODO to bring into non-interactive part. Will probably fail due to absence of APACHE
#
if [[ $requestedpackages == *mysql* ]]; then
	sudo apt-get -y install mysql-server mysql-client 
fi

# avoid root password setting in mysql - taken from http://askubuntu.com/questions/79257/how-do-i-install-mysql-without-a-password-prompt
#sudo echo mysql-server mysql-server/root_password password root | sudo debconf-set-selections
#sudo echo mysql-server mysql-server/root_password_again password root | sudo debconf-set-selections

#
# phpmyadmin 
#
if [[ $requestedpackages == *phpmyadmin* ]]; then
	# only do this if MySQL is available
	if [[ $requestedpackages == *mysql* ]]; then
		sudo apt-get -y install phpmyadmin
		
		permissions=$(stat -c %a /etc/apache2/apache2.conf)
		sudo chmod 666 /etc/apache2/apache2.conf
		sudo echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
		sudo chmod "$permissions" /etc/apache2/apache2.conf
	fi
fi 

# OpenVPN
if [[ $requestedpackages == *openvpn* ]]; then
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/openvpn.sh?format=raw -O /home/pi/installscripts/openvpn.sh &> /dev/null
	sudo bash /home/pi/installscripts/openvpn.sh $openvpnserver $wanip $openvpnwanport 
fi

# finished interactive
whiptail --msgbox --backtitle "N A Z v e r r y P i e - with Cream" --title "Installation interactive done" "Interactive installation complete. Will now continue to unattended install.\nPlease press ENTER to continue or ESC to cancel." 22 73



# PiWeb agent
if [[ $requestedpackages == *piwebagent* ]]; then
	echo "/home/pi/installscripts/piwebagent.sh\n" >> /home/pi/nazpinstall.sh

	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/piwebagent.sh?format=raw -O /home/pi/installscripts/piwebagent.sh &> /dev/null
	#bash /home/pi/installscripts/piwebagent.sh 2>&1 | ./stdin2percentage.sh 615 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing Pi Web Agent (+- 20 minutes)" " " 5 40 0
fi

# miniDLNA
if [[ $requestedpackages == *minidlna* ]]; then
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/minidlna.sh?format=raw -O /home/pi/installscripts/minidlna.sh &> /dev/null
	bash /home/pi/installscripts/minidlna.sh $dlnamaindir $friendlyname 2>&1 | ./stdin2percentage.sh 115 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing miniDLNA (+- 5 minutes)" " " 5 40 0
	
	echo "/home/pi/installscripts/minidlna.sh $dlnamaindir $friendlyname\n" >> /home/pi/nazpinstall.sh
fi
# end of miniDLNA

# Ajenti
if [[ $requestedpackages == *ajenti* ]]; then
	#sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/minidlna.sh?format=raw -O /home/pi/installscripts/minidlna.sh &> /dev/null
	wget -O- https://raw.github.com/Eugeny/ajenti/master/scripts/install-raspbian.sh | sh | ./stdin2percentage.sh 115 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing Ajenti (+- 15 minutes)" " " 5 40 0
	
	#echo "/home/pi/installscripts/minidlna.sh $dlnamaindir $friendlyname\n" >> /home/pi/nazpinstall.sh
fi
# end of Ajenti

# Sonos
if [[ $requestedpackages == *sonos* ]]; then
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/sonos_controller.sh?format=raw -O /home/pi/installscripts/sonos_controller.sh &> /dev/null
	#bash /home/pi/installscripts/sonos_controller.sh 8090 2>&1 | ./stdin2percentage.sh 2115 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing SONOS Web Controller and Node.js(+- 75 minutes)" " " 5 40 0
	
	echo "/home/pi/installscripts/sonos_controller.sh 8090 \n " >> /home/pi/nazpinstall.sh
fi
# end of miniDLNA

# domoticz
if [[ $requestedpackages == *domoticz* ]]; then
	# get the script	
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/domoticz.sh?format=raw -O /home/pi/installscripts/domoticz.sh &> /dev/null
	#bash /home/pi/installscripts/domoticz.sh $domoticzport $domoticzwantzwave 2>&1 | ./stdin2percentage.sh 1300 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing domoticz (+- 1.5hr)" " " 5 40 0
	
	echo "/home/pi/installscripts/domoticz.sh $domoticzport $domoticzwantzwave \n " >> /home/pi/nazpinstall.sh
fi
# end of domoticz part

# NZB installation
if [[ $requestedpackages == *nzbget* ]]; then
	# get the script	
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/nzbget.sh?format=raw -O /home/pi/installscripts/nzbget.sh  &> /dev/null
	#bash /home/pi/installscripts/nzbget.sh $nzbgetmaindir $nzbgetpassword $nzbgetport 2>&1 | ./stdin2percentage.sh 1151 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing NZBget (+- 45 minutes)" " " 5 40 0

	echo "/home/pi/installscripts/nzbget.sh $nzbgetmaindir $nzbgetpassword $nzbgetport \n " >> /home/pi/nazpinstall.sh	
fi
# end of NZB part 




# tonido installation
if [[ $requestedpackages == *tonido* ]]; then
	# get the script	
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/tonido.sh?format=raw -O /home/pi/installscripts/tonido.sh  &> /dev/null
	#bash /home/pi/installscripts/tonido.sh  2>&1 | ./stdin2percentage.sh 11 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing Tonido (+- 5 minutes)" " " 5 40 0	
	
	echo "/home/pi/installscripts/tonido.sh \n " >> /home/pi/nazpinstall.sh
fi
# end of tonido part 

# ownCloud installation
if [[ $requestedpackages == *owncloud* ]]; then
	# get the script	
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/owncloud.sh?format=raw -O /home/pi/installscripts/owncloud.sh  &> /dev/null
	#bash /home/pi/installscripts/owncloud.sh 2>&1 | ./stdin2percentage.sh 583 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing ownCloud (15mins)" " " 5 40 0
	
	# need to put this in the script 
	sudo mkdir -p "$ownclouddatadir"
	sudo chown -R www-data:www-data "$ownclouddatadir"
	
	echo "/home/pi/installscripts/owncloud.sh \n " >> /home/pi/nazpinstall.sh
	
fi
# end of ownCloud

# vsFTP
if [[ $requestedpackages == *vsftp* ]]; then
	# get the script	
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/vsftp.sh?format=raw -O /home/pi/installscripts/vsftp.sh  &> /dev/null
	#bash /home/pi/installscripts/vsftp.sh 2>&1 | ./stdin2percentage.sh 19 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing vsFTP (5 mins)" " " 5 40 0
	
		echo "/home/pi/installscripts/vsftp.sh \n " >> /home/pi/nazpinstall.sh
fi 
# end part of vsFTP

# rsync -- need to remove this or do something more sensible
if [[ $requestedpackages == *rsync* ]]; then
	# get the script	
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/rsync.sh?format=raw -O /home/pi/installscripts/rsync.sh  &> /dev/null
	#bash /home/pi/installscripts/rsync.sh 2>&1 | ./stdin2percentage.sh 6 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing Rsync" " " 5 40 0
	
	echo "/home/pi/installscripts/rsync.sh \n " >> /home/pi/nazpinstall.sh
fi 
# end part of rsync

# webmin
if [[ $requestedpackages == *webmin* ]]; then
	# get the script	
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/webmin.sh?format=raw -O /home/pi/installscripts/webmin.sh  &> /dev/null
	#bash /home/pi/installscripts/webmin.sh 2>&1 | ./stdin2percentage.sh 300 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing webmin (15 minutes)" " " 5 40 0
	
	echo "/home/pi/installscripts/webmin.sh \n " >> /home/pi/nazpinstall.sh
fi 
# end part of rsync

# youtubedl
if [[ $requestedpackages == *youtubedl* ]]; then
	# get the script	
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/youtube-dl.sh?format=raw -O /home/pi/installscripts/youtube-dl.sh  &> /dev/null
	#bash /home/pi/installscripts/youtube-dl.sh $youtubedldir 2>&1 | ./stdin2percentage.sh 300 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing Youtube Downloader (10 minutes)" " " 5 40 0
	
	echo "/home/pi/installscripts/youtube-dl.sh $youtubedldir \n " >> /home/pi/nazpinstall.sh
fi 

# Samba installation -  should always come last
if [[ $requestedpackages == *samba* ]]; then
	# get the script	
	sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/samba.sh?format=raw -O /home/pi/installscripts/samba.sh  &> /dev/null
	#bash /home/pi/installscripts/samba.sh $smbpassword 2>&1 | ./stdin2percentage.sh 68 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing SAMBA (5mins)" " " 5 40 0	
	
	echo "/home/pi/installscripts/samba.sh $smbpassword \n " >> /home/pi/nazpinstall.sh
	
fi 
# end part of samba


#
# Wrapper installation and configuration
#

# prepare the PHP file for the wrapper
sudo rm /home/pi/configmenu_new.php &> /dev/null
echo -e "<?PHP " >> /home/pi/configmenu_new.php
echo -e ${configitems} >> /home/pi/configmenu_new.php
echo -e ${menuitems} >> /home/pi/configmenu_new.php
echo -e "\n?>" >> /home/pi/configmenu_new.php

# install the HTML wrapper
sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/htmlwrapper.sh?format=raw -O /home/pi/installscripts/htmlwrapper.sh  &> /dev/null
bash /home/pi/installscripts/htmlwrapper.sh 2>&1 | ./stdin2percentage.sh 91 install.log y | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Installing HTMLwrapper" " " 5 70 0	

# finale automatic cleaning
sudo apt-get -y autoremove | ./stdin2percentage.sh 315 install.log y 2>&1 | whiptail --gauge --backtitle "N A Z v e r r y P i e - with Cream" --title "Automatic cleansing initiated" " " 5 40 0

# cleanup some stuff
sudo rm /home/pi/stdin2percentage.sh &> /dev/null
sudo rm /home/pi/createhtml.php
sudo rm /home/pi/smbconfigtail.conf
sudo apt-get -y autoremove

# Close the installation script
echo "chmod 600 /home/pi/nazpinstall.sh" >> /home/pi/nazpinstall.sh 
echo "reboot " >> /home/pi/nazpinstall.sh 

# 
# Closing comments
#
whiptail --msgbox --backtitle "N A Z v e r r y P i e - with Cream" --title "End of installing N A Z v e r r y P i e" "INSTALL COMPLETED\n\nAssure the RPI on $ip has a static lease in your dhcp server, as well in this RPI itself.\n\nYour pie will be ready for consumption at http://$ip/nazverrypie.\nThe unattendedinstall script is located in /home/pi/nazpinstall.sh. Run this by sudo /home/pi/nazpinstall.sh or sudo nohup /home/pi/nazpinstall.sh & for unattended run.\n\n Thanx and enjoy your pie." 21 73

# close the system
#sudo reboot



############# end script ##############