rm -rf c:/dev/libreoffice/conan/deploy_x64

REM C:\dev\set_cmake_path.cmd

conan install .. --install-folder c:/dev/libreoffice/conan/deploy_x64 ^
     --settings arch=x86_64 ^
     --settings compiler.version="16" ^
     --build zlib ^
     --build libpng ^
     --build boost ^
     --build libpq ^
     --build icu ^
     --build libxml2 ^
     --build libxslt ^
     --build openssl ^
     --build libcurl ^
     --build libiconv ^
     --build libjpeg-turbo ^
     --build xmlsec


REM     --settings arch=x86_64 --settings compiler.runtime="MT" --settings compiler.version="16"
