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
# WEBMIN
# Taken from: http://www.webmin.com/deb.html
# nzbget,unrar is copyright of their respective holders.
#
#
# Start of script
#
# Init of variables : no variables
#

echo "INSTALLING WEBMIN"

# add the new source references
permissions=$(stat -c %a /etc/apt/sources.list)
sudo chmod 666 /etc/apt/sources.list
echo "deb http://download.webmin.com/download/repository sarge contrib" >> /etc/apt/sources.list
echo "deb http://webmin.mirror.somersettechsolutions.co.uk/repository sarge contrib" >> /etc/apt/sources.list
sudo chmod $permissions /etc/apt/sources.list

# You should also fetch and install my GPG key with which the repository is signed, with the command (we can use a pipe as well...)
sudo mkdir /home/pi/webmin
sudo wget http://www.webmin.com/jcameron-key.asc -O /home/pi/webmin/jcameron-key.asc
sudo apt-key add /home/pi/webmin/jcameron-key.asc

# update the repository
sudo apt-get -y update

# install webmin
sudo apt-get -y install webmin
