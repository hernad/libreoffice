#!/bin/bash


patch -p1 < patch/00_svtzh_svxcorezh.diff
patch -p1 < patch/00b_svxcorezh.diff

patch -p1 < patch/01_DLL_FNAME_POSTFIX.diff
patch -p1 < patch/02_sfxzh.diff
patch -p1 < patch/03_mk_lo2zh.diff
patch -p1 < patch/launcher.diff
patch -p1 < patch/zoffice_ini.diff

# echo ako nije patch_lo.sh primjenjen treba vratiti helplinker and co nazad
patch -p1 < patch/unpatch_wfpt_helplinker_ziher.diff
patch -p1 < patch/svlibrary_DLL_FNAME_POSTFIX.diff


