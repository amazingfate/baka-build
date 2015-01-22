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

# get mpv
git clone https://github.com/mpv-player/mpv.git mpv.$arch
cd mpv.$arch
git pull


# build mpv
python3.3 bootstrap.py
DEST_OS=win32 TARGET=$arch-w64-mingw32 PKG_CONFIG=/usr/bin/pkg-config CC=gcc PERL=$PREFIX/bin/perl AR=$PREFIX/bin/ar WINDRES=$PREFIX/bin/windres \
python3.3 waf configure --check-c-compiler=gcc --prefix=$PREFIX \
--enable-libmpv-static --disable-client-api-examples --disable-libguess --disable-libbluray --enable-static-build
python3.3 waf build
python3.3 waf install

instroot=$PREFIX
mv $instroot/bin/libmpv.a $instroot/lib
mv $instroot/bin/pkgconfig/mpv.pc $instroot/lib/pkgconfig
sed -i 's_/instroot/bin_/$instroot/lib_' $instroot/lib/pkgconfig/mpv.pc
rmdir $instroot/bin/pkgconfig
