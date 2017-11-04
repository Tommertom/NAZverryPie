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
# ownCloud installation
# Taken from:
# https://samhobbs.co.uk/2013/10/install-owncloud-on-your-raspberry-pi, http://sharadchhetri.com/2013/08/08/how-to-install-owncloud-in-debian-wheezy-7/
# other resource (not used): https://forum.owncloud.org/viewtopic.php?f=8&t=18742
# ownCloud is copyright of their respective holders.
#
#
# Start of script
#
# Init of variables : no input variables
#	    
#

# make dir
sudo rm -R /home/pi/owncloud # in support of rerun of script
sudo mkdir /home/pi/owncloud
cd /home/pi/owncloud
	
# packages supporting tools (already done, but assuring it is there)
sudo apt-get -y install apache2 php5 php5-gd php-xml-parser php5-intl php-apc
sudo apt-get -y install php5-sqlite php5-mysql smbclient curl libcurl3 php5-curl 
	
# get the package from the repository 
sudo wget https://download.owncloud.org/community/owncloud-7.0.2.tar.bz2
sudo tar -xjf owncloud-7.0.2.tar.bz2
	
# move to apache
sudo cp -r owncloud /var/www
sudo rm -r owncloud
	
# set permissions right
sudo chown -R www-data:www-data /var/www/
	
# need to change sudo nano /etc/apache2/sites-enabled/000-default
sudo touch /var/www/owncloud/.htaccess
sudo chown www-data:www-data /var/www/owncloud/.htaccess
	
# reset the apache stuff
sudo a2enmod rewrite
sudo a2enmod headers
sudo service apache2 restart

# configure mysql for usage of owncloud, if selected
#sudo mysql --user=root --password=root -e "create database owncloud"
#sudo mysql --user=root --password=root -e "create user 'ownclouduser'@'localhost' IDENTIFIED BY 'owncloud'"
#sudo mysql --user=root --password=root -e "GRANT ALL ON owncloud.* TO 'ownclouduser'@'localhost'"
#sudo mysql --user=root --password=root -e "flush privileges"		
