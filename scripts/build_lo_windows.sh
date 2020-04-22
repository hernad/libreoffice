#!/bin/bash

#32bit
#BUILD_ARCH=x86 ENVARS_ONLY=0 MAKE_ONLY=0 PARALLELISM=12 scripts/build_lo_windows.sh

#64bit
#BUILD_ARCH=x64 ENVARS_ONLY=0 MAKE_ONLY=0 PARALLELISM=12 scripts/build_lo_windows.sh


# The __imp__ prefix appears whenever you are linking to a DLL. 
# It does not appear when linking to statically linked libraries. 
# Most likely the code is generated to be linked against a DLL import lib
# but you have linked it with a static lib instead.
# 
# The prefix is added when you mark the imported function with __declspec(dllimport) 
# - make sure your imports are not using this when not linking against a DLL.

# dumpbin /all LinkTarget/Library/isax.lib | grep __imp_

# hernad@XPS15-hernad /cygdrive/c/dev/vcpkg/installed/x64-windows/lib
#$ dumpbin /all expat.lib  | grep _imp_XML_ParseBuffer
#     2F00 __imp_XML_ParseBuffer
#       14 __imp_XML_ParseBuffer

# export EXPAT_LIBS=$(gb_SPACE)c:/dev/vcpkg/installed/x64-windows/lib/expat.lib
#$ make sax.build OK (trazi dynamic expat.lib)


THEME=colibre
#THEME=sukapura_svg

LO_PRODUCT_NAME=ZiherO
LO_PRODUCT_VERSION=7.0.0.500

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

fi


# gb_LinkTarget__command => link.exe ...

# --disable-avmedia => build error
# C:/dev/libreoffice-core-meson/avmedia/source/avmediadummy.cxx(30): warning C4273: 'avmedia::MediaItem::MediaItem': inconsistent dll linkage

# --disable-database-connectivity  
# --disable-extensions
#  
# => build error
# C:/dev/libreoffice-core-meson/solenv/gbuild/Configuration.mk:174: *** There is no target C:/dev/libreoffice-core-meson/
# workdir/XcuModuleTarget/connectivity/registry/ado/org/openoffice/Office/DataAccess/Drivers-ado.xcu.  Stop.

# --disable-scripting
# => build-error
# dllmgr-x64.o : error LNK2019: unresolved external symbol "public: static bool __cdecl SbiRuntime::isVBAEnabled(void)" (?isVBAEnabled@SbiRuntime@@SA_NXZ) referenced in function "class ErrCode __cdecl `anonymous namespace'::marshal(bool,class SbxVariable *,bool,class std::vector<char,class std::allocator<char> > &,unsigned __int64,class A0x3147681c::MarshalData &)" ....


#export OPENSSL_CFLAGS="-I$VCPKG_DIR/include"
#export OPENSSL_LIBS="$VCPKG_DIR/lib/libssl.lib $VCPKG_DIR/lib/libcrypto.lib"

# ---------------------------------------------------------

# xmlsec/nss/crypto.h

#export LIBS="$ICU_LIBS"

#--with-webdav=serf or --without-webdav
#[Specify which library to use for webdav implementation.
#         Possible values: "neon", "serf", "no". The default value is "neon".
export WEBDAV="--with-webdav=no"

#export PDF_IMPORT="--disable-pdfimport"
export PDF_IMPORT=

#export TLS_METHOD="--with-tls=openssl"
export TLS_METHOD="--with-tls=nss"

#export ODK_FEATURE=" --disable-odk"
ODK_FEATURE=
#EXTENSIONS=" --disable-extension-integration"
EXTENSIONS=

#SKIA_FEATURE="--disable-skia"
SKIA_FEATURE=


#GALLERY=" --with-galleries=no"
GALLERY=

#make basegfx.build
#make comphelper.build


# EXTRA_LO_PATH koristi C:\dev\libreoffice\solenv\gbuild\platform\com_MSC_defs.mk
# gb_Helper_set_ld_path := PATH="$(shell cygpath -w $(INSTDIR)/$(LIBO_URE_LIB_FOLDER));$(shell cygpath -w $(INSTDIR)/$(LIBO_BIN_FOLDER));$(shell cygpath -w $(EXTRA_LO_PATH));$$PATH"
#export EXTRA_LO_PATH=`cygpath c:/dev`
#export PATH=$PATH:$EXTRA_LO_PATH

# koristi se u  com_MSC_defs.mk /LIBPATH:$(LIBPATH)
#export LIBPATH=c:/dev/lib

# /usr/sbin/gencmn.exe
export PATH=$PATH:/usr/sbin


# export verbose="V=1"

#echo "PATH=$PATH"

[ -z "$MAKE_ONLY" ] && MAKE_ONLY=0
[ -z "$ENVARS_ONLY" ] && ENVARS_ONLY=0
[ -z "$PARALLELISM" ] && PARALLELISM=12
#[ -z "$WITH_VCPKG" ] && WITH_VCPKG=0  # WITH_VCPKG=0 => don't use vcpkg
#[ -z "$WITH_VCPKG_ZERO" ] && WITH_VCPKG_ZERO=1  # WITH_VCPKG=0 => don't use vcpkg


WITH_SYSTEM=
  
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




#if [ "$WITH_VCPKG" == "1" ] ; then

#  export VCPKG_LIBPATH="$VCPKG_DIR/lib"
#  #export LIBPATH="$VCPKG_DIR/lib"
#  #build liblangtag
#  #libtool needs linux format -L${VCPKG_LIBPATH}
#  #export LDFLAGS="-L${VCPKG_LIBPATH} -LIBPATH:${VCPKG_LIBPATH}"
#  export CFLAGS="-I$VCPKG_DIR/include"
#  export CXXFLAGS="-I$VCPKG_DIR/include"
#
#  export VCPKG_LIBPATH="$VCPKG_DIR/lib"
#  export LIBPATH="$VCPKG_DIR/lib"
#  #build liblangtag
#  #libtool needs linux format -L${VCPKG_LIBPATH}
#  #export LDFLAGS="-L${VCPKG_LIBPATH} -LIBPATH:${VCPKG_LIBPATH}"
#  #export CFLAGS="-I$VCPKG_DIR/include"
#  #export CXXFLAGS="-I$VCPKG_DIR/include"
#
#else
#  export LIBPATH="c:/xx"
#fi


#https://github.com/mbuilov/gnumake-windows/blob/master/gnumake-4.3-dev-x64.exe

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
    --without-java \
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
    $EXTENSIONS $PDF_IMPORT $WEBDAV $WITH_SYSTEM $LO_DEBUG $SKIA_FEATURE \
    --enable-breakpad       #Enables breakpad for crash reporting.

fi

#    
#    
#  --with-system-openssl=yes \
    
#--with-system-xmlsec=yes 

#    --with-system-libpng=$VCPKG_DIR \
#    --with-system-harfbuzz=$VCPKG_DIR \

#--with-gdrive-client-id=
#    --with-gdrive-client-secret=


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
  copy_dlls
  time make $ONE_JOB  build-nocheck 2>&1 | tee build.log
fi

