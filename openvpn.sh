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
#  OpenVPN installer
#
#
# OpenVPN installation
# Taken from: http://readwrite.com/2014/04/10/raspberry-pi-vpn-tutorial-server-secure-web-browsing, and https://wiki.debian.org/OpenVPN and http://keithscode.com/blog/10-wan-ip-from-a-bash-script.html and http://www.raspberrypi.org/forums/viewtopic.php?t=81657
# OpenVPN is copyright of their respective holders.
#
#
# Start of script
#
# Init of variables :
#	    1 : servername to use
#		2 : WAN IP address
#		3 : WAN Port
#
echo -e "Usage: sudo bash $0 <servername> <wanip> <wanport> \nIf no/some arguments are provided, defaults are used.\n\n"
if [ -n "$1" ]; then servername=$1; else servername="MyOpenVPNServer"; fi
if [ -n "$2" ]; then wanip=$2; else wanip=`wget -q -O - http://ip.keithscode.com`; fi
if [ -n "$3" ]; then wanport=$3; else wanport="1194"; fi
echo -e "INSTALLING OpenVPN.\nUsing servername $servername, and wan $wanip on port $wanport"  

# should always run as sudo
if [ "$(id -u)" != "0" ]; then
	echo "Sorry, you are not root. Try using sudo to run this script: sudo bash $0 etc..."
	exit 1
fi

# get the package
sudo apt-get -y install openvpn openssl

# prepare setup of keys
cp -r /usr/share/doc/openvpn/examples/easy-rsa/2.0 /etc/openvpn/easy-rsa
cd /etc/openvpn/easy-rsa

# general configuration openvpn 
sed -i '/EASY_RSA=/c\EASY_RSA="/etc/openvpn/easy-rsa"' /etc/openvpn/easy-rsa/vars
sed -i "s|KEY_SIZE=2048|KEY_SIZE=1024|" /etc/openvpn/easy-rsa/vars   # probably not needed

# load vars and clear all keys (rerun)
source ./vars
./clean-all

# the CA
whiptail --msgbox "Will now build the CA authority. You will be prompted a lot. Just select the default value by pressing enter or enter no passwords if that is asked." 20 70
./build-ca

# the server
whiptail --msgbox "Will now build the server key for $servername. You will be prompted a lot. Just select the default value by pressing enter or enter no passwords if that is asked. Then select y if that is asked (two times:sign and commit)" 20 70
./build-key-server $servername

# Generate the static HMAC key (security against DoS) - not used yet (bug in client config generation)
openvpn --genkey --secret /etc/openvpn/easy-rsa/keys/ta.key

# get the ovpn client maker
mkdir /etc/openvpn/ovpn
wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/make_vpn_client.sh?format=raw -O /etc/openvpn/ovpn/make_vpn_client.sh &> /dev/null
chmod -R 777 /etc/openvpn/ovpn

# now we are going to build the key for the clients, including openvpn files (ovpn)
wantsitems=0
clientcounter=1

# do it until user is finished
while [ $wantsitems -eq 0 ]; do
	# ask the client name
	clientname=$(whiptail --inputbox --backtitle "N A Z v e r r y P i e - with Cream" --title "OpenVPN client - name" "Enter name of client to be used for client key generation and ovpn file generation (please no spaces or special chars in this name). After this, select the defaults and select y for key generation. You will be prompted to provide a password for the private key on the client  - take one of at least 4 characters." 10 50 "OPENVPN_Client$clientcounter" 3>&1 1>&2 2>&3)
	
	# make the config file
	bash /etc/openvpn/ovpn/make_vpn_client.sh $clientname $wanip $wanport
	
	# want more?
	whiptail --yesno "Do want to configure another client?" --yes-button "Yes" --no-button "No" 0 0 
	wantsitems=$?

	# increase counter
	clientcounter=$[clientcounter + 1]
done

# Diffie-Huffman - which can take a while
./build-dh

# configure openvpn server - get a server config file from the openvpn distribution
rm /etc/openvpn/server.conf
gunzip -c /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz > /etc/openvpn/server.conf 

# Change the server.conf
# the IP adress of the RPI (taken from http://stackoverflow.com/questions/6829605/putting-ip-address-into-bash-variable-is-there-a-better-way)
# first try to find on the fixed ethernet, otherwise a wlan
ip=$(ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1)
 
# is it there, if not, try the wlan adapter
if [ -z "$ip" ]; then
     ip=$(ip -f inet -o addr show wlan0|cut -d\  -f 7 | cut -d/ -f 1)
fi
# and if everything is failing, go for loopback
if [ -z "$ip" ]; then
	ip="127.0.0.1"
fi

# following the debian openvpn wiki here for all other configurations
sed -i "s|;local a.b.c.d|local $ip|" /etc/openvpn/server.conf
sed -i "s|port 1194|port $wanport|" /etc/openvpn/server.conf
sed -i "s|ca ca.crt|ca /etc/openvpn/easy-rsa/keys/ca.crt|" /etc/openvpn/server.conf
sed -i "s|cert server.crt|cert /etc/openvpn/easy-rsa/keys/$servername.crt|" /etc/openvpn/server.conf
sed -i "s|key server.key|key /etc/openvpn/easy-rsa/keys/$servername.key|" /etc/openvpn/server.conf
sed -i "s|dh dh1024.pem|dh /etc/openvpn/easy-rsa/keys/dh1024.pem|" /etc/openvpn/server.conf
#sed -i "s|;tls-auth ta.key|tls-auth easy-rsa/keys/ta.key|" /etc/openvpn/server.conf   #skipping as there is issue with client side
sed -i "s|;user nobody|user nobody|" /etc/openvpn/server.conf  
sed -i "s|;group nogroup|group nogroup|" /etc/openvpn/server.conf  
sed -i 's|;push "redirect-gateway def1 bypass-dhcp"|push "redirect-gateway def1 bypass-dhcp"|' /etc/openvpn/server.conf
sed -i 's|;push "dhcp-option DNS 208.67.222.222"|push "dhcp-option DNS 208.67.222.222"|'  /etc/openvpn/server.conf
sed -i 's|;push "dhcp-option DNS 208.67.220.220"|push "dhcp-option DNS 208.67.220.220"|'  /etc/openvpn/server.conf
# finished server.conf

#
# Now going into network configuration
#
# change the forwarding in the Pi
sed -i "s|#net.ipv4.ip_forward=1|net.ipv4.ip_forward=1|" /etc/sysctl.conf
sysctl -p

# change the Pi firewall to allow forwarding after reboot
rm -f /etc/firewall-openvpn-rules.sh
echo '#!/bin/sh' >> /etc/firewall-openvpn-rules.sh
echo "iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j SNAT --to-source $ip" >> /etc/firewall-openvpn-rules.sh
chmod 700 /etc/firewall-openvpn-rules.sh
chown root /etc/firewall-openvpn-rules.sh

# post the stuff in the interfaces file
sed -i '/openvpn-rules.sh/d' /etc/network/interfaces # support on rerun
rm /home/pi/interfaces.old
mv /etc/network/interfaces /home/pi/interfaces.old
grep -B2000 "iface eth0 inet dhcp" /home/pi/interfaces.old > /etc/network/interfaces
echo -e "\tpre-up /etc/firewall-openvpn-rules.sh" >>  /etc/network/interfaces
grep -A2000 "iface eth0 inet dhcp" /home/pi/interfaces.old | tail -n+2 >> /etc/network/interfaces

# post the table entry now too
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j SNAT --to-source $ip

# restart openvpn
/etc/init.d/openvpn restart

# add the openvpn directory to SAMBA, in case the user wants to install SAMBA of course	
echo "
[OpenVPN OVPN files]
path = /etc/openvpn/ovpn/
browseable=Yes
writeable=Yes
only guest=no
create mask=0777
directory mask=0777
public=yes" >> /home/pi/smbconfigtail.conf
