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


if [$apacheserver -eq "true"]
then
sudo yum install httpd;
systemctl enable httpd.service
systemctl start httpd.service
systemctl status httpd.service

fi


if [$dotnetcore -eq "true"]   
then
yum install centos-release-dotnet
yum install rh-dotnet20 
scl enable rh-dotnet20 bash
dotnet --version
            
fi 


if [$MYsql -eq "true"]
then
yum install mariadb-server
systemctl start mariadb
systemctl enable mariadb
systemctl status mariadb
systemctl stop mariadb

fi 


if [$Java 8 -eq "true"]
then
yum install java-1.8.0-openjdk
java -version

fi


if [$php -eq "true"]
then
   sudo yum install php php-mysql
   sudo systemctl restart httpd.service
   yum search php-
   sudo yum install name of the module
   sudo vim /var/www/html/info.php
   sudo firewall-cmd --permanent --zone=public --add-service=http 
   sudo firewall-cmd --permanent --zone=public --add-service=https
   sudo firewall-cmd --reload


fi




   

