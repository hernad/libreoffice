#!/bin/bash
INST=instdir/program/

cp -av conan/deploy_x64/libcurl/bin/libcurl.dll $INST
cp -av conan/deploy_x64/icu/bin/icu*.dll $INST

cp -av conan/deploy_x64/openssl/bin/libeay32.dll $INST
cp -av conan/deploy_x64/openssl/bin/ssleay32.dll $INST

#cp -av conan/deploy_x64/openssl/bin/libeay32.dll $INST/libcrypto-1_1-x64.dll
#cp -av conan/deploy_x64/openssl/bin/ssleay32.dll $INST/libssl-1_1-x64.dll

#-rwxr-xr-x 1 ernad.husremovic Domain Users 2131968 Apr 16 19:35 libeay32.dll
#-rwxr-xr-x 1 ernad.husremovic Users         506368 Apr 16 19:35 openssl.exe
#-rwxr-xr-x 1 ernad.husremovic Domain Users  363520 Apr 16 19:35 ssleay32.dll

