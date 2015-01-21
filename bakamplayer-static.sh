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
git clone https://github.com/u8sand/Baka-MPlayer.git Baka-MPlayer_static.$arch
cd Baka-MPlayer_static.$arch
git pull

# build baka-mplayer

QMAKE=$PREFIX/qt5-static/bin/qmake \
./configure \
CONFIG+=embed_translations \ 
lupdate=$PREFIX/qt5-static/bin/lupdate \
lrelease=$PREFIX/qt5-static/bin/lrelease
mingw32-make -j `grep -c ^processor /proc/cpuinfo`
