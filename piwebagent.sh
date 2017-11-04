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
#  Pi Web Agent installer
#
#
# Pi Web Agent installation
# Taken from: https://github.com/vaslabs/pi-web-agent
# Pi Web Agent is copyright of their respective holders.
#
#
# Start of script
#
# Init of variables : no variables
#	    
#

# put the stuff in the right directory
sudo mkdir /home/pi/piwebagent
cd /home/pi/piwebagent
sudo wget https://github.com/vaslabs/pi-web-agent/archive/master.zip -O piwebagent.zip

# put the stuff in the right directory
sudo unzip -o piwebagent.zip
sudo rm piwebagent.zip

# Need to check the dependencies before running the developer script
sudo apt-get -y update
sudo apt-get -y install git tightvncserver apache2 libapache2-mod-dnssd alsa-utils python gcc libprocps0-dev

# install the stuff (using reinstall option for support of restarting this script)
cd pi-web-agent-master
bash -x setup_dev.sh reinstall

# register for boot time
sudo update-rc.d pi-web-agent defaults

# run the server
sudo /etc/init.d/pi-web-agent start



