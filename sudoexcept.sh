$User

echo "Enter username : "
read User

sudo useradd $User

sudo groupadd ServerAdmin

sudo usermod -a -G ServerAdmin $User

touch exceptcommand

cat > exceptcommand << END

%ServerAdmin ALL=NOPASSWD: /usr/sbin/chmod
%ServerAdmin ALL=NOPASSWD: /usr/sbin/chown
%ServerAdmin ALL=NOPASSWD: /usr/bin/mkdir
%ServerAdmin ALL=NOPASSWD: /usr/bin/nano
%ServerAdmin ALL=NOPASSWD: /usr/bin/vi
%ServerAdmin ALL=NOPASSWD: /usr/sbin/service
%ServerAdmin ALL=NOPASSWD: /usr/bin/firewall-cmd
%ServerAdmin ALL=NOPASSWD: /usr/sbin/setenforce
%ServerAdmin ALL=NOPASSWD: /usr/sbin/setsebool
%ServerAdmin ALL=NOPASSWD: /usr/bin/mv
%ServerAdmin ALL=NOPASSWD: /usr/bin/cp
%ServerAdmin ALL=NOPASSWD: /usr/bin/rm
%ServerAdmin ALL=NOPASSWD: /usr/bin/yum
%ServerAdmin ALL=NOPASSWD: /usr/bin/systemctl
%ServerAdmin ALL=NOPASSWD: /usr/sbin/nginx
%ServerAdmin ALL=NOPASSWD: /usr/sbin/restorecon
%ServerAdmin ALL=NOPASSWD: /usr/bin/chcon
%ServerAdmin ALL=NOPASSWD: /usr/sbin/semanage
%ServerAdmin ALL=NOPASSWD: /usr/bin/pm2
%ServerAdmin ALL=NOPASSWD: /usr/bin/npm
%ServerAdmin ALL=NOPASSWD: /usr/bin/yarn


END

sudo mv exceptcommand /etc/sudoers.d

echo "Please create password for user"

sudo passwd $User

chage -d 0 $User

sudo yum remove -y git

cd ..

hostname centos

rm -rf shellscript

echo "Complete!!!"
