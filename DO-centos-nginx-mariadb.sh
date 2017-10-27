#!/bin/bash

sudo yum update -y

sudo yum install epel-release -y

sudo yum install wget -y

sudo yum install nginx -y

systemctl start nginx

systemctl enable nginx

sudo yum install firewalld -y

systemctl firewalld start

systemctl firewalld enable

sudo firewall-cmd --add-port=80/tcp --permanent

sudo firewall-cmd --add-port=443/tcp --permanent

sudo firewall-cmd --add-port=3306/tcp --permanent

sudo firewall-cmd --reload

setenforce 0

cat > mariaDB.repo << END

# MariaDB 10.2 CentOS repository list - created 2017-10-27 03:11 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.2/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1

END

sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

sudo yum install php71w-cli php71w-fpm php71w-cli php71w-mbstring php71w-xml php71w-xmlrpc -y

curl  -k -sS https://getcomposer.org/installer | php

sudo mv composer.phar /usr/local/bin/composer

sudo yum install phpmyadmin -y

sudo mv mariaDB.repo /etc/yum.repos.d

sudo yum install mariadb mariadb-server -y

systemctl start mariadb

systemctl enable mariadb

sudo wget https://github.com/laravel/laravel/archive/develop.zip

sudo yum install unzip

sudo unzip develop

sudo mv laravel-develop laravel

sudo mkdir -p /var/www

sudo mv laravel /var/www/laravel

sudo cd /var/www/yoursite

composer install

mysql_secure_installation

echo "Complete!!!"