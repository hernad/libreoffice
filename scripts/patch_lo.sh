#!/bin/bash

patch -p1 < patch/04_mk_solenv.diff
patch -p1 < patch/configure_ac_libjpeg_linux.diff
patch -p1 < patch/configure_ac_boost_linux.diff
patch -p1 < patch/05_configure_ac.diff
patch -p1 < patch/06_mk_modules.diff
patch -p1 < patch/ado_cut.patch
patch -p1 < patch/help.diff
patch -p1 < patch/init_bs.diff

patch -p1 < patch/conan_libs.diff
patch -p1 < patch/conan_libs_configure_ac.diff

patch -p1 < patch/init_skia_off_show_tooltip_of_the_day_off.diff


patch -p1 < patch/liborcus_boost_root.diff

