#!/bin/bash
#docker run -d --restart=unless-stopped --name rancher-server --hostname rancher -p 7777:8080 -v /sharedock/rancher/server/volumes/var/lib/cattle/:/var/lib/cattle -v /sharedock/rancher/server/volumes/var/lib/mysql/:/var.lib/mysql -v /sharedock/rancher/server/volumes/var/log/mysql/:/var/log/mysql rancher/server --db-host dbit.nord.ru --db-port 3306 --db-user cattle --db-pass cattle --db-name cattle
echo 'Creating local repository from /sharedock/registry'
docker run -d -p 5000:5000 -v /sharedock/registry:/var/lib/registry --restart=always --name registry registry
echo 'docker stop weavescope && docker rm weavescope && scope launch'
docker stop weavescope && docker rm weavescope
sudo curl -L git.io/scope -o /usr/local/bin/scope
sudo chmod a+x /usr/local/bin/scope
scope launch
echo "Removing old instances of IT Services"
docker stop redmine && docker rm redmine && docker stop oxidized && docker rm oxidized &&docker stop zabbix && docker rm zabbix && docker stop nagios && docker rm nagios && docker stop nginx-rp && docker rm nginx-rp
echo "running new redmine container with number:"
docker run -d --hostname=redmine --restart=always --name=redmine -v /sharedock/redmine/app_volume/:/usr/src/redmine/ -v /sharedock:/sharedock -v /sharedock/redmine/files/:/usr/src/redmine/files/ localhost:5000/redmine:1
oxid_reload
echo "stopping oxidized container"
docker stop oxidized
echo "removing oxidized container"
docker rm oxidized
echo "removing oxidized PID file"
rm -f /sharedock/oxidized/pid
echo "running new oxidized container named 'oxidized' with number:"
docker run -d --hostname=oxidized --restart=always -v /sharedock/oxidized:/root/.config/oxidized --name=oxidized -t oxidized/oxidized:latest oxidized
sleep 10
docker logs oxidized
echo "running new zabbix container with number:"
docker run --name zabbix --hostname zabbix --restart=always -v /sharedock/:/sharedock/ -v /sharedock/zabbix/usr/lib/zabbix/alertscripts/:/usr/lib/zabbix/alertscripts/ -d -p 10051:10051 -e PHP_TZ="Europe/Moscow" -e ZBX_SERVER_NAME="zbbx.nord.ru" localhost:5000/zabbix:1
echo "running new nagios container with number:"
#docker run -d --name nagios --hostname nagios --restart=always -v /sharedock/nagios/etc/:/opt/nagios/etc/ -v /sharedock/nagios/var/:/opt/nagios/var/ -v /sharedock/nagios/Custom-Nagios-Plugins/:/opt/Custom-Nagios-Plugins/ -v /sharedock/nagios/nagiosgraph/var/:/opt/nagiosgraph/var/ -v /sharedock/nagios/etc/:/opt/nagiosgraph/etc/ localhost:5000/nagios:1
sleep 30
echo "running new nginx reverse web proxy for accesing web services"
docker run -d -p 80:80 -p 443:443 --name=nginx-rp --hostname=nginx-rp --restart=always --link=redmine --link=oxidized --link=zabbix -v /sharedock/:/sharedock/ -v /sharedock/nginx-rp/sites-enabled/:/etc/nginx/sites-enabled/ localhost:5000/nginx-rp:1
echo "running isc-dhcp server"
docker run -d --name isc-dhcp --net host -v /sharedock/docker-dhcpd/data/:/data localhost:5000/isc-dhcp:1 eth0
echo "Removing local repository"
docker stop registry && docker rm registry
#echo "starting rancher server at http:7777"
#docker stop rancher-server && docker rm rancher-server
#docker run -d --restart=unless-stopped --name rancher-server --hostname rancher -p 7777:8080 -v /sharedock/rancher/server/volumes/var/lib/cattle/:/var/lib/cattle -v /sharedock/rancher/server/volumes/var/lib/mysql/:/var.lib/mysql -v /sharedock/rancher/server/volumes/var/log/mysql/:/var/log/mysql rancher/server --db-host dbit.nord.ru --db-port 3306 --db-user cattle --db-pass cattle --db-name cattle
