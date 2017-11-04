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
# DUCKDNS 
# 
# DuckDNS is copyright of their respective holders.
#
# Start of script
#
# Init of variables
#	$1 app key
# 	$2 domains to update
#	$3 optional wanip to use
#	    
#
# should always run as sudo
if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

echo -e "Usage: sudo bash $0 <appkey>\nIf no/some arguments are provided, defaults are used."
if [ -n "$1" ]; then appkey=$1; else echo "Need application key"; exit 1; fi
if [ -n "$2" ]; then domain=$2; else echo "Need domain"; exit 1; fi
if [ -n "$3" ]; then ip=$3; else ip=""; fi

echo -e "INSTALLING DuckDNS.\nUsing app key $appkey and domain $domain and ip=$ip (can be empty)"   # security issue here!!

# create the place to play
mkdir /home/pi/duckdns
cd /home/pi/duckdns

# create the update script using the params from user
rm /home/pi/duckdns/duck.sh
echo  "echo url=\"https://www.duckdns.org/update/$domain/$appkey/$ip\" | curl -k -o /home/pi/duckdns/duck.log -K - " >> /home/pi/duckdns/duck.sh
chmod 700 /home/pi/duckdns/duck.sh

# put in cron and support restart of this script
sed -i '/duckdns/d' /var/spool/cron/crontabs/root
echo -e "*/5 * * * * /home/pi/duckdns/duck.sh >/dev/null 2>&1" >> /var/spool/cron/crontabs/root

# run first time to see what comes out of it
bash /home/pi/duckdns/duck.sh
echo -e "\n\nThe Duck says : "
cat /home/pi/duckdns/duck.log

# and assure cron knows it
service cron restart