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
# Samba installation
# Taken from: http://www.howtogeek.com/139433/how-to-turn-a-raspberry-pi-into-a-low-power-network-storage-device/ 
# Also taken from: http://elinux.org/R-Pi_NAS
# and http://www.simonthepiman.com/how_to_setup_windows_file_server.php
# Samba is copyright of their respective holders.
#
#
# Start of script
#
# Init of variables : no variables
#	$1 : smbpassword    
#
echo -e "Usage: sudo bash $0 <smbpassword>\nIf no/some arguments are provided, defaults are used."
if [ -n "$1" ]; then smbpassword=$1; else smbpassword="raspberry"; fi
echo -e "INSTALLING SAMBA.\nUsing password $smbpassword"

# support of rerun
if [ -f "/etc/samba/smb.conf" ]; then
	# check if clean file is available
	if [ -f "/etc/samba/smb.conf.nazpie.old" ]; then
		sudo rm /etc/samba/smb.conf
		cp /etc/samba/smb.conf.nazpie.old /etc/samba/smb.conf
	else
		echo "Strange situation: cannot find the backup config file for rerun"
		sleep 2
		# exit # exit the script, cause a rerun mail fail
	fi
fi

# get package
sudo apt-get -y install samba samba-common-bin

# enable security in the config. First backup the config.
sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.nazpie.old

# open up the config file
permissions=$(stat -c %a /etc/samba/smb.conf)
sudo chmod 666 /etc/samba/smb.conf

# change setting
sudo sed -i "s/#   security = user/security = user/g" /etc/samba/smb.conf

# add the additions from the other packages to the configuration # add a test to see if this has been done?
sudo cat /home/pi/smbconfigtail.conf >> /etc/samba/smb.conf 
	
# restore permissions
sudo chmod "$permissions" /etc/samba/smb.conf	

# add the only known users - need to automate this!!ERROR
# http://stackoverflow.com/questions/12009/piping-password-to-smbpasswd
echo -ne "$smbpassword\n$smbpassword\n" | sudo smbpasswd -a -s pi

# restart the service
sudo service samba restart