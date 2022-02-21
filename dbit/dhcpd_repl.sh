#!/bin/sh
#Записан в crontab как симлинк dhcpd_repl
#scp rabid@bsd:/etc/inet/dhcpd4.conf /sharedock/gitrepos/confbckp/bsd/
#cat /sharedock/gitrepos/confbckp/bsd/dhcpd4.conf > /sharedock/docker-dhcpd/data/dhcpd.conf

vim /sharedock/docker-dhcpd/data/dhcpd.conf

docker restart isc-dhcp

docker ps -a
