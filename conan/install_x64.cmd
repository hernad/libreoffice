#!/bin/bash

#conan install .. --install-folder c:/dev/libreoffice/conan/deploy_x64

conan install .. --install-folder c:/dev/libreoffice/conan/deploy_x64 --build boost --settings arch=x86_64
