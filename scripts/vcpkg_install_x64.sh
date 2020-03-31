#!/bin/bash

# $ cat /cygdrive/c/dev/vcpkg/triplets/x64-windows.cmake
# set(VCPKG_TARGET_ARCHITECTURE x64)
# set(VCPKG_CRT_LINKAGE dynamic)
# set(VCPKG_LIBRARY_LINKAGE dynamic)
# set(VCPKG_BUILD_TYPE release)
# set(VCPKG_PLATFORM_TOOLSET v142)



cd /cygdrive/c/dev/vcpkg

./vcpkg.exe install zlib:x64-windows
./vcpkg.exe install icu:x64-windows
./vcpkg.exe install boost:x64-windows
./vcpkg.exe install libpq:x64-windows
./vcpkg.exe install libxml2:x64-windows
./vcpkg.exe install libpng:x64-windows
./vcpkg.exe install expat:x64-windows
./vcpkg.exe install libxslt:x64-windows
./vcpkg.exe install curl:x64-windows