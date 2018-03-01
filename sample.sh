#!/bin/bash

if [$tomcat -eq "true"]
then
 sudo yum install tomcat
 systemctl start tomcat
 systemctl enable tomcat
 systemctl status tomcat
fi



if [$python_i -eq "true"]
then
 yum -y groupinstall development
 yum -y install zlib-devel
 wget https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tar.xz
 tar xJf Python-3.6.3.tar.xz
 cd Python-3.6.3
 ./configure
  make
  make install

fi



