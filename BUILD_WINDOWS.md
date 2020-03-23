
Powershell Admin:

Set-ExecutionPolicy -ExecutionPolicy Unrestricted


git clone https://gerrit.libreoffice.org/lode
cd lode
./setup --prereq



hernad@XPS15-hernad /cygdrive/c/dev/lode/dev/core


$ tail -n2 ~/.bash_profile
export LODE_HOME=/cygdrive/c/dev/lode
export PATH=${LODE_HOME}/opt/bin:${PATH}



C:\dev\openjdk-infrastructure\ansible\playbooks\AdoptOpenJDK_Windows_Playbook\roles\cygwin\tasks\main.yml

<pre>
- name: Install Cygwin build extra packages
  win_command: C:\temp\cygwin.exe -q -P "{{ item }}"
  with_items:
    - autoconf
    - autoconf-archive
    - make
    - unzip
    - zip
    - cpio
    - git
    - wget
    - automake
    - gperf
    - bison
    - flex
    - patch
  tags: cygwin
  </pre>


?  setup-x86_64.exe -P autoconf -P automake -P bison -P cabextract -P doxygen -P flex -P gcc-g++ ^
                -P gettext-devel git -P gnupg -P gperf -P make -P mintty ^
                -P nasm -P openssh -P openssl -P patch -P perl -P python -P python3 ^
                -P pkg-config -P rsync -P unzip -P vim -P wget -P zip -P perl-Archive-Zip ^
                -P perl-Font-TTF -P perl-IO-String



LO 64 bit

./autogen.sh --with-jdk-home=c:/openjdk/jdk-8 --enable-64-bit


make build-nocheck


LO 32 bit

make clean; ./autogen.sh --with-jdk-home=c:AdoptOpenJDK/jdk-14.0.0.36-hotspot

make build-nocheck

