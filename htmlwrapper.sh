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
# The HTML wrapper
#
#
# Start of script
#
# Init of variables
#	    
#
# make the destination ready 
sudo mkdir /var/www/nazverrypie 

# get all the html items
sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/createhtml.php?format=raw -O /home/pi/createhtml.php
sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/favicon.ico?format=raw -O /var/www/nazverrypie/favicon.ico
sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/logopack.zip?format=raw -O /var/www/nazverrypie/logopack.zip
sudo wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/nazverrypie.css?format=raw -O /var/www/nazverrypie/nazverrypie.css

# and put  php config in the directory
# used to be: sudo mv /home/pi/nazverrypiemenu.php /var/www/nazverrypie
# process the new config items with the existing config items (if any)
sudo rm /home/pi/index.html
sudo php /home/pi/createhtml.php > /home/pi/index.html
sudo rm /var/www/nazverrypie/index.html
sudo mv /home/pi/index.html /var/www/nazverrypie/index.html

# remove all the newly created menu items
sudo rm /home/pi/configmenu_new.php &> /dev/null

# all the logos
sudo mkdir /var/www/nazverrypie/logopack
sudo rm /var/www/nazverrypie/logopack/*
sudo unzip -o -d /var/www/nazverrypie /var/www/nazverrypie/logopack.zip
sudo rm /var/www/nazverrypie/logopack.zip

# set permissions right
sudo chown -R www-data:www-data /var/www/