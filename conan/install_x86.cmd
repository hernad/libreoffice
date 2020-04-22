rm -rf c:/dev/libreoffice/conan/deploy_x86

REM C:\dev\set_cmake_path.cmd

conan install .. --install-folder c:/dev/libreoffice/conan/deploy_x86 ^
     --settings arch=x86 ^
     --settings compiler.version="16" ^
     --build libiconv ^
     --build zlib ^
     --build libpng ^
     --build boost ^
     --build libpq ^
     --build icu ^
     --build libxml2 ^
     --build libxslt ^
     --build openssl ^
     --build libcurl ^
     --build libjpeg-turbo ^
     --build xmlsec
 

REM     --settings arch=x86_64 --settings compiler.runtime="MT" --settings compiler.version="16"
