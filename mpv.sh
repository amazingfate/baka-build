#!/bin/bash

# Build script for bakamplayer for native msys2/mingw-w64 by FrankHB.
# based on official scripts.
# Usage: ./mpv.sh $arch /e/Source/mpv
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
mpv_src="$2"
fi

if [[ $3 != '' ]]; then
JOBS="$3"
else
JOBS=-j`grep -c ^processor /proc/cpuinfo`
fi

#pacman -S mingw-w64-$arch-ffmpeg mingw-w64-$arch-libass \
#mingw-w64-$arch-libbluray mingw-w64-$arch-qt5-static --needed

# build mpv
pushd "$mpv_src"
python3.3 bootstrap.py
export PATH=$PREFIX/bin:$PATH
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
DEST_OS=win32 TARGET=$arch-w64-mingw32 PKG_CONFIG=/usr/bin/pkg-config CC=gcc PERL=$PREFIX/bin/perl AR=$PREFIX/bin/ar \
python3.3 waf configure --check-c-compiler=gcc --prefix=$PREFIX \
--enable-libmpv-shared --disable-client-api-examples
python3.3 waf build $JOBS
python3.3 waf install

instroot=$PREFIX
mv $instroot/bin/libmpv.dll.a $instroot/lib
mv $instroot/bin/pkgconfig/mpv.pc $instroot/lib/pkgconfig
sed -i 's_/instroot/bin_/$instroot/lib_' $instroot/lib/pkgconfig/mpv.pc
rmdir $instroot/bin/pkgconfig
popd

# build baka-mplayer
#QMAKE="$PREFIX/bin/qmake" \
#./configure \
#"CONFIG+=embed_translations" \
#"lupdate=$PREFIX/bin/lupdate" \
#"lrelease=$PREFIX/bin/lrelease"
#make $JOBS
