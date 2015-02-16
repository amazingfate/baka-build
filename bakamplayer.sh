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
rm -rf Baka-MPlayer.$arch
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

#release dlls and exe to a new directory
mkdir Baka-MPlayer_$arch
cp build/baka-mplayer.exe Baka-MPlayer_$arch
cp /mingw64/bin/avcodec-56.dll \
/mingw64/bin/avdevice-56.dll \
/mingw64/bin/avfilter-5.dll \
/mingw64/bin/avformat-56.dll \
/mingw64/bin/avresample-2.dll \
/mingw64/bin/avutil-54.dll \
/mingw64/bin/libass-5.dll \
/mingw64/bin/libbluray-1.dll \
/mingw64/bin/libbz2-1.dll \
/mingw64/bin/libcaca-0.dll \
/mingw64/bin/libcelt0-2.dll \
/mingw64/bin/libdvdcss-2.dll \
/mingw64/bin/libdvdnav-4.dll \
/mingw64/bin/libdvdread-4.dll \
/mingw64/bin/libenca-0.dll \
/mingw64/bin/libexpat-1.dll \
/mingw64/bin/libffi-6.dll \
/mingw64/bin/libfontconfig-1.dll \
/mingw64/bin/libfreetype-6.dll \
/mingw64/bin/libfribidi-0.dll \
/mingw64/bin/libgcc_s_seh-1.dll \
/mingw64/bin/libglib-2.0-0.dll \
/mingw64/bin/libgmp-10.dll \
/mingw64/bin/libgnutls-28.dll \
/mingw64/bin/libgsm.dll \
/mingw64/bin/libguess.dll \
/mingw64/bin/libharfbuzz-0.dll \
/mingw64/bin/libhogweed-2-5.dll \
/mingw64/bin/libiconv-2.dll \
/mingw64/bin/libicudt54.dll \
/mingw64/bin/libicuin54.dll \
/mingw64/bin/libicuuc54.dll \
/mingw64/bin/libintl-8.dll \
/mingw64/bin/libjasper-1.dll \
/mingw64/bin/libjbig-0.dll \
/mingw64/bin/libjpeg-8.dll \
/mingw64/bin/liblcms2-2.dll \
/mingw64/bin/liblzma-5.dll \
/mingw64/bin/libmng-2.dll \
/mingw64/bin/libmodplug-1.dll \
/mingw64/bin/libmp3lame-0.dll \
/mingw64/bin/libmpg123-0.dll \
/mingw64/bin/libnettle-4-7.dll \
/mingw64/bin/libogg-0.dll \
/mingw64/bin/libopencore-amrnb-0.dll \
/mingw64/bin/libopencore-amrwb-0.dll \
/mingw64/bin/libopenjpeg-5.dll \
/mingw64/bin/libopus-0.dll \
/mingw64/bin/liborc-0.4-0.dll \
/mingw64/bin/libp11-kit-0.dll \
/mingw64/bin/libpcre16-0.dll \
/mingw64/bin/libpng16-16.dll \
/mingw64/bin/librtmp-1.dll \
/mingw64/bin/libschroedinger-1.0-0.dll \
/mingw64/bin/libspeex-1.dll \
/mingw64/bin/libstdc++-6.dll \
/mingw64/bin/libtasn1-6.dll \
/mingw64/bin/libtheoradec-1.dll \
/mingw64/bin/libtheoraenc-1.dll \
/mingw64/bin/libtiff-5.dll \
/mingw64/bin/libvorbis-0.dll \
/mingw64/bin/libvorbisenc-2.dll \
/mingw64/bin/libvpx-1.dll \
/mingw64/bin/libwavpack-1.dll \
/mingw64/bin/libwebp-5.dll \
/mingw64/bin/libwinpthread-1.dll \
/mingw64/bin/libx264-142.dll \
/mingw64/bin/libx265.dll \
/mingw64/bin/libxml2-2.dll \
/mingw64/bin/libzip-2.dll \
/mingw64/bin/mpv-1.dll \
/mingw64/bin/OpenAL32.dll \
/mingw64/bin/postproc-53.dll \
/mingw64/bin/SDL.dll \
/mingw64/bin/swresample-1.dll \
/mingw64/bin/swscale-3.dll \
/mingw64/bin/xvidcore.dll \
/mingw64/bin/zlib1.dll \
/mingw64/bin/Qt5Core.dll \
/mingw64/bin/Qt5Gui.dll \
/mingw64/bin/Qt5Network.dll \
/mingw64/bin/Qt5Svg.dll \
/mingw64/bin/Qt5Widgets.dll \
/mingw64/bin/Qt5WinExtras.dll Baka-MPlayer_$arch
mkdir Baka-MPlayer_$arch/bearer
mkdir Baka-MPlayer_$arch/iconengines
mkdir Baka-MPlayer_$arch/imageformats
mkdir Baka-MPlayer_$arch/platforms
cp /mingw64/share/qt5/plugins/imageformats/qdds.dll \
/mingw64/share/qt5/plugins/imageformats/qgif.dll \
/mingw64/share/qt5/plugins/imageformats/qicns.dll \
/mingw64/share/qt5/plugins/imageformats/qico.dll \
/mingw64/share/qt5/plugins/imageformats/qjp2.dll \
/mingw64/share/qt5/plugins/imageformats/qjpeg.dll \
/mingw64/share/qt5/plugins/imageformats/qmng.dll \
/mingw64/share/qt5/plugins/imageformats/qsvg.dll \
/mingw64/share/qt5/plugins/imageformats/qtga.dll \
/mingw64/share/qt5/plugins/imageformats/qtiff.dll \
/mingw64/share/qt5/plugins/imageformats/qwbmp.dll \
/mingw64/share/qt5/plugins/imageformats/qwebp.dll Baka-MPlayer_$arch/imageformats
cp /mingw64/share/qt5/plugins/bearer/qgenericbearer.dll \
/mingw64/share/qt5/plugins/bearer/qnativewifibearer.dll Baka-MPlayer_$arch/bearer
cp /mingw64/share/qt5/plugins/iconengines/qsvgicon.dll Baka-MPlayer_$arch/iconengines
cp /mingw64/share/qt5/plugins/platforms/qwindows.dll Baka-MPlayer_$arch/platforms
