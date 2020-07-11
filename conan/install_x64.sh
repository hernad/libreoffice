#!/bin/bash

rm -rf $HOME/libreoffice/conan/deploy_x64


conan install .. --install-folder $HOME/libreoffice/conan/deploy_x64 \
     --settings arch=x86_64 \
     --settings compiler.libcxx=libstdc++11 \
     --build zlib \
     --build libpng \
     --build boost \
     --build libpq \
     --build libxml2 \
     --build openssl \
     --build libcurl \
     --build icu \
     --build xmlsec \
     --build libxml2 \
     --build libxslt \
     --build libjpeg-turbo \
     --build nss


