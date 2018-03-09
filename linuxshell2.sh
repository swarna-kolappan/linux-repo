#!/bin/bash
tomcat=true
apacheserver=true
Java8=true
dotnetcore=true
MYsql=true
python_i=true
php=true
if [ $tomcat = "true" ]; then
 sudo yum install tomcat
 sudo systemctl start tomcat
 sudo systemctl enable tomcat
 sudo systemctl status tomcat
 sudo rm -f /var/run/yum.pid
fi

if [ $python_i = "true" ]; then
 sudo yum -y groupinstall development
 sudo yum -y install zlib-level
 wget https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tar.xz
 tar xJf Python-3.6.3.tar.xz
 cd Python-3.6.3
 ./configure
 make
 make install
 sudo rm -f /var/run/yum.pid
fi

if [ $apacheserver = "true" ]; then
 sudo yum install httpd;
 sudo systemctl enable httpd.service;
 sudo systemctl start httpd.service;
 sudo systemctl status httpd.service;
 sudo rm -f /var/run/yum.pid
fi

if [ $dotnetcore = "true" ]; then
 sudo yum install centos-release-dotnet
 sudo yum install rh-dotnet20
 scl enable rh-dotnet20 bash
 dotnet --version
 sudo rm -f /var/run/yum.pid
fi


if [ $MYsql = "true" ]; then
 sudo yum install mariadb-server
 sudo systemctl start mariadb
 sudo systemctl enable mariab
 sudo systemctl status mariadb
 sudo systemctl stop mariadb
 sudo rm -f /var/run/yum.pid
fi


if [ $Java8 = "true" ]; then
 sudo yum install java-1.8.0-openjdk
 java -version
 sudo rm -f /var/run/yum.pid
fi


if [ $php = "true" ]; then
 sudo yum install php php-mysql
 sudo systemctl restart httpd.service
 sudo yum search php-
 sudo yum install name of the module
 sudo vim /var/www/html/info.php
 sudo firewall-cmd --permanent --zone=public --add-service=http
 sudo firewall-cmd --permanent --zone=public --add-service=https
 sudo firewall-cmd --reload
 sudo rm -f /var/run/yum.pid
fi 