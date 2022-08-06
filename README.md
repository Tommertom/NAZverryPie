# NAZverryPie 
NAZverryPie installation script to turn your Raspberry Pi onto a NAS almost totally unattended. The NAS will be a home-type of NAS, mostly supporting nice user applications. So unlike FreeNAS etc. This type of NAS is most likely to be used by people wanting to try the Pi as replacement of the Synology home models (or the like) for simple home use. At least, that is why I started this project.
Currently features the following modules:
- NZBget
- ownCloud
- domoticz
- Samba
- PHP/apache
- PiWeb Agent
- Webmin
- OpenVPN including a bash script to build keys and ovpn files
- Youtube downloader webui with mp3 convertor
- mysql and phpmyadmin
- Small tools: vsftp, rsync
- duckDNS
- Ajenti
- Tonido
- apache
- Simple wrapper page in HTML to access the modules in an iframed page

And a script to build your fstab

All you can use in one, or just separately, on the commandline

Some scripting expertise will be nice, as it has been a while since the scripts were created


# How to use
Write the debian image to your SD card and boot the RPI with it
SSH to RPI and login as pi (or plug keyboard in, HDMI cable and log into the console)
Run sudo raspi-config and enable SSH in Interfaces
Use putty to access the Raspberry Pi
Download the latest version of the script by issuing the command:
wget https://sourceforge.net/p/nazverrypie/code/ci/master/tree/nazverrypie.sh?format=raw -O nazverrypie.sh
Run the script by issuing the command:
bash nazverrypie.sh 
or use bash -x nazverrypie.sh if you like to see the commands going
