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
# vsFTPd
# ftpd - used http://www.instructables.com/id/Raspberry-Pi-Web-Server/step9/Install-an-FTP-server/
#
#
# Start of script
#
# Init of variables : no variables
#

# get the packages
sudo apt-get -y install vsftpd

# configure the ftpd
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.old
sudo sed -i "s/anonymous_enable=YES/anonymous_enable=NO/g" /etc/vsftpd.conf
sudo sed -i "s/#local_enable=YES/local_enable=YES/g" /etc/vsftpd.conf
sudo sed -i "s/#write_enable=YES/write_enable=YES/g" /etc/vsftpd.conf

permissions=$(stat -c %a /etc/vsftpd.conf)
sudo chmod 666 /etc/vsftpd.conf
sudo echo " " >> /etc/vsftpd.conf
sudo echo "# added by NAZverrypie.sh " >> /etc/vsftpd.conf
sudo echo "force_dot_files=YES" >> /etc/vsftpd.conf
sudo chmod $permissions /etc/vsftpd.conf

# restart the daemon
sudo service vsftpd restart
