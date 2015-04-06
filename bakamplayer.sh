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
LIBGCC=libgcc_s_seh-1.dll
else
PREFIX=/mingw32
LIBGCC=libgcc_s_dw2-1.dll
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
cp $PREFIX/bin/avcodec-56.dll \
$PREFIX/bin/avdevice-56.dll \
$PREFIX/bin/avfilter-5.dll \
$PREFIX/bin/avformat-56.dll \
$PREFIX/bin/avresample-2.dll \
$PREFIX/bin/avutil-54.dll \
$PREFIX/bin/libass-5.dll \
$PREFIX/bin/libbluray-1.dll \
$PREFIX/bin/libbz2-1.dll \
$PREFIX/bin/libcaca-0.dll \
$PREFIX/bin/libcelt0-2.dll \
$PREFIX/bin/libdvdcss-2.dll \
$PREFIX/bin/libdvdnav-4.dll \
$PREFIX/bin/libdvdread-4.dll \
$PREFIX/bin/libeay32.dll \
$PREFIX/bin/libenca-0.dll \
$PREFIX/bin/libexpat-1.dll \
$PREFIX/bin/libffi-6.dll \
$PREFIX/bin/libfontconfig-1.dll \
$PREFIX/bin/libfreetype-6.dll \
$PREFIX/bin/libfribidi-0.dll \
$PREFIX/bin/$LIBGCC \
$PREFIX/bin/libglib-2.0-0.dll \
$PREFIX/bin/libgmp-10.dll \
$PREFIX/bin/libgnutls-28.dll \
$PREFIX/bin/libgsm.dll \
$PREFIX/bin/libguess.dll \
$PREFIX/bin/libharfbuzz-0.dll \
$PREFIX/bin/libhogweed-2-5.dll \
$PREFIX/bin/libiconv-2.dll \
$PREFIX/bin/libicudt54.dll \
$PREFIX/bin/libicuin54.dll \
$PREFIX/bin/libicuuc54.dll \
$PREFIX/bin/libintl-8.dll \
$PREFIX/bin/libjasper-1.dll \
$PREFIX/bin/libjbig-0.dll \
$PREFIX/bin/libjpeg-8.dll \
$PREFIX/bin/liblcms2-2.dll \
$PREFIX/bin/liblzma-5.dll \
$PREFIX/bin/libmng-2.dll \
$PREFIX/bin/libmodplug-1.dll \
$PREFIX/bin/libmp3lame-0.dll \
$PREFIX/bin/libmpg123-0.dll \
$PREFIX/bin/libnettle-4-7.dll \
$PREFIX/bin/libogg-0.dll \
$PREFIX/bin/libopencore-amrnb-0.dll \
$PREFIX/bin/libopencore-amrwb-0.dll \
$PREFIX/bin/libopenjpeg-5.dll \
$PREFIX/bin/libopus-0.dll \
$PREFIX/bin/liborc-0.4-0.dll \
$PREFIX/bin/libp11-kit-0.dll \
$PREFIX/bin/libpcre16-0.dll \
$PREFIX/bin/libpng16-16.dll \
$PREFIX/bin/librtmp-1.dll \
$PREFIX/bin/libschroedinger-1.0-0.dll \
$PREFIX/bin/libspeex-1.dll \
$PREFIX/bin/libstdc++-6.dll \
$PREFIX/bin/libtasn1-6.dll \
$PREFIX/bin/libtheoradec-1.dll \
$PREFIX/bin/libtheoraenc-1.dll \
$PREFIX/bin/libtiff-5.dll \
$PREFIX/bin/libvorbis-0.dll \
$PREFIX/bin/libvorbisenc-2.dll \
$PREFIX/bin/libvpx-1.dll \
$PREFIX/bin/libwavpack-1.dll \
$PREFIX/bin/libwebp-5.dll \
$PREFIX/bin/libwinpthread-1.dll \
$PREFIX/bin/libx264-142.dll \
$PREFIX/bin/libx265.dll \
$PREFIX/bin/libxml2-2.dll \
$PREFIX/bin/libzip-2.dll \
$PREFIX/bin/mpv-1.dll \
$PREFIX/bin/OpenAL32.dll \
$PREFIX/bin/postproc-53.dll \
$PREFIX/bin/SDL.dll \
$PREFIX/bin/ssleay32.dll \
$PREFIX/bin/swresample-1.dll \
$PREFIX/bin/swscale-3.dll \
$PREFIX/bin/xvidcore.dll \
$PREFIX/bin/zlib1.dll \
$PREFIX/bin/Qt5Core.dll \
$PREFIX/bin/Qt5Gui.dll \
$PREFIX/bin/Qt5Network.dll \
$PREFIX/bin/Qt5Svg.dll \
$PREFIX/bin/Qt5Widgets.dll \
$PREFIX/bin/Qt5WinExtras.dll Baka-MPlayer_$arch
mkdir Baka-MPlayer_$arch/bearer
mkdir Baka-MPlayer_$arch/iconengines
mkdir Baka-MPlayer_$arch/imageformats
mkdir Baka-MPlayer_$arch/platforms
cp $PREFIX/share/qt5/plugins/imageformats/qdds.dll \
$PREFIX/share/qt5/plugins/imageformats/qgif.dll \
$PREFIX/share/qt5/plugins/imageformats/qicns.dll \
$PREFIX/share/qt5/plugins/imageformats/qico.dll \
$PREFIX/share/qt5/plugins/imageformats/qjp2.dll \
$PREFIX/share/qt5/plugins/imageformats/qjpeg.dll \
$PREFIX/share/qt5/plugins/imageformats/qmng.dll \
$PREFIX/share/qt5/plugins/imageformats/qsvg.dll \
$PREFIX/share/qt5/plugins/imageformats/qtga.dll \
$PREFIX/share/qt5/plugins/imageformats/qtiff.dll \
$PREFIX/share/qt5/plugins/imageformats/qwbmp.dll \
$PREFIX/share/qt5/plugins/imageformats/qwebp.dll Baka-MPlayer_$arch/imageformats
cp $PREFIX/share/qt5/plugins/bearer/qgenericbearer.dll \
$PREFIX/share/qt5/plugins/bearer/qnativewifibearer.dll Baka-MPlayer_$arch/bearer
cp $PREFIX/share/qt5/plugins/iconengines/qsvgicon.dll Baka-MPlayer_$arch/iconengines
cp $PREFIX/share/qt5/plugins/platforms/qwindows.dll Baka-MPlayer_$arch/platforms
mkdir Baka-MPlayer_$arch/etc
cp -r $PREFIX/etc/fonts Baka-MPlayer_$arch/etc
cp ../mpv/fonts.conf Baka-MPlayer_$arch/etc/fonts
cp -r ../fonts Baka-MPlayer_$arch
cp -r ../mpv Baka-MPlayer_$arch
