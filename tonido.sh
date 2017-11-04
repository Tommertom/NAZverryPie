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
# TONIDO 
# 
# Tonido is copyright of their respective holders.
#
# Start of script
#
# Init of variables
#	    
#
# should always run as sudo
if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

echo -e "Usage: sudo bash $0 \nIf no/some arguments are provided, defaults are used."
#if [ -n "$1" ]; then appkey=$1; else echo "Need application key"; exit 1; fi
#if [ -n "$2" ]; then domain=$2; else echo "Need domain"; exit 1; fi
#if [ -n "$3" ]; then ip=$3; else ip=""; fi

echo -e "INSTALLING Tonido." 

http://192.168.0.40:10001

mkdir /usr/local/tonido
cd /usr/local/tonido
wget http://patch.codelathe.com/tonido/live/installer/armv6l-rpi/tonido.tar.gz
tar -zxvf tonido.tar.gz
./tonido.sh start

cd /usr/local/tonido
apt-get install ffmpeg
ln -s /usr/bin/ffmpeg ffmpeg.exe
ln -s /usr/bin/ffmpeg ffmpegv.exe


# wget werkt niet
wget http://www.tonido.com/support/download/attachments/9109990/tonido?version=2&modificationDate=1412274854000&api=v2 -O /etc/init.d/tonido 
chmod +x /etc/init.d/tonido
update-rc.d tonido defaults


acccount opening via website 


