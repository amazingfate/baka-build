#!/bin/bash

if [[ $1 == 'x86_64' ]]; then
arch=x86_64
elif [[ $1 == 'i686' ]]; then
arch=i686
else
echo "Please specify either x86_64 or i686 architecture."
exit;
fi

if [[ $arch == 'x86_64' ]]; then
PREFIX=/mingw64
else
PREFIX=/mingw32
fi

# get baka-mplayer
git clone https://github.com/u8sand/Baka-MPlayer.git Baka-MPlayer.$arch
cd Baka-MPlayer.$arch
git pull

# build baka-mplayer

QMAKE=$PREFIX/bin/qmake \
./configure \
CONFIG+=embed_translations \ 
lupdate=$PREFIX/bin/lupdate \
lrelease=$PREFIX/bin/lrelease
mingw32-make -j `grep -c ^processor /proc/cpuinfo`
