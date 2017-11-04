#!/bin/bash
#
# OpenVPN Client configuration - Copyright (c) 2014-2015 TomGrun
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
#  Part of : N A Z v e r r y P i e  - a friendlier installation script for RPI
#
# Taken from: https://wiki.debian.org/OpenVPN and http://keithscode.com/blog/10-wan-ip-from-a-bash-script.html
#

echo -e "Usage: sudo bash $0 <clientname> <wanip> <wanport> \nIf no/some arguments are provided, defaults are used."
if [ -n "$1" ]; then clientname=$1; else clientname="MyOpenVPNClient"; fi
if [ -n "$2" ]; then wanip=$2; else wanip=`wget -q -O - http://ip.keithscode.com`; fi
if [ -n "$3" ]; then wanport=$3; else wanport="1194"; fi
echo -e "Creating OpenVPN client for $clientname, and wan $wanip on port $wanport"  

# do some testing of files to use, otherwise exit
if [ ! -e "/etc/openvpn/easy-rsa/keys/ca.crt" ]; then echo "CA.crt not found"; exit; fi
#if [ ! -e "/etc/openvpn/ta.key" ]; then echo "ta.key not found"; exit; fi

# the output directory for ovpn files
mkdir /etc/openvpn/ovpn
chmod 777 /etc/openvpn/ovpn

# go to relevant dir
cd /etc/openvpn/easy-rsa
source ./vars

# generate the key, with password if such is wanted
whiptail --title "OpenVPN client config generation" --yesno "Do you want to apply a private password to the key? (if yes, then you need to provide one later - min 4 characters)" --yes-button "Yes" --no-button "No" 0 0 
wantskey=$?
if [ $wantskey -eq 0 ]; then
	./build-key-pass $clientname
else
	./build-key $clientname      
fi

# check if it succeeeded
if [ ! -e "/etc/openvpn/easy-rsa/keys/$clientname.key" ]; then echo "$clientname.key not found"; exit; fi
if [ ! -e "/etc/openvpn/easy-rsa/keys/$clientname.crt" ]; then echo "$clientname.crt not found"; exit; fi
	
# and make the openvpn file
clientfilename="/etc/openvpn/ovpn/$clientname.ovpn"
sudo rm -f $clientfilename
cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf $clientfilename
	
# start adding additional config items
echo "set CLIENT_CERT 0" >> $clientfilename
	
echo "<ca>" >> $clientfilename
cat "/etc/openvpn/easy-rsa/keys/ca.crt" | grep -A 100 "BEGIN CERTIFICATE" | grep -B 100 "END CERTIFICATE" >> $clientfilename
echo "</ca>" >> $clientfilename
	
echo "<cert>" >> $clientfilename
cat "/etc/openvpn/easy-rsa/keys/$clientname.crt" | grep -A 100 "BEGIN CERTIFICATE" | grep -B 100 "END CERTIFICATE" >> $clientfilename
echo "</cert>" >> $clientfilename

# deviating from the wiki as the grep key does not work 
echo "<key>" >> $clientfilename
cat "/etc/openvpn/easy-rsa/keys/$clientname.key" | grep -A 100 "BEGIN" | grep -B 100 "END" >> $clientfilename
echo "</key>" >> $clientfilename

# this is not working - need debugging	
#echo "<tls-auth>" >> $clientfilename
#cat "/etc/openvpn/ta.key" | grep -A 100 "BEGIN" | grep -B 100 "END" >> $clientfilename
#echo "</tls-auth>" >> $clientfilename
	
# configure the client
sed -i "s|;mute-replay-warnings|mute-replay-warnings|" $clientfilename
sed -i "s|remote my-server-1 1194|remote $wanip $wanport|" $clientfilename
sed -i "s|ca ca.crt|;ca ca.crt|" $clientfilename
sed -i "s|cert client.crt|;cert client.crt|" $clientfilename
sed -i "s|key client.key|;key client.key|" $clientfilename
#sed -i "s|;tls-auth|tls-auth|" $clientfilename
