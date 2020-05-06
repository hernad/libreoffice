#!/bin/bash

#RUN
#ENVARS_ONLY=0 MAKE_ONLY=0 PARALLELISM=12 scripts/build_lo_linux.sh


THEME=colibre
#THEME=sukapura_svg

LO_PRODUCT_NAME=ZiherO
LO_PRODUCT_VERSION=7.0.0.530

#LO_DEBUG=" --enable-dbgutil"

export VS_VERSION="2019"


if [ "$BUILD_ARCH" == "x64" ] ; then

  ENABLE_64_BIT=--enable-64-bit
  export PYTHON_VERSION_MAJOR=3
  export PYTHON_VERSION_MINOR=7
  export PYTHON_VERSION="3.7.3"
  export CONAN_DEPLOY_DIR=c:/dev/libreoffice/conan/deploy_x64
  export PYTHON=C:/dev/vcpkg/downloads/tools/python/python-3.7.3-x64/python.exe
  export PYTHON_CFLAGS="-Ic:/dev/vcpkg/installed/x64-windows/include/python3.7"
  export PYTHON_LIBS="c:/dev/vcpkg/installed/x64-windows/lib/python37.lib"
  BOOST_NODEFAULT_SUFIX="vc142-mt-x64-1_72.lib"
  JAVA_DIR=/cygdrive/c/openjdk-panama-foreign/x64/jdk

else
  ENABLE_64_BIT=
  export PYTHON_VERSION_MAJOR=3
  export PYTHON_VERSION_MINOR=7
  export PYTHON_VERSION="3.7.3"
  export CONAN_DEPLOY_DIR=c:/dev/libreoffice/conan/deploy_x86
  export PYTHON=C:/dev/vcpkg/downloads/tools/python/python-3.7.3-x86/python.exe
  export PYTHON_CFLAGS="-Ic:/dev/vcpkg/installed/x86-windows/include/python3.7"
  export PYTHON_LIBS="c:/dev/vcpkg/installed/x86-windows/lib/python37.lib"
  BOOST_NODEFAULT_SUFIX="vc142-mt-x32-1_72.lib"
  JAVA_DIR=/cygdrive/c/openjdk-panama-foreign/x86/jdk

fi

JAVA_HOME="$HOME/jdk-14.0.1+7"
ANT_HOME="$HOME/apache-ant-1.9.14"
JUNIT4="$HOME/junit-4.13.jar"
HAMCREST="$HOME/hamcrest-2.2.jar"

#JAVA_HOME=`cygpath -w $JAVA_DIR`
export JAVA_HOME
echo "JAVA_HOME=$JAVA_HOME"
#JAVA_FEATURE="--without-java"
JAVA_FEATURE=" --with-jdk-home=$JAVA_HOME --with-ant-home=$ANT_HOME --with-junit=$JUNIT4 --with-hamcrest=$HAMCREST"


# ---------------------------------------------------------

export WEBDAV="--with-webdav=no"

#export PDF_IMPORT="--disable-pdfimport"
export PDF_IMPORT=

#export TLS_METHOD="--with-tls=openssl"
export TLS_METHOD="--with-tls=nss"

#export ODK_FEATURE=" --disable-odk"
ODK_FEATURE=
#EXTENSIONS=" --disable-extension-integration"
EXTENSIONS=

SKIA_FEATURE="--disable-skia"
#SKIA_FEATURE=


#GALLERY=" --with-galleries=no"
GALLERY=

#make basegfx.build
#make comphelper.build



# /usr/sbin/gencmn.exe
# export PATH=$JAVA_HOME/bin:$PATH:/usr/sbin


# export verbose="V=1"

#echo "PATH=$PATH"

[ -z "$MAKE_ONLY" ] && MAKE_ONLY=0
[ -z "$ENVARS_ONLY" ] && ENVARS_ONLY=0
[ -z "$PARALLELISM" ] && PARALLELISM=12
#[ -z "$WITH_VCPKG" ] && WITH_VCPKG=0  # WITH_VCPKG=0 => don't use vcpkg
#[ -z "$WITH_VCPKG_ZERO" ] && WITH_VCPKG_ZERO=1  # WITH_VCPKG=0 => don't use vcpkg


WITH_SYSTEM=
export PYTHON_CFLAGS=
export PYTHON_LIBS=

  echo PYTHON_CFLAGS=$PYTHON_CFLAGS, PYTHON_LIBS=$PYTHON_LIBS
  WITH_SYSTEM+=" --enable-python=system"

  WITH_SYSTEM+=" --with-system-zlib=yes"
  export ZLIB_CFLAGS="-I$CONAN_DEPLOY_DIR/zlib/include"
  export ZLIB_LIBS="$CONAN_DEPLOY_DIR/zlib/lib/zlib.lib"
 
  WITH_SYSTEM+=" --with-system-libpng=yes"
  export LIBPNG_CFLAGS="-I$CONAN_DEPLOY_DIR/libpng/include"
  export LIBPNG_LIBS="$CONAN_DEPLOY_DIR/libpng/lib/libpng16.lib $ZLIB_LIBS"

  WITH_SYSTEM+=" --with-system-jpeg=yes"
  export LIBJPEG_CFLAGS="-I$CONAN_DEPLOY_DIR/libjpeg-turbo/include"
  export LIBJPEG_LIBS="$CONAN_DEPLOY_DIR/libjpeg-turbo/lib/turbojpeg-static.lib"

  WITH_SYSTEM+=" --with-system-boost"
  export BOOST_CPPFLAGS="-I$CONAN_DEPLOY_DIR/boost/include -I$CONAN_DEPLOY_DIR/bzip2/include"
  export BOOST_CXXFLAGS=$BOOST_CPPFLAGS
  export BOOST_LDFLAGS=""

  
  export BOOST_LOCALE_LIB="-NODEFAULTLIB:libboost_locale-$BOOST_NODEFAULT_SUFIX bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_locale.lib $ZLIB_LIBS"
  export BOOST_DATE_TIME_LIB="-NODEFAULTLIB:libboost_date_time-$BOOST_NODEFAULT_SUFIX bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_date_time.lib $ZLIB_LIBS"
  export BOOST_FILESYSTEM_LIB="-NODEFAULTLIB:libboost_filesystem-$BOOST_NODEFAULT_SUFIX bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_filesystem.lib $ZLIB_LIBS"
  export BOOST_IOSTREAMS_LIB="-NODEFAULTLIB:libboost_iostreams-$BOOST_NODEFAULT_SUFIX bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_iostreams.lib $ZLIB_LIBS"
  export BOOST_SYSTEM_LIB="-NODEFAULTLIB:libboost_system-$BOOST_NODEFAULT_SUFIX bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_system.lib $ZLIB_LIBS"
  
  WITH_SYSTEM+=" --with-system-openssl=yes"
  export OPENSSL_CFLAGS="-I$CONAN_DEPLOY_DIR/openssl/include"
  export OPENSSL_LIBS="$CONAN_DEPLOY_DIR/openssl/lib/libeay32.lib $CONAN_DEPLOY_DIR/openssl/lib/ssleay32.lib"

  WITH_SYSTEM+=" --with-system-curl=yes"
  export CURL_CFLAGS="-I$CONAN_DEPLOY_DIR/libcurl/include" 
  export CURL_LIBS="$CONAN_DEPLOY_DIR/libcurl/lib/libcurl_imp.lib"
 
  WITH_SYSTEM+=" --with-system-postgresql=yes"
  export POSTGRESQL_CFLAGS="-I$CONAN_DEPLOY_DIR/libpq/include"
  export POSTGRESQL_LIBS="$CONAN_DEPLOY_DIR/libpq/lib/libpq.lib secur32.lib Ws2_32.lib $OPENSSL_LIBS"

  WITH_SYSTEM+=" --with-system-libxml=yes"
  export LIBXML_CFLAGS="-I$CONAN_DEPLOY_DIR/libxml2/include/libxml2 -I$CONAN_DEPLOY_DIR/libiconv/include"
  LIBXML_LIBS="$CONAN_DEPLOY_DIR/libxml2/lib/libxml2_a.lib" 
  export LIBXML_LIBS+=" Ws2_32.lib $ZLIB_LIBS $CONAN_DEPLOY_DIR/libiconv/lib/iconv.lib $CONAN_DEPLOY_DIR/libiconv/lib/charset.lib"

  export LIBXML_LIBTOOL_LIBS="-L$CONAN_DEPLOY_DIR/libxml2/lib -L$CONAN_DEPLOY_DIR/libiconv/lib -L$CONAN_DEPLOY_DIR/zlib/lib -llibxml2_a -liconv -lcharset -lWs2_32 -lzlib"
  export LIBEXSLT_CFLAGS="-I$CONAN_DEPLOY_DIR/libxslt/include"
  export LIBEXSLT_LIBS="$CONAN_DEPLOY_DIR/libxslt/lib/libexslt_a.lib"
  export LIBXSLT_CFLAGS="-I$CONAN_DEPLOY_DIR/libxslt/include"
  export LIBXSLT_LIBS="$CONAN_DEPLOY_DIR/libxslt/lib/libxslt_a.lib"

  WITH_SYSTEM+=" --with-system-xmlsec=yes"
  export XMLSEC_CFLAGS="-I$CONAN_DEPLOY_DIR/xmlsec/include"
  export XMLSEC_LIBS="$CONAN_DEPLOY_DIR/xmlsec/lib/libxmlsec.lib $CONAN_DEPLOY_DIR/xmlsec/lib/libxmlsec-mscng.lib"


WITH_SYSTEM=

if [ "$MAKE_ONLY" == "0" ]; then
make clean
rm -f config_host.mk
rm -f config_host/*.h

./autogen.sh --with-lang="bs" \
   $ENABLE_64_BIT --with-locales="bs" \
   $TLS_METHOD \
   --with-vendor="hernad" \
   --with-theme="$THEME" \
    --with-visual-studio=$VS_VERSION \
    --without-doxygen \
    --with-product-name="$LO_PRODUCT_NAME" \
    --with-package-version="$LO_PRODUCT_VERSION" \
    --enable-release-build \
    --disable-scripting-beanshell \
    --disable-scripting-javascript \
    --disable-lotuswordpro \
    --disable-firebird-sdbc \
    --disable-cve-tests $ODK_FEATURE $GALLERY \
    --disable-report-builder \
    --disable-lpsolve \
    --disable-coinmp \
    --with-help=no \
    --disable-online-update \
    --disable-sdremote \
    --disable-sdremote-bluetooth \
    $EXTENSIONS $PDF_IMPORT $WEBDAV $WITH_SYSTEM $LO_DEBUG $SKIA_FEATURE $JAVA_FEATURE \
    --enable-breakpad

fi



# https://wiki.documentfoundation.org/Development/GenericBuildingHints


function copy_dlls() {
  DEST=instdir/program
  mkdir -p $DEST
  #cp -av $CONAN_DEPLOY_DIR/libcurl/bin/libcurl.dll $DEST/
  #cp -av $CONAN_DEPLOY_DIR/openssl/bin/*.dll $DEST/
  #cp -av $CONAN_DEPLOY_DIR/icu/bin/*.dll $DEST/
  #cp -av $CONAN_DEPLOY_DIR/xmlsec/binaries/libxmlsec.dll $DEST/
  #cp -av $CONAN_DEPLOY_DIR/xmlsec/binaries/libxmlsec-mscng.dll $DEST/

}

if [ "$ENVARS_ONLY" == "0" ] ; then
  copy_dlls
  time make $ONE_JOB  build-nocheck 2>&1 | tee build.log
fi

