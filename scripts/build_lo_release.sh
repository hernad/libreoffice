#!/bin/bash

#ENVARS_ONLY=0 MAKE_ONLY=1 PARALLELISM=8 scripts/build_lo_release.sh

#64bit
#BUILD_ARCH=x64 ENVARS_ONLY=0 MAKE_ONLY=0 PARALLELISM=8 scripts/build_lo_release.sh

#C:\dev\vcpkg>cl -Bv

#C:\dev\vcpkg>cat triplets/x86-windows.cmake
#set(VCPKG_TARGET_ARCHITECTURE x86)
#set(VCPKG_CRT_LINKAGE dynamic)
#set(VCPKG_LIBRARY_LINKAGE dynamic)
#set(VCPKG_PLATFORM_TOOLSET v142)

THEME=colibre
#THEME=sukapura_svg

LO_PRODUCT_NAME=ZiherO
LO_PRODUCT_VERSION=6.4.3.20


#https://github.com/boostorg/uuid/issues/68
export VCPKG_BOOST_BUILD_LIB="vc140"  # VS 2019
export VS_VERSION="2017"

if [ "$BUILD_ARCH" == "x64" ] ; then

  ENABLE_64_BIT=--enable-64-bit
  export PYTHON_VERSION="3.7.3"
  export VCPKG_DIR=c:/dev/vcpkg/installed/x64-windows
  export PYTHON=C:/dev/vcpkg/downloads/tools/python/python-3.7.3-x64/python.exe
  export PYTHON_CFLAGS="-I$VCPKG_DIR/include/python3.7"
  export PYTHON_LIBS="$LDFLAGS python37.lib"

else
  ENABLE_64_BIT=
  export VCPKG_DIR=c:/dev/vcpkg/installed/x86-windows
  export PYTHON_DIR=c:/dev/Python37-32
  export PYTHON=$PYTHON_DIR/python.exe
  export PYTHON_CFLAGS="-I$PYTHON_DIR/include"
  export PYTHON_LIBS="$LDFLAGS -LIBPATH:$PYTHON_DIR/libs python37.lib"
  export PYTHON_VERSION="3.7.7"
fi

#export LIBPATH="$VCPKG_DIR/lib"
#export LDFLAGS="-LIBPATH:$LIBPATH"

# gb_LinkTarget__command => link.exe ...

#SKIA=--disable-skia
SKIA=

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


#export CURL_CFLAGS="-I$VCPKG_DIR/include" 
#export CURL_LIBS="libcurl.lib"
#
#export POSTGRESQL_CFLAGS="-I$VCPKG_DIR/include"
#export POSTGRESQL_LIBS="libpq.lib libssl.lib libcrypto.lib"
#
#export OPENSSL_CFLAGS="-I$VCPKG_DIR/include"
#export OPENSSL_LIBS="$VCPKG_DIR/lib/libssl.lib $VCPKG_DIR/lib/libcrypto.lib"
#
#export ZLIB_CFLAGS="-I$VCPKG_DIR/include"
#export ZLIB_LIBS="$VCPKG_DIR/lib/zlib.lib"
#
#export LIBXML_CFLAGS="-I$VCPKG_DIR/include"
#export LIBXML_LIBS="$VCPKG_DIR/lib/libxml2.lib"
#
#export LIBXSLT_CFLAGS="-I$VCPKG_DIR/include"
#export LIBXSLT_LIBS="$VCPKG_DIR/lib/libxslt.lib"
#
#export LIBEXSLT_CFLAGS="-I$VCPKG_DIR/include"
#export LIBEXSLT_LIBS="$VCPKG_DIR/lib/libexslt.lib"

#export EXPAT_CFLAGS="-I$VCPKG_DIR/include"
#export EXPAT_LIBS="$VCPKG_DIR/lib/expat.lib"
#
#export LIBPNG_CFLAGS="-I$VCPKG_DIR/include"
#export LIBPNG_LIBS="$VCPKG_DIR/lib/libpng16.lib"
#
#export ICU_CFLAGS="-I$VCPKG_DIR/include"
#export ICU_LIBS="$VCPKG_DIR/lib/icudt.lib $VCPKG_DIR/lib/icuin.lib $VCPKG_DIR/lib/icuio.lib $VCPKG_DIR/lib/icutu.lib $VCPKG_DIR/lib/icuuc.lib"
#export ICU_VERSION="65.1"
#
#export CFLAGS="-I$VCPKG_DIR/include"
#export CXXFLAGS="-I$VCPKG_DIR/include"

#export BOOST_CPPFLAGS="-I$VCPKG_DIR/include"
#export BOOST_CXXFLAGS=$BOOST_CPPFLAGS
#export BOOST_LDFLAGS=""
#
#export BOOST_LOCALE_LIB="bcrypt.lib boost_locale-$VCPKG_BOOST_BUILD_LIB-mt.lib"
#export BOOST_DATE_TIME_LIB="bcrypt.lib boost_date_time-$VCPKG_BOOST_BUILD_LIB-mt.lib"
#export BOOST_FILESYSTEM_LIB="bcrypt.lib boost_filesystem-$VCPKG_BOOST_BUILD_LIB-mt.lib"
#export BOOST_IOSTREAMS_LIB="bcrypt.lib boost_iostreams-$VCPKG_BOOST_BUILD_LIB-mt.lib"
#export BOOST_SYSTEM_LIB="bcrypt.lib boost_system-$VCPKG_BOOST_BUILD_LIB-mt.lib"

# ---------------------------------------------------------

#cp -av /cygdrive/c/dev/vcpkg/buildtrees/xmlsec/src/sec-1_2_29-18300c1e02/include/xmlsec/nss /cygdrive/c/dev/vcpkg/installed/x86-windows/include/xmlsec/
#cp -av /cygdrive/c/dev/vcpkg/buildtrees/xmlsec/src/sec-1_2_29-18300c1e02/include/xmlsec/mscng /cygdrive/c/dev/vcpkg/installed/x86-windows/include/xmlsec/

# xmlsec/nss/crypto.h

#export XMLSEC_CFLAGS="-I$VCPKG_DIR/include"
#export XMLSEC_LIBS="$VCPKG_DIR/lib/libxmlsec.lib"

#export LIBS="$ICU_LIBS"


echo PYTHON_CFLAGS=$PYTHON_CFLAGS, PYTHON_LIBS=$PYTHON_LIBS

#--with-webdav=serf or --without-webdav
#[Specify which library to use for webdav implementation.
#         Possible values: "neon", "serf", "no". The default value is "neon".
export WEBDAV="--with-webdav=no"

#make basegfx.build
#make comphelper.build


export EXTRA_LO_PATH=`cygpath $VCPKG_DIR`/bin
export PATH=$EXTRA_LO_PATH:$PYTHON:$PATH

# /usr/sbin/gencmn.exe
export PATH=$PATH:/usr/sbin

#export verbose="V=1"

#echo "PATH=$PATH"

[ -z "$MAKE_ONLY" ] && MAKE_ONLY=0
[ -z "$ENVARS_ONLY" ] && ENVARS_ONLY=0
[ -z "$PARALLELISM" ] && PARALLELISM=12


if [ "$ENVARS_ONLY" == "0" ] && [ "$MAKE_ONLY" == "0" ]; then

make clean
rm -f config_host.mk

./autogen.sh --with-lang="bs" \
   $ENABLE_64_BIT --with-locales="bs" \
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
    --with-galleries=no $SKIA \
    --disable-report-builder \
    --disable-lpsolve \
    --disable-coinmp \
    --disable-report-builder \
    --with-help=no \
    --disable-online-update \
    --disable-sdremote \
    --disable-sdremote-bluetooth \
    --disable-pdfimport \
    --disable-extension-integration 


#    --with-system-postgresql=yes \
#    --with-system-curl=yes $WEBDAV \
#    --with-system-libpng=yes \
#    --with-system-libxml=yes \
#    --with-system-expat=yes \
#    --with-system-zlib=yes \
#    --with-system-openssl=yes \
#    --with-system-icu=yes \
#    --with-system-icu-for-build=force \
#    --enable-python=system \
#    --with-system-boost
    
#--with-system-xmlsec=yes 



# Directory of C:\dev\vcpkg\installed\x86-windows\lib
#
#29. 03. 2020.  23:35             3.506 boost_atomic-vc140-mt.lib
#29. 03. 2020.  23:35            24.688 boost_chrono-vc140-mt.lib
#29. 03. 2020.  23:34            45.564 boost_container-vc140-mt.lib
#29. 03. 2020.  23:39             6.432 boost_context-vc140-mt.lib
#29. 03. 2020.  23:40            42.480 boost_contract-vc140-mt.lib
#29. 03. 2020.  23:39            11.318 boost_coroutine-vc140-mt.lib
#29. 03. 2020.  23:36            29.820 boost_date_time-vc140-mt.lib
#29. 03. 2020.  23:34            14.586 boost_exception-vc140-mt.lib
#29. 03. 2020.  23:42            66.942 boost_fiber-vc140-mt.lib
#29. 03. 2020.  23:37            66.192 boost_filesystem-vc140-mt.lib
#29. 03. 2020.  23:41             3.268 boost_graph-vc140-mt.lib
#29. 03. 2020.  23:37           103.514 boost_iostreams-vc140-mt.lib
#29. 03. 2020.  23:38           100.424 boost_locale-vc140-mt.lib
#29. 03. 2020.  23:43           278.298 boost_log-vc140-mt.lib
#29. 03. 2020.  23:43            12.744 boost_log_setup-vc140-mt.lib
#29. 03. 2020.  23:36             8.148 boost_math_c99-vc140-mt.lib
#29. 03. 2020.  23:36             8.286 boost_math_c99f-vc140-mt.lib
#29. 03. 2020.  23:36             8.286 boost_math_c99l-vc140-mt.lib
#29. 03. 2020.  23:36             6.882 boost_math_tr1-vc140-mt.lib
#29. 03. 2020.  23:36             7.018 boost_math_tr1f-vc140-mt.lib
#29. 03. 2020.  23:36             7.018 boost_math_tr1l-vc140-mt.lib
#29. 03. 2020.  23:46           451.556 boost_program_options-vc140-mt.lib
#29. 03. 2020.  23:44           177.564 boost_python37-vc140-mt.lib
#29. 03. 2020.  23:39             3.898 boost_random-vc140-mt.lib
#29. 03. 2020.  23:34         1.186.870 boost_regex-vc140-mt.lib
#29. 03. 2020.  23:38           205.790 boost_serialization-vc140-mt.lib
#29. 03. 2020.  23:46             6.386 boost_stacktrace_noop-vc140-mt.lib
#29. 03. 2020.  23:46             6.426 boost_stacktrace_windbg-vc140-mt.lib
#29. 03. 2020.  23:46             6.574 boost_stacktrace_windbg_cached-vc140-mt.lib
#29. 03. 2020.  23:35             2.246 boost_system-vc140-mt.lib
#29. 03. 2020.  23:36            28.802 boost_thread-vc140-mt.lib
#29. 03. 2020.  23:47            14.842 boost_timer-vc140-mt.lib
#29. 03. 2020.  23:45             3.514 boost_type_erasure-vc140-mt.lib
#29. 03. 2020.  23:41           297.184 boost_unit_test_framework-vc140-mt.lib
#29. 03. 2020.  23:47           150.036 boost_wave-vc140-mt.lib
#29. 03. 2020.  23:38            93.158 boost_wserialization-vc140-mt.lib
#              36 File(s)      3.490.260 bytes
#               0 Dir(s)  310.845.394.944 bytes free
#                
    
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
fi
        
# https://wiki.documentfoundation.org/Development/GenericBuildingHints


if [ "$ENVARS_ONLY" == "0" ] ; then
  time make $ONE_JOB build-nocheck 2>&1 | tee build.log
fi