#!/bin/bash

TEMP=/tmp/answer$$
whiptail --title "Install System"  --menu  "Select option :" 20 60 0 1 "Install LEMP Stack" 2 "Install Monitor Zabbix" 3 "Install JENKINS AUTOMATIC" 4 "Install PHPMYADMIN" 5 "Install NODE.JS PM2" 6 "Config NGINX FOR LARAVEL API" 7 "Config FIREWALL" 8 "Allow port" 9 "setenforce 0"" 2>$TEMP
choice=`cat $TEMP`

case $choice in
    1) echo "
    --------------------
    LEMP Stack Install
    --------------------
    "
        # add epel repo
        sudo yum install epel-release -y
        # update OS
        sudo yum update -y
        # install wget download manager
        sudo yum install wget -y
        # install git client
        sudo yum install git -y
        # install nginx
        sudo yum install nginx -y
        # enable nginx service
        systemctl enable nginx
        # start nginx service
        service nginx start
        
        echo "nginx has been installed next install mariadb"

        cat > MariaDB.repo << END
        # MariaDB 10.2 CentOS repository list - created 2018-01-18 07:30 UTC
        # http://downloads.mariadb.org/mariadb/repositories/
        [mariadb]
        name = MariaDB
        baseurl = http://yum.mariadb.org/10.2/centos7-amd64
        gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
        gpgcheck=1
        END

        mv MariaDB.repo /etc/yum.repos.d

        sudo yum install mariadb mariadb-server -y
        systemctl enable mairadb
        service mariadb start

        echo "-------- MariaDB has installed --------"

        wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
        sudo rpm -Uvh remi-release-7.rpm
        sudo yum install yum-utils -y
        sudo yum-config-manager --enable remi-php71
        sudo yum --enablerepo=remi,remi-php71 install php-fpm php-common -y
        sudo yum --enablerepo=remi,remi-php71 install php-opcache php-pecl-apcu php-cli php-pear php-pdo php-mysqlnd php-pgsql php-pecl-mongodb php-pecl-redis php-pecl-memcache php-pecl-memcached php-gd php-mbstring php-mcrypt php-xml -y
        
        echo "-------- php has been installed --------"

        "---------- config MariaDB ----------"

        mysql_secure_installation

        echo "---------- LEMP Stack has been installed ----------"
        echo "
        List of software have installed
            1.NGINX
            2.MariaDB 10.2
            3.PHP 7.1
            4.git
            5.wget
        "
    2) echo "
    **************************
        Start install Zabbix
    **************************
    "
        # add epel repo
        sudo yum install epel-release -y
        # update OS
        sudo yum update -y
        # install wget downlaod manager
        sudo yum install wget -y
        # install git client
        sudo yum install git -y
        # add zabbix 3.5 repo
        sudo rpm -ivh http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
        # install zabbix server and client
        sudo yum install zabbix-aget zabbix-server zabbix-web-mysql -y
        # make SELinux allow zabbix
        setsebool -P httpd_can_connect_zabbix on
        # Allow port in firewall
        sudo firewall-cmd --add-port=80/tcp --permanent
        sudo firewall-cmd --add-port=10050/tcp --permanent
        sudo firewall-cmd --add-port=10051/tcp --permanent
        