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
export VCPKG_BOOST_BUILD_LIB="vc140"  # VS 2019
export VS_VERSION="2019"



if [ "$BUILD_ARCH" == "x64" ] ; then

  ENABLE_64_BIT=--enable-64-bit
  export PYTHON_VERSION="3.7.3"
  export VCPKG_DIR=c:/dev/vcpkg/installed/x64-windows
  export VCPKG_STATIC_DIR=c:/dev/vcpkg/installed/x64-windows-static
  export CONAN_DEPLOY_DIR=c:/dev/libreoffice/conan/deploy_x64
  export PYTHON=C:/dev/vcpkg/downloads/tools/python/python-3.7.3-x64/python.exe
  export PYTHON_CFLAGS="-I$VCPKG_DIR/include/python3.7"
  export PYTHON_LIBS="$VCPKG_DIR/lib/python37.lib"

else
  ENABLE_64_BIT=
  export VCPKG_DIR=c:/dev/vcpkg/installed/x86-windows
  export VCPKG_STATIC_DIR=c:/dev/vcpkg/installed/x86-windows-static
  #export PYTHON_DIR=c:/dev/Python37-32
  #export PYTHON=$PYTHON_DIR/python.exe
  #export PYTHON_CFLAGS="-I$PYTHON_DIR/include"
  #export PYTHON_LIBS="$PYTHON_DIR/libs/python37.lib"
  #export PYTHON_VERSION="3.7.7"
  export PYTHON_VERSION="3.7.3"
  export PYTHON=C:/dev/vcpkg/downloads/tools/python/python-3.7.3-x86/python.exe
  export PYTHON_CFLAGS="-I$VCPKG_DIR/include/python3.7"
  export PYTHON_LIBS="$VCPKG_DIR/lib/python37.lib"
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


export EXTRA_LO_PATH=`cygpath $VCPKG_DIR`/bin
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

if [ "$ENVARS_ONLY" == "0" ] && [ "$MAKE_ONLY" == "0" ]; then

make clean
#rm -f config_host.mk
rm -f config_host/*.h

WITH_SYSTEM=
if [ "$WITH_VCPKG_ZERO" == "1" ] ; then
  echo PYTHON_CFLAGS=$PYTHON_CFLAGS, PYTHON_LIBS=$PYTHON_LIBS
  WITH_SYSTEM+=" --enable-python=system"

  WITH_SYSTEM+=" --with-system-zlib=yes"
  export ZLIB_CFLAGS="-I$CONAN_DEPLOY_DIR/zlib/include"
  export ZLIB_LIBS="$CONAN_DEPLOY_DIR/zlib/lib/zlib.lib"
 
  WITH_SYSTEM+=" --with-system-libpng=yes"
  export LIBPNG_CFLAGS="-I$CONAN_DEPLOY_DIR/libpng/include"
  export LIBPNG_LIBS="$CONAN_DEPLOY_DIR/libpng/lib/libpng16.lib $ZLIB_LIBS"

  WITH_SYSTEM+=" --with-system-boost"
  export BOOST_CPPFLAGS="-I$CONAN_DEPLOY_DIR/boost/include -I$CONAN_DEPLOY_DIR/bzip2/include"
  export BOOST_CXXFLAGS=$BOOST_CPPFLAGS
  export BOOST_LDFLAGS=""
  export BOOST_LOCALE_LIB="bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/boost_locale.lib $ZLIB_LIBS"
  export BOOST_DATE_TIME_LIB="bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/boost_date_time.lib $ZLIB_LIBS"
  export BOOST_FILESYSTEM_LIB="bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/boost_filesystem.lib $ZLIB_LIBS"
  export BOOST_IOSTREAMS_LIB="bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/boost_iostreams.lib $ZLIB_LIBS"
  export BOOST_SYSTEM_LIB="bcrypt.lib $CONAN_DEPLOY_DIR/bzip2/lib/bz2.lib $CONAN_DEPLOY_DIR/boost/lib/boost_system.lib $ZLIB_LIBS"
  

  #WITH_SYSTEM+=" --with-system-expat=yes"
  #export EXPAT_CFLAGS="-I$VCPKG_DIR/include"
  #export EXPAT_LIBS="$VCPKG_DIR/lib/expat.lib"
#

#
  #export BREAKPAD_CFLAGS="-I$VCPKG_DIR/include"
  #export BREAKPAD_LIBS="$VCPKG_STATIC_DIR/lib/libbreakpad.lib"
#
  #
  #WITH_SYSTEM+=" --with-system-curl=yes"
  #export CURL_CFLAGS="-I$VCPKG_DIR/include" 
  #export CURL_LIBS="$VCPKG_DIR/lib/libcurl.lib"
#
  ##WITH_SYSTEM+=" --with-system-icu=yes" 
  ##export ICU_CFLAGS="-I$VCPKG_DIR/include"
  ##export ICU_LIBS="$VCPKG_DIR/lib/icudt.lib $VCPKG_DIR/lib/icuin.lib $VCPKG_DIR/lib/icuio.lib $VCPKG_DIR/lib/icutu.lib $VCPKG_DIR/lib/icuuc.lib"
  ##export ICU_VERSION="65.1"
#
  #WITH_SYSTEM+=" --with-system-postgresql=yes"
  #export POSTGRESQL_CFLAGS="-I$VCPKG_DIR/include"
  #export POSTGRESQL_LIBS="$VCPKG_DIR/lib/libpq.lib $VCPKG_DIR/lib/libssl.lib $VCPKG_DIR/lib/libcrypto.lib"

fi


if [ "$WITH_VCPKG_LIBXML" == "1" ] ; then
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

  WITH_SYSTEM+=" --with-system-libxml=yes"
  export LIBXML_CFLAGS="-I$VCPKG_DIR/include"
  #export LDFLAGS="-LIBPATH:${VCPKG_DIR/lib}"
  export LIBXML_LIBS="$VCPKG_DIR/lib/libxml2.lib" 
  export LIBXML_LIBTOOL_LIBS="-L$VCPKG_DIR/lib -llibxml2"
  export LIBXSLT_CFLAGS="-I$VCPKG_DIR/include"
  export LIBXSLT_LIBS="$VCPKG_DIR/lib/libxslt.lib"
  export LIBEXSLT_CFLAGS="-I$VCPKG_DIR/include"
  export LIBEXSLT_LIBS="$VCPKG_DIR/lib/libexslt.lib"
fi


if [ "$WITH_VCPKG" == "1" ] ; then

  export VCPKG_LIBPATH="$VCPKG_DIR/lib"
  #export LIBPATH="$VCPKG_DIR/lib"
  #build liblangtag
  #libtool needs linux format -L${VCPKG_LIBPATH}
  #export LDFLAGS="-L${VCPKG_LIBPATH} -LIBPATH:${VCPKG_LIBPATH}"
  export CFLAGS="-I$VCPKG_DIR/include"
  export CXXFLAGS="-I$VCPKG_DIR/include"

  export VCPKG_LIBPATH="$VCPKG_DIR/lib"
  export LIBPATH="$VCPKG_DIR/lib"
  #build liblangtag
  #libtool needs linux format -L${VCPKG_LIBPATH}
  #export LDFLAGS="-L${VCPKG_LIBPATH} -LIBPATH:${VCPKG_LIBPATH}"
  #export CFLAGS="-I$VCPKG_DIR/include"
  #export CXXFLAGS="-I$VCPKG_DIR/include"

else
  export LIBPATH="c:/xx"
fi


#https://github.com/mbuilov/gnumake-windows/blob/master/gnumake-4.3-dev-x64.exe

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

#    
#    
#    --with-system-openssl=yes \
#    \
#    --with-system-icu-for-build=force \
#    
    
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
  time make $ONE_JOB  build-nocheck 2>&1 | tee build.log
fi