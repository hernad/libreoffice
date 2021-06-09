#!/bin/bash

if [[ `uname -a` =~ "CYGWIN" ]] ; then
  JAVA_ROOT=/cygdrive/c/dev/java
else
  JAVA_ROOT=$HOME/java
fi

mkdir -p $JAVA_ROOT

cd $JAVA_ROOT

if [ ! -d apache-ant-1.10.8 ] ; then
  echo apache ant
  curl -LO https://apache.mirror.ba//ant/binaries/apache-ant-1.10.8-bin.zip
  unzip apache-ant-1.10.8-bin.zip
else
  echo "export ANT_HOME=`pwd`/apache-ant-1.10.8" 
fi

if [ ! -d apache-maven-3.6.3 ] ; then
  echo apache maven
  curl -LO https://apache.mirror.ba/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
  tar xvf apache-maven-3.6.3-bin.tar.gz
else
  echo "export MAVEN_HOME=`pwd`/apache-maven-3.6.3" 
fi

if [ ! -f junit-4.12.jar ] ; then
  curl -LO https://repo1.maven.org/maven2/junit/junit/4.12/junit-4.12.jar
else
  echo junit-4.12.jar ok  
fi

if [ ! -f hamcrest-all-1.3.jar ] ; then
 curl -LO https://repo1.maven.org/maven2/org/hamcrest/hamcrest-all/1.3/hamcrest-all-1.3.jar
else
 echo hamcrest-all-1.3.jar ok
fi

ls -l $JAVA_ROOT