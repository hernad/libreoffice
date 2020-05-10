#!/bin/bash

rm -rf $HOME/libreoffice/conan/deploy_x64/expat


conan install . --install-folder $HOME/libreoffice/conan/deploy_x64 \
     --settings arch=x86_64 \
     --settings compiler.libcxx=libstdc++11 \
     --build expat