#!/bin/bash

#gbuild.mk
#gb_Library_DLLPOSTFIX := lo -> zh

#ReporitoryFixes.mk
#gb_Executable_FILENAMES := $(patsubst soffice_exe:soffice_exe%,soffice_exe:soffice.exe,$(gb_Executable_FILENAMES))
#gb_Executable_FILENAMES := $(patsubst soffice_com:soffice_com%,soffice_com:soffice.com,$(gb_Executable_FILENAMES))
# soffice.exe -> zihero.exe
# soffice.com -> zihero.com
# soffice -> zihero
# soffice.bin -> zihero.bin

#ENVARS_ONLY=0 MAKE_ONLY=1 PARALLELISM=8 scripts/build_lo_release.sh

#32bit
#BUILD_ARCH=x86 WITH_VCPKG_ZERO=1 WITH_VCPKG=0 ENVARS_ONLY=0 MAKE_ONLY=0 PARALLELISM=12 scripts/build_lo.sh


#64bit
#BUILD_ARCH=x64 WITH_VCPKG_ZERO=1 WITH_VCPKG=0 ENVARS_ONLY=0 MAKE_ONLY=0 PARALLELISM=12 scripts/build_lo.sh

#envars
#BUILD_ARCH=x64 WITH_VCPKG_ZERO=1 WITH_VCPKG=0 ENVARS_ONLY=1 MAKE_ONLY=0 PARALLELISM=12 source scripts/build_lo.sh


#C:\dev\vcpkg>cl -Bv

#C:\dev\vcpkg>cat triplets/x86-windows.cmake
#set(VCPKG_TARGET_ARCHITECTURE x86)
#set(VCPKG_CRT_LINKAGE dynamic)
#set(VCPKG_LIBRARY_LINKAGE dynamic)
#set(VCPKG_PLATFORM_TOOLSET v142)


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
LO_PRODUCT_VERSION=7.0.0.400

#LO_DEBUG=" --enable-dbgutil"

#https://github.com/boostorg/uuid/issues/68
#export VCPKG_BOOST_BUILD_LIB="vc140"  # VS 2019
export VS_VERSION="2019"



if [ "$BUILD_ARCH" == "x64" ] ; then

  ENABLE_64_BIT=--enable-64-bit
  
  #export PYTHON_VERSION="3.7.3"
  #export VCPKG_DIR=c:/dev/vcpkg/installed/x64-windows
  #export VCPKG_STATIC_DIR=c:/dev/vcpkg/installed/x64-windows-static
  export CONAN_DEPLOY_DIR=c:/dev/libreoffice/conan/deploy_x64
  
  #export PYTHON=C:/dev/vcpkg/downloads/tools/python/python-3.7.3-x64/python.exe
  #export PYTHON_CFLAGS="-I$VCPKG_DIR/include/python3.7"
  #export PYTHON_LIBS="$VCPKG_DIR/lib/python37.lib"

else
  ENABLE_64_BIT=
  #export VCPKG_DIR=c:/dev/vcpkg/installed/x86-windows
  #export VCPKG_STATIC_DIR=c:/dev/vcpkg/installed/x86-windows-static
  
  #export PYTHON_DIR=c:/dev/Python37-32
  #export PYTHON=$PYTHON_DIR/python.exe
  #export PYTHON_CFLAGS="-I$PYTHON_DIR/include"
  #export PYTHON_LIBS="$PYTHON_DIR/libs/python37.lib"
  #export PYTHON_VERSION="3.7.7"
  
  #export PYTHON_VERSION="3.7.3"
  #export PYTHON=C:/dev/vcpkg/downloads/tools/python/python-3.7.3-x86/python.exe
  #export PYTHON_CFLAGS="-I$VCPKG_DIR/include/python3.7"
  #export PYTHON_LIBS="$VCPKG_DIR/lib/python37.lib"
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




# ---------------------------------------------------------

#cp -av /cygdrive/c/dev/vcpkg/buildtrees/xmlsec/src/sec-1_2_29-18300c1e02/include/xmlsec/nss /cygdrive/c/dev/vcpkg/installed/x86-windows/include/xmlsec/
#cp -av /cygdrive/c/dev/vcpkg/buildtrees/xmlsec/src/sec-1_2_29-18300c1e02/include/xmlsec/mscng /cygdrive/c/dev/vcpkg/installed/x86-windows/include/xmlsec/

# xmlsec/nss/crypto.h

#export XMLSEC_CFLAGS="-I$VCPKG_DIR/include"
#export XMLSEC_LIBS="$VCPKG_DIR/lib/libxmlsec.lib"

#export LIBS="$ICU_LIBS"

#--with-webdav=serf or --without-webdav
#[Specify which library to use for webdav implementation.
#         Possible values: "neon", "serf", "no". The default value is "neon".
export WEBDAV="--with-webdav=no"

#export PDF_IMPORT="--disable-pdfimport"
export PDF_IMPORT=

#export TLS_METHOD="--with-tls=openssl"
export TLS_METHOD="--with-tls=nss"

#make basegfx.build
#make comphelper.build

# PATH to icuuc64.dll, C:/dev/libreoffice/workdir/LinkTarget/Executable/gencoll_rule.exe
export EXTRA_LO_PATH=`cygpath $CONAN_DEPLOY_DIR/icu/bin`
export PATH=$EXTRA_LO_PATH:$PYTHON:$PATH

# /usr/sbin/gencmn.exe
export PATH=$PATH:/usr/sbin

# export verbose="V=1"

#echo "PATH=$PATH"

[ -z "$MAKE_ONLY" ] && MAKE_ONLY=0
[ -z "$ENVARS_ONLY" ] && ENVARS_ONLY=0
[ -z "$PARALLELISM" ] && PARALLELISM=12
[ -z "$WITH_VCPKG" ] && WITH_VCPKG=0  # WITH_VCPKG=0 => don't use vcpkg
[ -z "$WITH_VCPKG_ZERO" ] && WITH_VCPKG_ZERO=1  # WITH_VCPKG=0 => don't use vcpkg


WITH_SYSTEM=
#if [ "$WITH_VCPKG_ZERO" == "1" ] ; then
  #echo PYTHON_CFLAGS=$PYTHON_CFLAGS, PYTHON_LIBS=$PYTHON_LIBS
  #WITH_SYSTEM+=" --enable-python=system"

  #WITH_SYSTEM+=" --with-system-zlib=yes"
  #export ZLIB_CFLAGS="-I$CONAN_DEPLOY_DIR/zlib/include"
  #export ZLIB_LIBS="$CONAN_DEPLOY_DIR/zlib/lib/zlib.lib"
 
  #WITH_SYSTEM+=" --with-system-libpng=yes"
  #export LIBPNG_CFLAGS="-I$CONAN_DEPLOY_DIR/libpng/include"
  #export LIBPNG_LIBS="$CONAN_DEPLOY_DIR/libpng/lib/libpng16.lib $ZLIB_LIBS"

  #WITH_SYSTEM+=" --with-system-jpeg=yes"
  #export LIBJPEG_CFLAGS="-I$CONAN_DEPLOY_DIR/libjpeg-turbo/include"
  #export LIBJPEG_LIBS="$CONAN_DEPLOY_DIR/libjpeg-turbo/lib/turbojpeg-static.lib"


  #WITH_SYSTEM+=" --with-system-boost"
  #export BOOST_CPPFLAGS="-I$CONAN_DEPLOY_DIR/boost/include -I$CONAN_DEPLOY_DIR/bzip2/include"
  #export BOOST_CXXFLAGS=$BOOST_CPPFLAGS
  #export BOOST_LDFLAGS=""
  #export BOOST_LOCALE_LIB="bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_locale.lib $ZLIB_LIBS"
  #export BOOST_DATE_TIME_LIB="bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_date_time.lib $ZLIB_LIBS"
  #export BOOST_FILESYSTEM_LIB="bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_filesystem.lib $ZLIB_LIBS"
  #export BOOST_IOSTREAMS_LIB="bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_iostreams.lib $ZLIB_LIBS"
  #export BOOST_SYSTEM_LIB="bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/libboost_system.lib $ZLIB_LIBS"
  
  #WITH_SYSTEM+=" --with-system-openssl=yes"
  #export OPENSSL_CFLAGS="-I$CONAN_DEPLOY_DIR/openssl/include"
  #export OPENSSL_LIBS="$CONAN_DEPLOY_DIR/openssl/lib/libeay32.lib $CONAN_DEPLOY_DIR/openssl/lib/ssleay32.lib"


  #WITH_SYSTEM+=" --with-system-curl=yes"
  #export CURL_CFLAGS="-I$CONAN_DEPLOY_DIR/libcurl/include" 
  #export CURL_LIBS="$CONAN_DEPLOY_DIR/libcurl/lib/libcurl_imp.lib"
#
  #WITH_SYSTEM+=" --with-system-postgresql=yes"
  #export POSTGRESQL_CFLAGS="-I$CONAN_DEPLOY_DIR/libpq/include"
  #export POSTGRESQL_LIBS="$CONAN_DEPLOY_DIR/libpq/lib/libpq.lib secur32.lib Ws2_32.lib $OPENSSL_LIBS"


  #WITH_SYSTEM+=" --with-system-icu=yes"
  #export ICU_CFLAGS="-I$CONAN_DEPLOY_DIR/icu/include"
  #export ICU_LIBS="$CONAN_DEPLOY_DIR/icu/lib/icudt.lib $CONAN_DEPLOY_DIR/icu/lib/icuin.lib $CONAN_DEPLOY_DIR/icu/lib/icuio.lib $CONAN_DEPLOY_DIR/icu/lib/icutu.lib $CONAN_DEPLOY_DIR/icu/lib/icuuc.lib"
  #export ICU_VERSION="64.2"
  


  #WITH_SYSTEM+=" --with-system-libxml=yes"
  #export LIBXML_CFLAGS="-I$CONAN_DEPLOY_DIR/libxml2/include/libxml2 -I$CONAN_DEPLOY_DIR/libiconv/include"
  ##export LDFLAGS="-LIBPATH:${VCPKG_DIR/lib}"
  #LIBXML_LIBS="$CONAN_DEPLOY_DIR/libxml2/lib/libxml2_a.lib" 
  #export LIBXML_LIBS+=" Ws2_32.lib $ZLIB_LIBS $CONAN_DEPLOY_DIR/libiconv/lib/iconv.lib $CONAN_DEPLOY_DIR/libiconv/lib/charset.lib"
#
  #export LIBXML_LIBTOOL_LIBS="-L$CONAN_DEPLOY_DIR/libxml2/lib -L$CONAN_DEPLOY_DIR/libiconv/lib -L$CONAN_DEPLOY_DIR/zlib/lib -llibxml2_a -liconv -lcharset -lWs2_32 -lzlib"
  #export LIBEXSLT_CFLAGS="-I$CONAN_DEPLOY_DIR/libxslt/include"
  #export LIBEXSLT_LIBS="$CONAN_DEPLOY_DIR/libxslt/lib/libexslt_a.lib"
  #export LIBXSLT_CFLAGS="-I$CONAN_DEPLOY_DIR/libxslt/include"
  #export LIBXSLT_LIBS="$CONAN_DEPLOY_DIR/libxslt/lib/libxslt_a.lib $LIBEXSLT_LIBS"
  
  #WITH_SYSTEM+=" --with-system-expat=yes"
  #export EXPAT_CFLAGS="-I$VCPKG_DIR/include"
  #export EXPAT_LIBS="$VCPKG_DIR/lib/expat.lib"

  #WITH_SYSTEM+=" --with-system-xmlsec=yes"
  #export XMLSEC_CFLAGS="-Ic:/dev/xmlsec/win32/include"
  #export XMLSEC_LIBS="c:/dev/xmlsec/win32/lib/libxmlsec.lib c:/dev/xmlsec/win32/lib/libxmlsec-mscng.lib"



  #export BREAKPAD_CFLAGS="-I$VCPKG_DIR/include"
  #export BREAKPAD_LIBS="$VCPKG_STATIC_DIR/lib/libbreakpad.lib"

  #export CFLAGS="$ZLIB_CFLAGS $ICU_CFLAGS $OPENSSL_CFLAGS"
  #export CXXFLAGS=$CFLAGS
 
#fi



#if [ "$WITH_VCPKG" == "1" ] ; then

  #export VCPKG_LIBPATH="$VCPKG_DIR/lib"
  #export LIBPATH="$VCPKG_DIR/lib"
  #build liblangtag
  #libtool needs linux format -L${VCPKG_LIBPATH}
  #export LDFLAGS="-L${VCPKG_LIBPATH} -LIBPATH:${VCPKG_LIBPATH}"


  #export CFLAGS="-I$VCPKG_DIR/include"
  #export CXXFLAGS="-I$VCPKG_DIR/include"

  #export VCPKG_LIBPATH="$VCPKG_DIR/lib"
  #export LIBPATH="$VCPKG_DIR/lib"
  #build liblangtag
  #libtool needs linux format -L${VCPKG_LIBPATH}
  #export LDFLAGS="-L${VCPKG_LIBPATH} -LIBPATH:${VCPKG_LIBPATH}"
  #export CFLAGS="-I$VCPKG_DIR/include"
  #export CXXFLAGS="-I$VCPKG_DIR/include"

#else
  #export LIBPATH="c:/dev/libreoffice/lib"
#fi

if [ "$ENVARS_ONLY" == "0" ] && [ "$MAKE_ONLY" == "0" ]; then
#https://github.com/mbuilov/gnumake-windows/blob/master/gnumake-4.3-dev-x64.exe


  make clean
  #rm -f config_host.mk
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
    --disable-cve-tests \
    --disable-odk \
    --with-galleries=no \
    --disable-report-builder \
    --disable-lpsolve \
    --disable-coinmp \
    --disable-report-builder \
    --with-help=no \
    --disable-online-update \
    --disable-sdremote \
    --disable-sdremote-bluetooth \
    --disable-extension-integration $PDF_IMPORT $WEBDAV $WITH_SYSTEM $LO_DEBUG \
    --enable-breakpad       #Enables breakpad for crash reporting.

fi
  
    



# Directory of C:\dev\vcpkg\installed\x86-windows\lib
#
#29. 03. 2020.  23:35             3.506 boost_atomic-vc140-mt.lib
#29. 03. 2020.  23:35            24.688 boost_chrono-vc140-mt.lib
#29. 03. 2020.  23:34            45.564 boost_container-vc140-mt.lib
#...
#                
#       Use boost already on system.
#    --with-boost=$VCPKG_DIR/lib 
#    
#    
#         use Boost library from a standard location
#  
#                          Force given directory for boost libraries. Note that
#                          fails and you know exactly where your boost
#  --with-boost-date-time[=special-lib]
#                          use the Date_Time library from boost - it is
#                          --with-boost-date-time=boost_date_time-gcc-mt-d-1_33_1
#  --with-boost-filesystem[=special-lib]
#                          use the Filesystem library from boost - it is
#                          e.g. --with-boost-filesystem=boost_filesystem-gcc-mt
#  --with-boost-iostreams[=special-lib]
#                          use the IOStreams library from boost - it is
#                          --with-boost-iostreams=boost_iostreams-gcc-mt-d-1_33_1
#  --with-boost-locale[=special-lib]
#                          use the Locale library from boost - it is possible
#                          --with-boost-locale=boost_locale-gcc-mt
#  --with-boost-system[=special-lib]
#                          use the System library from boost - it is possible
#                          --with-boost-system=boost_system-gcc-mt
#

#    --with-system-libpng=$VCPKG_DIR \
#    --with-system-harfbuzz=$VCPKG_DIR \

#--with-gdrive-client-id=
#    --with-gdrive-client-secret=

        
# https://wiki.documentfoundation.org/Development/GenericBuildingHints


if [ "$ENVARS_ONLY" == "0" ] ; then
  #time make $ONE_JOB  solenv
  #time make $ONE_JOB  python3.build

  #cp -av $CONAN_DEPLOY_DIR/openssl/bin/*.dll instdir/program/

  time make $ONE_JOB  build-nocheck 2>&1 | tee build.log
fi