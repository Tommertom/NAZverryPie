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
# miniDLNA
# Taken from: http://www.raspberrypi.org/forums/viewtopic.php?t=16352
# miniDLNA is copyright of their respective holders.
#
#
# Start of script
#
# Init of variables :
# $1 : miniDLNA maindir
# $2 : friendlyname
#
echo -e "Usage: sudo bash $0 <dlnamaindir> <friendlyname>\nIf no/some arguments are provided, defaults are used."
if [ -n "$1" ]; then dlnamaindir=$1; else dlnamaindir="/media/mnt1/miniDLNA"; fi
if [ -n "$2" ]; then friendlyname=$2; else friendlyname="My RaspPi DLNA"; fi
echo -e "INSTALLING miniDLNA.\nUsing maindir $dlnamaindir and friendly name $friendlyname"

sudo apt-get -y install minidlna

# make the directories
sudo mkdir --parents $dlnamaindir &> /dev/null

#sudo sed -i "s|media_dir=V,/media/HardDrive/Media/Video| media_dir=V,$dlnamaindir/Video |" /etc/minidlna.conf
#sudo sed -i "s|media_dir=A,/media/HardDrive/Media/Music| media_dir=V,$dlnamaindir/Music|" /etc/minidlna.conf
#sudo sed -i "s|media_dir=P,/media/HardDrive/Media/Photos| media_dir=V,$dlnamaindir/ Photos|" /etc/minidlna.conf
 
# do some configuration
sudo sed -i "s|media_dir=/var/lib/minidlna|media_dir=$dlnamaindir|" /etc/minidlna.conf
sudo sed -i "s|#db_dir=/var/lib/minidlna|db_dir=/home/pi/.minidlna|" /etc/minidlna.conf
sudo sed -i "s|#log_dir=/var/log|log_dir=/var/log|" /etc/minidlna.conf
sudo sed -i "s|#friendly_name=|friendly_name=$friendlyname|" /etc/minidlna.conf
sudo sed -i "s|#inotify=yes|inotify=yes|" /etc/minidlna.conf

# setup for boot-time
sudo update-rc.d minidlna defaults

# run minidlna once to setup dirs
sudo minidlna

# start the service
sudo service minidlna start

# add the DLNA directory to SAMBA, in case the user wants to install SAMBA of course	
echo "
[miniDLNA]
path = $dlnamaindir
browseable=Yes
writeable=Yes
only guest=no
create mask=0777
directory mask=0777
public=yes" >> /home/pi/smbconfigtail.conf


