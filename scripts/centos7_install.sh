
sudo yum -y install perl-Digest-MD5 

sudo yum -y install texinfo
sudo yum -y install  gettext-devel
sudo yum -y install help2man

sudo yum -y install gtk3-devel gstreamer1-devel gstreamer1-plugins-base-devel gstreamer1-plugins-bad-free-devel
echo "GCC 7 potreban. Ako treba, ukucati:"
echo "scl enable devtoolset-7 bash"
gcc --version


function install_gperf_31() {

wget http://ftp.gnu.org/pub/gnu/gperf/gperf-3.1.tar.gz
tar xzvf gperf-3.1.tar.gz
cd gperf-3.1/
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1
make
sudo make install
cd ..

}


function install_flex() {

wget https://github.com/westes/flex/archive/v2.6.4.tar.gz
tar xvzf v2.6.4.tar.gz
cd flex-2.6.4/

./autogen.sh
./configure --prefix=/usr --disable-static
--docdir=/usr/share/doc/flex-2.6.4
make
make check
sudo make install
cd ..
}


GPERF=`gperf --version | grep 3\.1`
if [ "$GPERF" == "GNU gperf 3.1" ]  ; then
  echo instaliran gperf31 
else
  install_gperf_31
fi

#install_flex


