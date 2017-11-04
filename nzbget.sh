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
# NZB installation
# http://discuss.howtogeek.com/t/how-to-install-nzbget-for-lightweight-usenet-downloading-on-your-raspberry-pi/2321?page=5000000
# nzbget,unrar is copyright of their respective holders.
#
#
# Start of script
#
# Init of variables
#	$1 nzbgetmaindir
#	$2 nzbgetpassword
#	$3 nzbgetport
#	    
#
echo -e "Usage: sudo bash $0 <nzbgetmaindir> <nzgetpassword> <nzbgetport>\nIf no/some arguments are provided, defaults are used."
if [ -n "$1" ]; then nzbgetmaindir=$1; else nzbgetmaindir="/media/mnt1/NZBget"; fi
if [ -n "$2" ]; then nzbgetpassword=$2; else nzbgetpassword="tegbzn6789"; fi
if [ -n "$3" ]; then nzbgetport=$3; else nzbgetport="6789"; fi
echo -e "INSTALLING NZBget.\nUsing port $nzbgetport, maindir $nzbgetmaindir and password $nzbgetpassword"  # security issue here!!

# start with unrar

	mkdir /home/pi/unrar
	cd /home/pi/unrar
	permissions=$(stat -c %a /etc/apt/sources.list)
	sudo chmod 666 /etc/apt/sources.list
	sudo echo "deb-src http://mirrordirector.raspbian.org/raspbian/ wheezy main contrib non-free rpi" >> /etc/apt/sources.list 
	sudo chmod $permissions /etc/apt/sources.list
	sudo apt-get update
	sudo apt-get -y build-dep unrar-nonfree
	sudo apt-get -y source -b unrar-nonfree
	sudo dpkg -i unrar_*_armhf.deb

	# build in a temp directory, cleanup later on. Bit silly to have this in the root
	sudo mkdir /home/pi/nzbget
	cd /home/pi/nzbget

	#packages
	sudo apt-get -y install libncurses5-dev sigc++ libpar2-0-dev libssl-dev libgnutls-dev libxml2-dev 
	
	# deviation from the how-to, we'll take a newer version. 
	sudo wget http://sourceforge.net/projects/nzbget/files/nzbget-13.0.tar.gz
	sudo tar -xvf nzbget-13.0.tar.gz
	cd nzbget-13.0

	# need libpar2 update (until we are going to use nzbget-14.0
	sudo wget https://launchpad.net/libpar2/trunk/0.4/+download/libpar2-0.4.tar.gz
	sudo tar -xvf libpar2-0.4.tar.gz
	cd libpar2-0.4/
	sudo ./configure
	sudo make  
	sudo make install
	
	# make the stuff
	cd ..
	sudo ./configure
	sudo make # is it really necessary to do make and then make install?
	sudo make install
	
	# configuration
	sudo cp /usr/local/share/nzbget/nzbget.conf /etc/nzbget.conf

	# configure NZBget
	permissions=$(stat -c %a /etc/nzbget.conf)
	sudo chmod 666 /etc/nzbget.conf 
	sudo sed -i "s|MainDir=~/downloads|MainDir=$nzbgetmaindir|" /etc/nzbget.conf
	sudo sed -i "s|ControlPassword=tegbzn6789|ControlPassword=$nzbgetpassword|" /etc/nzbget.conf
	sudo sed -i "s|ControlPort=6789|ControlPort=$nzbgetport|" /etc/nzbget.conf
	sudo chmod $permissions /etc/nzbget.conf
		
	# configure as service 
cd

echo '#!/bin/sh
### BEGIN INIT INFO
# Provides:          NZBget
# Required-Start:    $network $remote_fs $syslog
# Required-Stop:     $network $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start NZBget at boot
# Description:       Start NZBget
### END INIT INFO
case "$1" in
start)   echo -n "Start services: NZBget"
/usr/local/bin/nzbget -D
;;
stop)   echo -n "Stop services: NZBget"
/usr/local/bin/nzbget -Q
;;
restart)
$0 stop
$0 start
;;
*)   echo "Usage: $0 start|stop|restart"
exit 1
;;
esac
exit 0' >> /home/pi/nzbget.sh

sudo chmod 755 /home/pi/nzbget.sh
sudo mv /home/pi/nzbget.sh /etc/init.d/
sudo update-rc.d nzbget.sh defaults

# chmod the nzb incoming directory for write access (not tested if this works)
sudo chmod 777 "$nzbgetmaindir"/nzb
sudo chmod 777 "$nzbgetmaindir"/dst

# add the NZBget directory to SAMBA, in case the user wants to install SAMBA of course	
echo "
[NZBget]
path = $nzbgetmaindir
browseable=Yes
writeable=Yes
only guest=no
create mask=0777
directory mask=0777
public=yes" >> /home/pi/smbconfigtail.conf
