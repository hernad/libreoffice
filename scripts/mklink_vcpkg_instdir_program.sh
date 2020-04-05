#!/bin/bash

# as Administrator
#$ scripts/mklink_vcpkg_instdir_program.sh
#cmd /c mklink instdir\program\libpq.dll C:\dev\vcpkg\installed\x86-windows\bin\libpq.dll
#symbolic link created for instdir\program\libpq.dll <<===>> C:\dev\vcpkg\installed\x86-windows\bin\libpq.dll
#cmd /c mklink instdir\program\zlib1.dll C:\dev\vcpkg\installed\x86-windows\bin\zlib1.dll
#symbolic link created for instdir\program\zlib1.dll <<===>> C:\dev\vcpkg\installed\x86-windows\bin\zlib1.dll


function mklink() {
 #rm -f `cygpath -w instdir/program/$FILE`
 if [ ! -f `cygpath -w instdir/program/$FILE` ] ; then
    echo $MKLINK `cygpath -w instdir/program/$FILE` `cygpath -w $SRC_DIR/$FILE`
    $MKLINK `cygpath -w instdir/program/$FILE` `cygpath -w $SRC_DIR/$FILE`
 else
    echo "EXISTS: $(cygpath -w instdir/program/$FILE)"
  fi
}

if [ "$BUILD_ARCH" = "x64" ] ; then
  SRC_DIR=c:/dev/vcpkg/installed/x64-windows/bin
  BOOST_ARCH=x64
else
  SRC_DIR=c:/dev/vcpkg/installed/x86-windows/bin
  BOOST_ARCH=x32
fi
MKLINK="cmd /c mklink"

# c:\dev\libreoffice-core-meson\instdir\program>c:\dev\Listdlls.exe soffice.bin | grep vcpkg
# 0x000000005c8a0000  0x165000  c:\dev\vcpkg\installed\x86-windows\bin\icuuc65.dll
# 0x000000005c730000  0x16000   c:\dev\vcpkg\installed\x86-windows\bin\zlib1.dll
# 0x00000000580d0000  0x119000  c:\dev\vcpkg\installed\x86-windows\bin\libxml2.dll
# 0x0000000057eb0000  0x21f000  c:\dev\vcpkg\installed\x86-windows\bin\icuin65.dll
# 0x0000000057690000  0x66000   c:\dev\vcpkg\installed\x86-windows\bin\boost_locale-vc142-mt-x32-1_72.dll
# 0x00000000575f0000  0x2c000   c:\dev\vcpkg\installed\x86-windows\bin\libpng16.dll
# 0x0000000057470000  0xe4000   c:\dev\vcpkg\installed\x86-windows\bin\libiconv.dll
# 0x0000000057440000  0x23000   c:\dev\vcpkg\installed\x86-windows\bin\lzma.dll
# 0x000000005c440000  0x1c000   c:\dev\vcpkg\installed\x86-windows\bin\boost_filesystem-vc142-mt-x32-1_72.dll
# 0x00000000573e0000  0x19000   c:\dev\vcpkg\installed\x86-windows\bin\boost_iostreams-vc142-mt-x32-1_72.dll
# 0x00000000573c0000  0x6000    c:\dev\vcpkg\installed\x86-windows\bin\libcharset.dll
# 0x00000000573a0000  0x12000   c:\dev\vcpkg\installed\x86-windows\bin\bz2.dll
# 0x0000000057320000  0x72000   c:\dev\vcpkg\installed\x86-windows\bin\zstd.dll
# 0x0000000003ca0000  0x1ab1000  c:\dev\vcpkg\installed\x86-windows\bin\icudt65.dll
# 0x0000000054300000  0x21000   c:\dev\vcpkg\installed\x86-windows\bin\expat.dll

DLLS=
#DLLS+=" zlib1.dll"
DLLS+=" expat.dll"

# libxml2.dll \
# libcharset.dll \
# boost_locale-vc142-mt-$BOOST_ARCH-1_72.dll \
# boost_filesystem-vc142-mt-$BOOST_ARCH-1_72.dll \
# boost_iostreams-vc142-mt-$BOOST_ARCH-1_72.dll \
# icuin65.dll \
# icuuc65.dll \
# icudt65.dll \
# bz2.dll \
# lzma.dll \
# zstd.dll \
# libiconv.dll \
# libpq.dll \
# libpng16.dll

for FILE in $DLLS; do
  mklink
done



