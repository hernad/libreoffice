make clean

#THEME=colibre_svg
THEME=sukapura_svg

#ENABLE_64_BIT=--enable-64-bit
ENABLE_64_BIT=--enable-64-bit

 SKIA=--disable-skia
#SKIA=

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


./autogen.sh --with-lang="bs" \
   $ENABLE_64_BIT --with-locales="bs" \
   --with-vendor="hernad" \
   --with-theme="$THEME" \
    --with-visual-studio=2019 \
    --without-doxygen \
    --without-java \
    --with-product-name="LO_Ziher"\
    --with-package-version='7.0.0.10'\
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
    --without-help \
    --disable-online-update \
    --disable-sdremote \
    --disable-sdremote-bluetooth \
    --disable-pdfimport \
    --disable-extension-integration
        


time make build-nocheck
