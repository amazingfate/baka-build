Baka-MPlayer
------------
https://github.com/u8sand/Baka-MPlayer
Usages:
=======
For Windows developers looking to get started quickly, MSYS2 can be used to compile Baka-MPlayer natively on a Windows machine. The MSYS2 repositories have binary packages of mingw-w64-qt5 and mpv, so the process should only involve building Baka-MPlayer itself.

To build 64-bit version on Windows:
Installing MSYS2
----------------
1. Download an installer from https://msys2.github.io/

   It doesn't matter whether the i686 or the x86_64 version is used. Both can
   build 32-bit and 64-bit binaries when running on a 64-bit version of Windows.

2. Add ``C:\msys64\mingw64\bin`` to your ``%PATH%``. mpv will depend on several
   DLLs in this folder.

3. Start a MinGW-w64 shell (``mingw64_shell.bat``). For a 32-bit build, use
   ``mingw32_shell.bat``.
Updating MSYS2
--------------

To prevent errors during post-install, ``msys2-runtime`` and ``pacman`` must be
updated first.

```bash
# Check for updates to msys2-runtime and pacman. If there were updates, restart
# MSYS2 before continuing.
pacman -Sy --needed msys2-runtime pacman

# Update everything else
pacman -Su
```
Installing Build Dependences
----------------------
```
pacman -S  git mingw-w64-x86_64-gcc mingw-w64-x86_64-binutils mingw-w64-x86_64-make base-devel mingw-w64-x86_64-qt5 mingw-w64-x86_64-pkg-config mingw-w64-x86_64-mpv mingw-w64-x86_64-libzip
```
The time of this process depends on the speed of your internet because qt5 is a large package.
Start Building
--------------
```
arch=x86_64
./bakamplayer.sh $arch
```
If everything succeeded without error, baka-mplayer.exe will be built under Baka-MPlayer.x86_64/build/, and you can find baka-mplayer.exe with full dlls in directory Baka-MPlayer.x86_64/Baka-MPlayer_x86_64
Static Build
============
If you want to build it staticly, you have to build a static version of mpv.
NOTE
----
This is not recommanded because I can't build it with dxva2 and libbluray support, although the size will be smaller.
Build Static Deps of Mpv
------------------------
First install the deps of building mpv:
```
pacman -S git pkg-config python3 mingw-w64-x86_64-gcc gcc mingw-w64-x86_64-ffmpeg mingw-w64-x86_64-libjpeg-turbo mingw-w64-x86_64-lua mingw-w64-x86_64-libdvdnav mingw-w64-x86_64-mpg123 mingw-w64-x86_64-libguess
```
And run:
```
arch=x86_64
./mpv.sh $arch
```
It will show you a list of lib can't be found by ld,and you have to download the PKGBUILDs of these packages from: https://github.com/Alexpux/MINGW-packages.

And then build these packages a static version by editing their PKGBUILDS.

Most packages can build a static version by adding ```--enable-static``` or ```--enable-static --disable-static``` to the configure parameter, for some packages using cmake you have to add ```DLIBTYPE=STATIC```.

Note that xvidcore is built as xvidcore.a, you have to ```ln -s /mingw64/lib/xvidcore.a /mingw64/lib/libxvidcore.a``` to let it be recognized by ld.

Libbluray
---------
There is something wrong with libbluray and libxml2, so we have to disable it

Static Libguess
---------------
I have not built a static mpv successfully because I can't build a static version of libguess. Anyone knows please tell me. You have to add ```disable-libguess``` to configure or just remove the package ```mingw-w64-x86_64-libguess```. 

Install Qt5-static
------------------
```
pacman -S mingw-w64-x86_64-qt5-static
```
Installing Build Dependences
----------------------------
```
pacman -S mingw-w64-x86_64-pkg-config mingw-w64-x86_64-libzip
```
Build Baka-MPlayer
------------------
```
arch=x86_64
./bakamplayer-static.sh $arch
```
I failed to build with log: http://paste.ubuntu.com/9804052/
To solve this, you have to edit the file ```mpv.pc``` in ```/mingw64/lib/pkgconfig``` like this:
```
prefix=/mingw64
exec_prefix=/mingw64
libdir=/mingw64/bin
includedir=/mingw64/include

Name: mpv
Description: mpv media player client library
Version: 1.13.0
Requires:
Libs: -L${libdir} -lmpv -lass -llua -ldvdcss -lavcodec -ldvdnav -lmpg123 -lcaca -lxml2 -lfontconfig -lfreetype -lavdevice -lavfilter -lavformat -lavresample -lavutil -lenca -lm -lfribidi -lglib-2.0 -lintl -lxml2 -lbz2 -ldvdread -ldvdcss -lmingw32 -lSDLmain -lSDL -liconv -lswscale -lswresample -llcms2 -lz -lharfbuzz -lexpat -lgnutls
Libs.private: -lenca -lgdi32 -lopengl32 -liconv -ljpeg -lm -lole32 -luuid -lole32 -lwinmm -lz 
Cflags: -I${includedir}
```





