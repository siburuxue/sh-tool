#!/bin/bash

curl -O https://distfiles.macports.org/MacPorts/MacPorts-2.10.5.tar.bz2
tar xf MacPorts-2.10.5.tar.bz2
cd MacPorts-2.10.5/ && ./configure && make && sudo make install
echo 'export PATH="/opt/local/bin:/opt/local/sbin:$PATH"' >> ~/,zprofile
echo 'export MANPATH="/opt/local/share/man:$MANPATH"' >> ~/,zprofile
echo 'export DISPLAY=":0.0"' >> ~/,zprofile
source ~/.zprofile
sudo port selfupdate
sudo port install autoconf automake libtool pkgconfig zlib wxWidgets-3.0
cd /usr/local/etc && git clone https://github.com/MediaArea/ZenLib.git
cd /usr/local/etc/ZenLib/Project/GNU/Library && ./autogen.sh && ./configure --enable-static && make
cd /usr/local/etc && git clone https://github.com/MediaArea/MediaInfoLib.git
cd /usr/local/etc/MediaInfoLib/Project/GNU/Library && ./autogen.sh && ./configure --enable-static && make
cd /usr/local/etc && git clone https://github.com/MediaArea/MediaInfo.git
cd /usr/local/etc/MediaInfo/Project/GNU/CLI && ./autogen.sh && ./configure --enable-staticlibs && make
ln -s /usr/local/etc/MediaInfo/Project/GNU/CLI/mediainfo /usr/local/bin/mediainfo
mediainfo --Help