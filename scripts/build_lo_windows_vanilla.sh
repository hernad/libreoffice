#!/bin/bash

#32bit
#BUILD_ARCH=x86 ENVARS_ONLY=0 MAKE_ONLY=0 PARALLELISM=12 scripts/build_lo_windows.sh

#64bit
#BUILD_ARCH=x64 ENVARS_ONLY=0 MAKE_ONLY=0 PARALLELISM=12 scripts/build_lo_windows.sh



THEME=colibre
#THEME=sukapura_svg

LO_PRODUCT_NAME=ZiherO
LO_PRODUCT_VERSION=7.0.0.600

#LO_DEBUG=" --enable-dbgutil"

export VS_VERSION="2019"


if [ "$BUILD_ARCH" == "x64" ] ; then

  ENABLE_64_BIT=--enable-64-bit
#  export PYTHON_VERSION_MAJOR=3
#  export PYTHON_VERSION_MINOR=7
#  export PYTHON_VERSION="3.7.3"
#  export CONAN_DEPLOY_DIR=c:/dev/libreoffice/conan/deploy_x64
#  export PYTHON=C:/dev/vcpkg/downloads/tools/python/python-3.7.3-x64/python.exe
#  export PYTHON_CFLAGS="-Ic:/dev/vcpkg/installed/x64-windows/include/python3.7"
#  export PYTHON_LIBS="c:/dev/vcpkg/installed/x64-windows/lib/python37.lib"
#  BOOST_NODEFAULT_SUFIX="vc142-mt-x64-1_72.lib"
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


JAVA_HOME=`cygpath -w $JAVA_DIR`
export JAVA_HOME
echo "JAVA_HOME=$JAVA_HOME"
#JAVA_FEATURE="--without-java"
JAVA_FEATURE=" --with-jdk-home=$JAVA_HOME"

# gb_LinkTarget__command => link.exe ...

# ---------------------------------------------------------


#export LIBS="$ICU_LIBS"

#--with-webdav=serf or --without-webdav
#[Specify which library to use for webdav implementation.
#         Possible values: "neon", "serf", "no". The default value is "neon".
export WEBDAV="--with-webdav=no"

#export PDF_IMPORT="--disable-pdfimport"
export PDF_IMPORT=

#export TLS_METHOD="--with-tls=openssl"
#export TLS_METHOD="--with-tls=nss"

#export ODK_FEATURE=" --disable-odk"
ODK_FEATURE=
#EXTENSIONS=" --disable-extension-integration"
EXTENSIONS=

#SKIA_FEATURE="--disable-skia"
#SKIA_FEATURE=


#GALLERY=" --with-galleries=no"
GALLERY=

#make basegfx.build
#make comphelper.build


# /usr/sbin/gencmn.exe
export PATH=$JAVA_HOME/bin:$PATH:/usr/sbin


# export verbose="V=1"

#echo "PATH=$PATH"

[ -z "$MAKE_ONLY" ] && MAKE_ONLY=0
[ -z "$ENVARS_ONLY" ] && ENVARS_ONLY=0
[ -z "$PARALLELISM" ] && PARALLELISM=12
#[ -z "$WITH_VCPKG" ] && WITH_VCPKG=0  # WITH_VCPKG=0 => don't use vcpkg
#[ -z "$WITH_VCPKG_ZERO" ] && WITH_VCPKG_ZERO=1  # WITH_VCPKG=0 => don't use vcpkg

WITH_SYSTEM=
#WITH_SYSTEM=
#  
#  echo PYTHON_CFLAGS=$PYTHON_CFLAGS, PYTHON_LIBS=$PYTHON_LIBS
#  WITH_SYSTEM+=" --enable-python=system"
#
#  WITH_SYSTEM+=" --with-system-zlib=yes"
#  export ZLIB_CFLAGS="-I$CONAN_DEPLOY_DIR/zlib/include"
#  export ZLIB_LIBS="$CONAN_DEPLOY_DIR/zlib/lib/zlib.lib"
# 
#  WITH_SYSTEM+=" --with-system-libpng=yes"
#  export LIBPNG_CFLAGS="-I$CONAN_DEPLOY_DIR/libpng/include"
#  export LIBPNG_LIBS="$CONAN_DEPLOY_DIR/libpng/lib/libpng16.lib $ZLIB_LIBS"
#
#  WITH_SYSTEM+=" --with-system-jpeg=yes"
#  export LIBJPEG_CFLAGS="-I$CONAN_DEPLOY_DIR/libjpeg-turbo/include"
#  export LIBJPEG_LIBS="$CONAN_DEPLOY_DIR/libjpeg-turbo/lib/turbojpeg-static.lib"
#
#  WITH_SYSTEM+=" --with-system-boost"
#  export BOOST_CPPFLAGS="-I$CONAN_DEPLOY_DIR/boost/include -I$CONAN_DEPLOY_DIR/bzip2/include"
#  export BOOST_CXXFLAGS=$BOOST_CPPFLAGS
#  export BOOST_LDFLAGS=""
#
#  
#  export BOOST_LOCALE_LIB="-NODEFAULTLIB:libboost_locale-$BOOST_NODEFAULT_SUFIX bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_locale.lib $ZLIB_LIBS"
#  export BOOST_DATE_TIME_LIB="-NODEFAULTLIB:libboost_date_time-$BOOST_NODEFAULT_SUFIX bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_date_time.lib $ZLIB_LIBS"
#  export BOOST_FILESYSTEM_LIB="-NODEFAULTLIB:libboost_filesystem-$BOOST_NODEFAULT_SUFIX bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_filesystem.lib $ZLIB_LIBS"
#  export BOOST_IOSTREAMS_LIB="-NODEFAULTLIB:libboost_iostreams-$BOOST_NODEFAULT_SUFIX bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_iostreams.lib $ZLIB_LIBS"
#  export BOOST_SYSTEM_LIB="-NODEFAULTLIB:libboost_system-$BOOST_NODEFAULT_SUFIX bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_system.lib $ZLIB_LIBS"
#  
#  WITH_SYSTEM+=" --with-system-openssl=yes"
#  export OPENSSL_CFLAGS="-I$CONAN_DEPLOY_DIR/openssl/include"
#  export OPENSSL_LIBS="$CONAN_DEPLOY_DIR/openssl/lib/libeay32.lib $CONAN_DEPLOY_DIR/openssl/lib/ssleay32.lib"
#
#  WITH_SYSTEM+=" --with-system-curl=yes"
#  export CURL_CFLAGS="-I$CONAN_DEPLOY_DIR/libcurl/include" 
#  export CURL_LIBS="$CONAN_DEPLOY_DIR/libcurl/lib/libcurl_imp.lib"
# 
#  WITH_SYSTEM+=" --with-system-postgresql=yes"
#  export POSTGRESQL_CFLAGS="-I$CONAN_DEPLOY_DIR/libpq/include"
#  export POSTGRESQL_LIBS="$CONAN_DEPLOY_DIR/libpq/lib/libpq.lib secur32.lib Ws2_32.lib $OPENSSL_LIBS"
#
#  WITH_SYSTEM+=" --with-system-libxml=yes"
#  export LIBXML_CFLAGS="-I$CONAN_DEPLOY_DIR/libxml2/include/libxml2 -I$CONAN_DEPLOY_DIR/libiconv/include"
#  LIBXML_LIBS="$CONAN_DEPLOY_DIR/libxml2/lib/libxml2_a.lib" 
#  export LIBXML_LIBS+=" Ws2_32.lib $ZLIB_LIBS $CONAN_DEPLOY_DIR/libiconv/lib/iconv.lib $CONAN_DEPLOY_DIR/libiconv/lib/charset.lib"
#  export LIBXML_LIBTOOL_LIBS="-L$CONAN_DEPLOY_DIR/libxml2/lib -L$CONAN_DEPLOY_DIR/libiconv/lib -L$CONAN_DEPLOY_DIR/zlib/lib -llibxml2_a -liconv -lcharset -lWs2_32 -lzlib"
#  export LIBEXSLT_CFLAGS="-I$CONAN_DEPLOY_DIR/libxslt/include"
#  export LIBEXSLT_LIBS="$CONAN_DEPLOY_DIR/libxslt/lib/libexslt_a.lib"
#  export LIBXSLT_CFLAGS="-I$CONAN_DEPLOY_DIR/libxslt/include"
#  export LIBXSLT_LIBS="$CONAN_DEPLOY_DIR/libxslt/lib/libxslt_a.lib"
#  export LIBXML2_CFLAGS=$LIBXML_CFLAGS
#  export LIBXML2_LIBS=$LIBXML_LIBS
  
#
#  WITH_SYSTEM+=" --with-system-xmlsec=yes"
#  export XMLSEC_CFLAGS="-I$CONAN_DEPLOY_DIR/xmlsec/include"
#  export XMLSEC_LIBS="$CONAN_DEPLOY_DIR/xmlsec/lib/libxmlsec.lib $CONAN_DEPLOY_DIR/xmlsec/lib/libxmlsec-mscng.lib"
#

  #WITH_SYSTEM+=" --with-system-expat=yes"
  #export EXPAT_CFLAGS="-I$VCPKG_DIR/include"
  #export EXPAT_LIBS="$VCPKG_DIR/lib/expat.lib"

  #export BREAKPAD_CFLAGS="-I$VCPKG_DIR/include"
  #export BREAKPAD_LIBS="$VCPKG_STATIC_DIR/lib/libbreakpad.lib"


  #C:/cygwin64/bin/sh.exe ../libtool  --tag=CC  --mode=link 
  #C:/dev/libreoffice-core-meson/workdir/LinkTarget/Executable/gcc-wrapper.exe -DLT_MODULE_PREFIX=lt_module_ext_t  
  #-O2 -Oy-   -w  -avoid-version -module 
  # -LIBPATH:c:/dev/vcpkg/installed/x64-windows 
  #-o liblangtag-ext-ldml-t.la  liblangtag_ext_ldml_t_la-lt-ext-ldml-t.lo   -LIBPATH:c:/dev/vcpkg/installed/x64-windows 
  #-Lc:/xx  -LIBPATH:c:/dev/vcpkg/installed/x64-windows/lib 
  #-Lc:/dev/vcpkg/installed/x64-windows/lib libxml2.lib
  #*** Warning: Trying to link with static lib archive libxml2.lib.
  #*** I have the capability to make that library automatically link in when
  #*** you link to this library.  But I can only do this if you have a
  #*** shared version of the library, which you do not appear to have
  #*** because the file extensions .lib of this argument makes me believe
  #*** that it is just a static archive that I should not use here.
  #
  #libtool: link: lib -OUT:.libs/liblangtag-ext-ldml-t.lib libxml2.lib  liblangtag_ext_ldml_t_la-lt-ext-ldml-t.obj libxml2.lib
  #Microsoft (R) Library Manager Version 14.25.28612.0
  #Copyright (C) Microsoft Corporation.  All rights reserved.
  #LINK : fatal error LNK1181: cannot open input file 'libxml2.lib'



if [ "$MAKE_ONLY" == "0" ]; then
make clean
rm -f config_host.mk
rm -f config_host/*.h

#   --with-theme="$THEME"

./autogen.sh --with-lang="bs" \
   $ENABLE_64_BIT --with-locales="bs" \
   $TLS_METHOD \
    --with-vendor="hernad" \
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
    --enable-breakpad       #Enables breakpad for crash reporting.

fi


# https://wiki.documentfoundation.org/Development/GenericBuildingHints


function copy_dlls() {
  DEST=instdir/program
  mkdir -p $DEST
  cp -av $CONAN_DEPLOY_DIR/libcurl/bin/libcurl.dll $DEST/
  cp -av $CONAN_DEPLOY_DIR/openssl/bin/*.dll $DEST/
  cp -av $CONAN_DEPLOY_DIR/icu/bin/*.dll $DEST/
  cp -av $CONAN_DEPLOY_DIR/xmlsec/binaries/libxmlsec.dll $DEST/
  cp -av $CONAN_DEPLOY_DIR/xmlsec/binaries/libxmlsec-mscng.dll $DEST/
}

if [ "$ENVARS_ONLY" == "0" ] ; then
  #copy_dlls
  time make $ONE_JOB  build-nocheck 2>&1 | tee build.log
fi

