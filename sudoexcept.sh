$User

echo "Enter username : "
read User

useradd $User

groupadd ServerAdmin

usermod -a -G ServerAdmin $User

touch exceptcommand

cat > exceptcommand << END

%ServerAdmin ALL=NOPASSWD: /usr/bin/nano
%ServerAdmin ALL=NOPASSWD: /usr/bin/vi
%ServerAdmin ALL=NOPASSWD: /usr/sbin/service
%ServerAdmin ALL=NOPASSWD: /usr/bin/firewall-cmd
%ServerAdmin ALL=NOPASSWD: /usr/sbin/setenforce
%ServerAdmin ALL=NOPASSWD: /usr/sbin/setsebool
%ServerAdmin ALL=NOPASSWD: /usr/bin/mv
%ServerAdmin ALL=NOPASSWD: /usr/bin/cp
%ServerAdmin ALL=NOPASSWD: /usr/bin/rm

END

mv exceptcommand /etc/sudoers.d

echo "Please create password for user"

passwd $User

chage -d 0 $User

echo "Complete!!!"