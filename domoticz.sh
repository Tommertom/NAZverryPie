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
#  Domoticz installer
#
#
# Domoticz installation
# Taken from: http://www.domoticz.com/wiki/Installing_and_running_Domoticz_on_a_Raspberry_PI
# Domoticz is copyright of their respective holders.
#
#
# Start of script
#
# Init of variables
#	$1 domoticzport
#	$2 domoticzwantzwave
#	    
#
echo -e "Usage: sudo bash $0 <domoticzport> <wantzwave: 0=yes, other=no>\nIf no/some arguments are provided, defaults are used."
if [ -n "$1" ]; then domoticzport=$1; else domoticzport="8080"; fi
if [ -n "$2" ]; then domoticzwantzwave=$2; else domoticzwantzwave="0"; fi
echo -e "INSTALLING domoticz.\nUsing port $domoticzport and zwave $domoticzwantzwave"

# get all the required packages
sudo apt-get -y install  build-essential cmake make gcc g++ libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev subversion curl libcurl4-openssl-dev libusb-dev

# zwave possibly installed
if [ "$domoticzwantzwave" = "0" ]; then

	# need this
	sudo apt-get install libudev-dev

	# assure we put this in the right place
	cd /home/pi
	
	# get the code
	git clone -b Issue-352-Security https://github.com/OpenZWave/open-zwave open-zwave-read-only
	cd open-zwave-read-only
	git fetch
	make -j 4
fi

cd /home/pi
mkdir domoticz
cd domoticz
wget http://domoticz.sourceforge.net/domoticz_linux_armv7l.tgz
tar xvfz domoticz_linux_armv7l.tgz
rm domoticz_linux_armv7l.tgz


# create bootup time parameters. backup the domoticz.sh
sudo cp domoticz.sh /etc/init.d
sudo cp domoticz.sh domoticz.sh.old
sudo chmod +x /etc/init.d/domoticz.sh
sudo update-rc.d domoticz.sh defaults

# change the port to run the domoticz server
# sudo sed -i 's/DAEMON=/DAEMON=/home/pi/domoticz/domoticz/g' /etc/init.d/domoticz.sh  ---> no longer needed
sudo sed -i "s/www 8080/www $domoticzport/" /etc/init.d/domoticz.sh
