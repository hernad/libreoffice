#!/bin/bash


mkdir -p scripts/win32
cd scripts/win32
if [ ! -f make.exe ] ; then
  curl -L https://dev-www.libreoffice.org/bin/cygwin/make-4.2.1-msvc.exe -o make.exe
  chmod +x make.exe
fi
cd ../..

echo set make win32 PATH

export PATH=`pwd`/scripts/win32:$PATH

# koristi se MS vsudio llvm/clang-cl
#echo LLVM
#export PATH=/cygdrive/c/LLVM/10/bin:$PATH
#clang --version

#echo $PATH

make --version