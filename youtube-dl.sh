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
# Youtube downloader
# Taken from sourceforge. With own built extension
#

# should always run as 
if [ "$(id -u)" != "0" ]; then
        echo "Sorry, you are not root."
        exit 1
fi

echo -e "INSTALLING YOUTUBE downloader with MP3 support"

videodir="/var/www/youtube-dl-webui/mp4"

# get youtube downloader
wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
chmod a+x /usr/local/bin/youtube-dl

# get the encoding stuff
apt-get -y install ffmpeg

# make the directories for the downloader and convertor
# MP3 are put per default in WWW directory, for futue SONOS support
mkdir /var/www/youtube-dl-webui
mkdir /var/www/youtube-dl-webui/mp3
mkdir -p "$videodir"

# change attributes so we can change the content through samba
chmod 777 /var/www/youtube-dl-webui/mp3
chmod 777 "$videodir"

# get the webui
wget https://sourceforge.net/p/youtubedlwebuiextended/code/ci/master/tree/www-root%20files/www-root%20files.zip?format=raw -O /var/www/youtube-dl-webui/master.zip
unzip -o -d /var/www/youtube-dl-webui/ /var/www/youtube-dl-webui/master.zip
rm /var/www/youtube-dl-webui/master.zip


# set the configuration of the video dir and put the files in the www-root
sed -i "s|videos/|$videodir/|" /var/www/youtube-dl-webui/config.php
# disable login
sed -i "s|security = 1|security = 0|" /var/www/youtube-dl-webui/config.php

# set the rights properly
chown -R www-data:www-data /var/www/

# create a small script that handles the MP3 encoding after video download. Uses simple locking mechanism to avoid overloading the Pi
rm -f /usr/local/bin/youtube-dl-mp3
cat << 'EOF' > /home/pi/youtube-dl-mp3
#!/bin/bash
#$1 : url
#$2 : dest dir for video
#$3 : dest dir for mp3

# obtain lock so all processes are queued
while [ -e "/var/tmp/youtube-dl-mp3.lock" ]; do
sleep 100
done

touch "/var/tmp/youtube-dl-mp3.lock"

youtube-dl -o "$2%(title)s.%(ext)s" $1

outfile=$(youtube-dl -o "%(title)s.%(ext)s" --get-filename $1)

if [ ! -z $3 ]; then 
        ffmpeg -i "$2$outfile" "$3${outfile%.*}.mp3" 
		
		# set the permissions right of all files in the mp4 dir
		chmod -R 666 $3
fi

# set the permissions right of all files in the mp3 dir
chmod -R 666 $2

# remove file lock
rm -f "/var/tmp/youtube-dl-mp3.lock"

EOF
chmod 777 /home/pi/youtube-dl-mp3

# dont know why doing this???
mv /home/pi/youtube-dl-mp3	 /usr/local/bin/youtube-dl-mp3

chmod 777 $videodir
chmod 777 /var/www/youtube-dl-webui/mp3

# add the directories to SAMBA, in case the user wants to install SAMBA of course	
echo "
[YoutubeDownload-Video]
path = $videodir
browseable=Yes
writeable=Yes
only guest=no
create mask=0777
directory mask=0777
public=yes" >> /home/pi/smbconfigtail.conf


echo "
[YoutubeDownload-MP3]
path = /var/www/youtube-dl-webui/mp3
browseable=Yes
writeable=Yes
only guest=no
create mask=0777
directory mask=0777
public=yes" >> /home/pi/smbconfigtail.conf

