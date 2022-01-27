#Install Postgres Pro Standard 14 on Oracle Linux for use with 1c
# CentOS Linux release 7.9.2009 (Core)
HOSTNAME=1csrv03
DOMAIN=consalte.ru
IP=192.168.204.16
DB_PATH=
SYS_DISK=/dev/sda1
PASS=bashn3nkiY

echo "Europe/Moscow" > /etc/timezone
ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime
echo "$HOSTNAME.$DOMAIN" > /etc/hostname
hostname $HOSTNAME.$DOMAIN
echo "$IP $HOSTNAME $HOSTNAME.$DOMAIN" >> /etc/hosts
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config
systemctl stop firewalld
systemctl disable firewalld
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum update -y
yum install -y htop hdparm
localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
localectl set-locale LANG=ru_RU.utf8
# test disk (buffered disk reads > 300MB)
hdparm -Tt $SYS_DISK > /test.disk.result


# Postgresql
rpm -i https://repo.postgrespro.ru/pg1c-14/keys/centos.rpm
yum makecache
yum install -y postgrespro-1c-14
/opt/pgpro/1c-14/bin/pg-setup initdb --locale=ru_RU.UTF8 -D $DB_PATH
/opt/pgpro/1c-14/bin/pg-setup service enable
/opt/pgpro/1c-14/bin/pg-setup service start
echo "PATH=/usr/local/sbin:/usr/sbin:/usr/bin/:/opt/pgpro/1c-14/bin/:/root/bin" > /etc/environment
sudo -u postgres /opt/pgpro/1c-14/bin/psql -U postgres -c "alter user postgres with password '$PASS';"
mkdir /var/lib/pgsql_stats_tmp
chown postgres:postgres /var/lib/pgsql_stats_tmp
echo "tmpfs /var/lib/pgsql_stats_tmp tmpfs size=512M,uid=postgres,gid=postgres 0 0" >> /etc/fstab
mount /var/lib/pgsql_stats_tmp
echo "stats_temp_directory = '/var/lib/pgsql_stats_tmp'" >> /var/lib/pgpro/1c-14/data/postgresql.conf
echo "listen_addresses = '*' " >> /var/lib/pgpro/1c-14/data/postgresql.conf
systemctl restart postgrespro-1c-14.service





yum install 1c-enterprise-8.3.19.1150-common-8.3.19-1150.x86_64.rpm
yum install 1c-enterprise-8.3.19.1150-server-8.3.19-1150.x86_64.rpm
yum install fontconfig freetype libgsf unixODBC
ln -s /opt/1cv8/x86_64/8.3.19.1150/srv1cv83 /etc/init.d/srv1cv83
/lib/systemd/systemd-sysv-install enable srv1cv83
systemctl status srv1cv83

cd /opt/1cv8/x86_64/8.3.19.1150/
./ras --daemon cluster
./ras cluster list
./rac cluster list
./rac infobase --cluster=32129bc6-dea7-4e77-9206-b7ec9a62b8af summary list
./rac cluster admin --cluster=32129bc6-dea7-4e77-9206-b7ec9a62b8af register --name=admin --pwd=Lbvtnhf7373 --auth=pwd
./rac infobase create --cluster=32129bc6-dea7-4e77-9206-b7ec9a62b8af --create-database --name=demo --descr=MyTestBaseOnLinuxPower --dbms=PostgreSQL --db-server=localhost --db-name=demo --locale=ru --db-user=postgres --db-pwd=Lbvtnhf7373 --cluster-user=admin --cluster-pwd=Lbvtnhf7373 --license-distribution=allow
