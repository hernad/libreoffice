#!/bin/bash

#patch -p1 < patch/01_DLL_FNAME_POSTFIX.diff
#patch -p1 < patch/02_sfxzh.diff
#patch -p1 < patch/03_mk_lo2zh.diff
#patch -p1 < patch/launcher.diff

patch -p1 < patch/04_mk_solenv.diff
patch -p1 < patch/05_configure_ac.diff
patch -p1 < patch/06_mk_modules.diff
patch -p1 < patch/ado_cut.patch
patch -p1 < patch/help.diff
patch -p1 < patch/init_bs.diff

patch -p1 < patch/conan_libs.diff
patch -p1 < patch/conan_libs_configure_ac.diff