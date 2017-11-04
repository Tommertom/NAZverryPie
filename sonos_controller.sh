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
# Sonos controller installation, including node.js
# https://github.com/jishi/node-sonos-web-controller & http://elinux.org/Node.js_on_RPi
# Sonos is copyright of their respective holders.
#
#
# Start of script
#
# Init of variables
#	$1 port
#	    
#

# should always run as sudo
if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

echo -e "Usage: sudo bash $0 <port>\nIf no/some arguments are provided, defaults are used.\n"
if [ -n "$1" ]; then port=$1; else port="8090"; fi

echo -e "INSTALLING SONOS controller.\nUsing port $port" 

# node.js installation - takes a while (alternative use: http://joshondesign.com/2013/10/23/noderpi)
mkdir /home/pi/node.js
cd /home/pi/node.js
wget http://nodejs.org/dist/v0.10.2/node-v0.10.2.tar.gz
tar -xzf node-v0.10.2.tar.gz
cd node-v0.10.2
./configure
make  
make install

# get the controller
mkdir /home/pi/node-sonos-web-controller
cd /home/pi/node-sonos-web-controller
git clone https://github.com/jishi/node-sonos-web-controller.git .
npm install

# configure the port to listen to
sed -i "s|port: 8080|port: $port|" /home/pi/node-sonos-web-controller/server.js

# configure as service (taken from red-node https://learn.adafruit.com/raspberry-pi-hosting-node-red/setting-up-node-red)
echo '#!/bin/sh
### BEGIN INIT INFO
# Provides:          Sonos Controller
# Required-Start:    $network $remote_fs $syslog
# Required-Stop:     $network $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start Sonos Controller at boot
# Description:       Start Sonos Controller
### END INIT INFO

PIDFILE="/var/run/sonospid.pid"

case "$1" in
start)   echo -e "Start services: Sonos Controller\n"
nohup node --max-old-space-size=128 /home/pi/node-sonos-web-controller/server.js > /var/log/node-sonos-web-controller.log &
echo $! > $PIDFILE
cat $PIDFILE
;;
stop)   echo -e "Stop services: Sonos Controller\n"
kill `cat $PIDFILE`
rm -f $PIDFILE
;;
restart)
$0 stop
$0 start
;;
*)   echo "Usage: $0 start|stop|restart"
exit 1
;;
esac
exit 0' >> /home/pi/node-sonos-web-controller.sh

# place the bootup script
chmod 755 /home/pi/node-sonos-web-controller.sh
mv /home/pi/node-sonos-web-controller.sh /etc/init.d/
update-rc.d node-sonos-web-controller.sh defaults

# start the server
nohup node --max-old-space-size=128 /home/pi/node-sonos-web-controller/server.js > /var/log/node-sonos-web-controller.log &
