#!/bin/bash

# Build script for bakamplayer for native msys2/mingw-w64 by FrankHB.
# based on official scripts.
# Usage: ./baka-mplayer.sh $arch /e/Source/baka-mplayer
# The 3rd argument is optional, using number of CPU cores if not preset.

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

if [[ $2 == '' ]]; then
echo "Please specify mpv source directory."
exit
else
baka_src="$2"
fi

if [[ $3 != '' ]]; then
JOBS="$3"
else
JOBS=-j`grep -c ^processor /proc/cpuinfo`
fi

#pacman -S mingw-w64-$arch-ffmpeg mingw-w64-i686-libass \
#mingw-w64-i686-libbluray mingw-w64-$arch-qt5 --needed

# build baka
pushd "$baka_src"

QMAKE=$PREFIX/bin/qmake ./configure CONFIG+=embed_translations lupdate=$PREFIX/bin/lupdate lrelease=$PREFIX/bin/lrelease
make $JOBS
