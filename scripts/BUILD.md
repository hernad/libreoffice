# LO build


## configure.ac example config jpeg (libjpeg-turbo) library:

check system or internally built library:

<pre>
dnl ===================================================================
dnl Check for system jpeg
dnl ===================================================================
AC_MSG_CHECKING([which libjpeg to use])
if test "$with_system_jpeg" = "yes"; then
    AC_MSG_RESULT([external])
    SYSTEM_LIBJPEG=TRUE
    if test "$build_os" = "cygwin"; then
        AC_MSG_NOTICE([cygwin - LIBJPEG SKIP CHECK])
    else
        AC_CHECK_HEADER(jpeglib.h, [ LIBJPEG_CFLAGS= ],
            [AC_MSG_ERROR(jpeg.h not found. install libjpeg)], [])
        AC_CHECK_LIB(jpeg, jpeg_resync_to_restart, [ LIBJPEG_LIBS="-ljpeg" ],
            [AC_MSG_ERROR(jpeg library not found or functional)], [])
    fi
else
    SYSTEM_LIBJPEG=
    AC_MSG_RESULT([internal, libjpeg-turbo])
    BUILD_TYPE="$BUILD_TYPE LIBJPEG_TURBO"
    LIBJPEG_CFLAGS="-I${WORKDIR}/UnpackedTarball/libjpeg-turbo"
    if test "$COM" = "MSC"; then
        LIBJPEG_LIBS="${WORKDIR}/UnpackedTarball/libjpeg-turbo/.libs/libjpeg.lib"
    else
        LIBJPEG_LIBS="-L${WORKDIR}/UnpackedTarball/libjpeg-turbo/.libs -ljpeg"
    fi

    case "$host_cpu" in
    x86_64 | amd64 | i*86 | x86 | ia32)
        AC_CHECK_PROGS(NASM, [nasm nasmw yasm])
        if test -z "$NASM" -a "$build_os" = "cygwin"; then
            if test -n "$LODE_HOME" -a -x "$LODE_HOME/opt/bin/nasm"; then
                NASM="$LODE_HOME/opt/bin/nasm"
            elif test -x "/opt/lo/bin/nasm"; then
                NASM="/opt/lo/bin/nasm"
            fi
        fi

  ....
fi

AC_SUBST(NASM)
AC_SUBST(LIBJPEG_CFLAGS)
AC_SUBST(LIBJPEG_LIBS)
AC_SUBST(SYSTEM_LIBJPEG)
</pre>


## build_lo.sh 

<pre>
  WITH_SYSTEM+=" --with-system-jpeg=yes"
  export LIBJPEG_CFLAGS="-I$CONAN_DEPLOY_DIR/libjpeg-turbo/include"
  export LIBJPEG_LIBS="$CONAN_DEPLOY_DIR/libjpeg-turbo/lib/libjpeg.lib"
</pre>

## Makefile VARS

autogen/configure `--with-system-libjpeg`


## RepositoryExternal.mk

<pre>
ifneq ($(SYSTEM_LIBJPEG),)
---------------------   SYSTEM OS library OR CONAN library ------------------------------
define gb_LinkTarget__use_libjpeg
$(call gb_LinkTarget_add_libs,$(1),$(LIBJPEG_LIBS)) <<<< USE ENVAR LIBJPEG_LIBS
$(call gb_LinkTarget_set_ldflags,$(1),\
	$$(filter-out -L/usr/lib/jvm%,$$(T_LDFLAGS)) \
)

endef

gb_ExternalProject__use_libjpeg :=

else
----------------------- built from source external/tarballs/libjpeg-turbo-1.5.3.tar.gz ---------------------------- 
define gb_LinkTarget__use_libjpeg
$(call gb_LinkTarget_set_include,$(1),\
	$(LIBJPEG_CFLAGS) \
	$$(INCLUDE) \
)
$(call gb_LinkTarget_add_libs,$(1),$(LIBJPEG_LIBS))
$(call gb_LinkTarget_use_external_project,$(1),libjpeg-turbo,full)

endef

define gb_ExternalProject__use_libjpeg
$(call gb_ExternalProject_use_external_project,$(1),libjpeg-turbo)

endef

endif # SYSTEM_LIBJPEG
</pre>


## Usage

example `xmlsecurity/Library_xsec_xmlsec.mk`:


<pre>
ifeq ($(SYSTEM_XMLSEC),)
# ... use internally built library
else
# ... use external library
endif
</pre>


## build defs - gb_Library_add_defs

<pre>
$(eval $(call gb_Library_add_defs,xsec_xmlsec,\
	-DXMLSEC_CRYPTO_NSS \
))
</pre>

## Add win32 libs to linker - gb_Library_use_system_win32_libs

Library xsec_xmlsec - gb_Library_use_system_win32_libs

<pre>
$(eval $(call gb_Library_use_system_win32_libs,xsec_xmlsec,\
	crypt32 \
	advapi32 \
	ncrypt \
	bcrypt \
))
</pre>


## build cxx files - gb_Library_add_exception_objects

<pre>
$(eval $(call gb_Library_add_exception_objects,xsec_xmlsec,\
	xmlsecurity/source/xmlsec/mscrypt/akmngr \
	xmlsecurity/source/xmlsec/mscrypt/sanextension_mscryptimpl \
	xmlsecurity/source/xmlsec/mscrypt/securityenvironment_mscryptimpl \
	...
))
</pre>

=>  build `xmlsecurity/source/xmlsec/mscrypt/akmngr.cxx`, `sanextension_mscryptimpl.cxx` ...


## add library dependencies from external libs - gb_Library_add_libs

u build skripti, definisati enva

<pre>
export XMLSEC_LIBS="c:/dev/xmlsec/win32/lib/libxmlsec.lib c:/dev/xmlsec/win32/lib/libxmlsec-mscng.lib"
</pre>

<pre>
$(eval $(call gb_Library_add_libs,xsec_xmlsec,\
	$(XMLSEC_LIBS) \
))
</pre>

## add library from internally built external libraries - gb_UnpackedTarball_get_dir

<pre>
$(eval $(call gb_Library_add_libs,xsec_xmlsec,\
	$(call gb_UnpackedTarball_get_dir,xmlsec)/win32/binaries/libxmlsec-mscng.lib \
	$(call gb_UnpackedTarball_get_dir,xmlsec)/win32/binaries/libxmlsec.lib \
))
</pre>
