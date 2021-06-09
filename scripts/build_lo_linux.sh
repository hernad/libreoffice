#!/bin/bash

#RUN
#ENVARS_ONLY=0 MAKE_ONLY=0 PARALLELISM=12 scripts/build_lo_linux.sh

echo "========== fedora ====================="
echo "sudo dnf install libICE-devel libSM-devel libXt-devel gstreamer1-devel ant"


THEME=colibre
#THEME=sukapura_svg

LO_PRODUCT_NAME=ZiherO
LO_PRODUCT_VERSION=7.1.5.100

#LO_DEBUG=" --enable-dbgutil"

#ENABLE_64_BIT=--enable-64-bit

#export PYTHON_VERSION_MAJOR=3
#export PYTHON_VERSION_MINOR=7
#export PYTHON_VERSION="3.7.7"
#export CONAN_DEPLOY_DIR=$HOME/libreoffice/conan/deploy_x64
#export PYTHON_ROOT=$HOME/python${PYTHON_VERSION_MAJOR}${PYTHON_VERSION_MINOR}
#export PYTHON=${PYTHON_ROOT}/bin/python${PYTHON_VERSION_MAJOR}
#export PYTHON_CFLAGS="-I${PYTHON_ROOT}/include/python${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}m" # python3.7m
#export PYTHON_LIBS="-L${PYTHON_ROOT}/lib -lpython${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}m "  # libpython3.7m.so
  
#BOOST_NODEFAULT_SUFIX="vc142-mt-x64-1_72.lib"
#JAVA_DIR=/cygdrive/c/openjdk-panama-foreign/x64/jdk

JAVA_HOME="/usr/lib/jvm/java-11-openjdk"
#JAVA_HOME="$HOME/openjdk-panama-foreign/jdk"
#ANT_HOME="$HOME/apache-ant-1.9.14"
JUNIT4="$HOME/junit-4.13.jar"
HAMCREST="$HOME/hamcrest-2.2.jar"

# /usr/sbin/gencmn.exe
#export PATH=$JAVA_HOME/bin:$ANT_HOME/bin:$PATH
export PATH=$JAVA_HOME/bin:$PATH

#export PATH=$HOME/$PYTHON_ROOT/bin:$PATH
#export LD_LIBRARY_PATH=$PYTHON_ROOT/lib:$LD_LIBRARY_PATH 

export JAVA_HOME
#echo "JAVA_HOME=$JAVA_HOME ANT_HOME=$ANT_HOME"
java -version
#$ANT_HOME/bin/ant -version

#JAVA_FEATURE="--without-java"
#JAVA_FEATURE=" --with-jdk-home=$JAVA_HOME --with-ant-home=$ANT_HOME --with-junit=$JUNIT4 --with-hamcrest=$HAMCREST"
JAVA_FEATURE=" --with-jdk-home=$JAVA_HOME --without-junit"


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




# export verbose="V=1"

#echo "PATH=$PATH"

[ -z "$MAKE_ONLY" ] && MAKE_ONLY=0
[ -z "$ENVARS_ONLY" ] && ENVARS_ONLY=0
[ -z "$PARALLELISM" ] && PARALLELISM=12



WITH_SYSTEM=

echo PYTHON_CFLAGS=$PYTHON_CFLAGS, PYTHON_LIBS=$PYTHON_LIBS
WITH_SYSTEM+=" --enable-python=system"

#WITH_SYSTEM+=" --with-system-zlib=yes"
#export ZLIB_CFLAGS="-I$CONAN_DEPLOY_DIR/zlib/include"
#export ZLIB_LIBS="-L$CONAN_DEPLOY_DIR/zlib/lib -lz"
 
#WITH_SYSTEM+=" --with-system-libpng=yes"
#export LIBPNG_CFLAGS="-I$CONAN_DEPLOY_DIR/libpng/include"
#export LIBPNG_LIBS="-L$CONAN_DEPLOY_DIR/libpng/lib -lpng16 $ZLIB_LIBS"

#WITH_SYSTEM+=" --with-system-jpeg=yes"
#export LIBJPEG_CFLAGS="-I$CONAN_DEPLOY_DIR/libjpeg-turbo/include"
#export LIBJPEG_LIBS="-L$CONAN_DEPLOY_DIR/libjpeg-turbo/lib -lturbojpeg $ZLIB_LIBS"

#WITH_SYSTEM+=" --with-system-boost"
#export BOOST_CPPFLAGS="-I$CONAN_DEPLOY_DIR/boost/include -I$CONAN_DEPLOY_DIR/bzip2/include"
#export BOOST_CXXFLAGS=$BOOST_CPPFLAGS
  

#BZIP2_LIB="-L$CONAN_DEPLOY_DIR/bzip2/lib -lbz2"
#export BOOST_ROOT="$CONAN_DEPLOY_DIR/boost"
#export BOOST_LOCALE_LIB="$BZIP2_LIB -L$CONAN_DEPLOY_DIR/boost/lib -lboost_locale $ZLIB_LIBS"
#export BOOST_DATE_TIME_LIB="$BZIP2_LIB -L$CONAN_DEPLOY_DIR/boost/lib -lboost_date_time $ZLIB_LIBS"
#export BOOST_FILESYSTEM_LIB="$BZIP2_LIB -L$CONAN_DEPLOY_DIR/boost/lib -lboost_filesystem $ZLIB_LIBS"
#export BOOST_IOSTREAMS_LIB="$BZIP2_LIB -L$CONAN_DEPLOY_DIR/boost/lib -lboost_iostreams $ZLIB_LIBS"
#export BOOST_SYSTEM_LIB="$BZIP2_LIB -L$CONAN_DEPLOY_DIR/boost/lib -lboost_system $ZLIB_LIBS"
#export BOOST_LDFLAGS="$BOOST_LOCALE_LIB $BOOST_DATE_TIME_LIB $BOOST_FILESYSTEM_LIB $BOOST_IOSTREAMS_LIB $BOOST_SYSTEM_LIB"

#WITH_SYSTEM+=" --with-system-openssl=yes"
#export OPENSSL_CFLAGS="-I$CONAN_DEPLOY_DIR/openssl/include"
#export OPENSSL_LIBS="-L$CONAN_DEPLOY_DIR/openssl/lib -lcrypto -lssl"

#WITH_SYSTEM+=" --with-system-curl=yes"
#export CURL_CFLAGS="-I$CONAN_DEPLOY_DIR/libcurl/include" 
#export CURL_LIBS="-L$CONAN_DEPLOY_DIR/libcurl/lib -lcurl $OPENSSL_LIBS"
 
#WITH_SYSTEM+=" --with-system-postgresql=yes"
#export POSTGRESQL_CFLAGS="-I$CONAN_DEPLOY_DIR/libpq/include"
#export POSTGRESQL_LIBS="-L$CONAN_DEPLOY_DIR/libpq/lib -lpq $OPENSSL_LIBS"

#WITH_SYSTEM+=" --with-system-libxml=yes"
#export LIBXML_CFLAGS="-I$CONAN_DEPLOY_DIR/libxml2/include/libxml2 -I$CONAN_DEPLOY_DIR/libiconv/include"
#export LIBXML_LIBS="-L$CONAN_DEPLOY_DIR/libxml2/lib -lxml2" 
#export LIBXML_LIBS+=" $ZLIB_LIBS -L$CONAN_DEPLOY_DIR/libiconv/lib -lcharset -liconv -lm"
#
#export LIBXML_LIBTOOL_LIBS="-L$CONAN_DEPLOY_DIR/libxml2/lib -L$CONAN_DEPLOY_DIR/libiconv/lib -L$CONAN_DEPLOY_DIR/zlib/lib -lxml2 -liconv -lcharset -lz -lm"
#export LIBEXSLT_CFLAGS="-I$CONAN_DEPLOY_DIR/libxslt/include"
#export LIBEXSLT_LIBS="-L$CONAN_DEPLOY_DIR/libxslt/lib -lexslt"
#export LIBXSLT_CFLAGS="-I$CONAN_DEPLOY_DIR/libxslt/include"
#export LIBXSLT_LIBS="-L$CONAN_DEPLOY_DIR/libxslt/lib -lxslt"
#
#WITH_SYSTEM+=" --with-system-xmlsec=yes"
#export XMLSEC_CFLAGS="-I$CONAN_DEPLOY_DIR/xmlsec/include/xmlsec1"
#export XMLSEC_LIBS="-L$CONAN_DEPLOY_DIR/xmlsec/lib -lxmlsec1 -lxmlsec1-openssl"
#
#WITH_SYSTEM+=" --with-system-expat=yes"
#export EXPAT_CFLAGS="-I$CONAN_DEPLOY_DIR/expat/include"
#export EXPAT_LIBS="-L$CONAN_DEPLOY_DIR/expat/lib -lexpat"
#
#export NSS_CFLAGS="-I$CONAN_DEPLOY_DIR/nss/include/nss -I$CONAN_DEPLOY_DIR/nss/include/nspr"
#export NSS_LIBS="-L$CONAN_DEPLOY_DIR/nss/lib -lnspr4 -lnss3 -lssl3 -lsmime3 -lplc4"
#
#export CFLAGS="$NSS_CFLAGS"
#export LDFLAGS="$NSS_LIBS"
#export CPPFLAGS="$CFLAGS"
#export CXXFLAGS="$CFLAGS"

if [ "$MAKE_ONLY" == "0" ]; then
make clean
rm -f config_host.mk
rm -f config_host/*.h

DISABLE="--disable-breakpad --disable-ldap  --disable-gstreamer-1-0"

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
    $DISABLE


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

