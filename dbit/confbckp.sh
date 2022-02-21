#!/bin/bash
cd /sharedock/gitrepos/confbckp
git pull origin master
clear

#echo "Copying asterisk files"
#scp root@172.16.0.36:/etc/asterisk/* /sharedock/gitrepos/confbckp/asterisk/
#clear

echo "Copying intra files"
scp rabid@172.16.0.1:/etc/pf.conf* /sharedock/gitrepos/confbckp/intra/
scp rabid@172.16.0.1:/etc/hostname.* /sharedock/gitrepos/confbckp/intra/
scp rabid@172.16.0.1:/etc/openvpn/server.conf* /sharedock/gitrepos/confbckp/intra/openvpn/
scp rabid@172.16.0.1:/etc/openvpn/server2.conf* /sharedock/gitrepos/confbckp/intra/openvpn/
scp rabid@172.16.0.1:/etc/squid/squid.conf* /sharedock/gitrepos/confbckp/intra/squid/
scp rabid@172.16.0.1:/var/named/etc/* /sharedock/gitrepos/confbckp/intra/bind
scp rabid@172.16.0.1:/usr/local/bin/checkconn.sh /sharedock/gitrepos/confbckp/intra/checkconn.sh
scp rabid@172.16.0.1:/usr/local/bin/switch* /sharedock/gitrepos/confbckp/intra/
scp rabid@172.16.0.1:/usr/local/bin/scan_subnet.sh /sharedock/gitrepos/confbckp/intra/
scp rabid@172.16.0.1:/home/rabid/switch_* /sharedock/gitrepos/confbckp/intra/
scp -r rabid@172.16.0.1:/etc/postfix/* /sharedock/gitrepos/confbckp/intra/postfix
clear

#echo "Copying bsd files"
#scp rabid@172.16.0.16:/etc/named.conf /sharedock/gitrepos/confbckp/bsd/bind/
#scp rabid@172.16.0.16:/etc/spb.ru.zone* /sharedock/gitrepos/confbckp/bsd/bind/
#scp rabid@172.16.0.16:/etc/hollywood.ru* /sharedock/gitrepos/confbckp/bsd/bind/
#scp rabid@172.16.0.16:/etc/nevsky46.ru /sharedock/gitrepos/confbckp/bsd/bind/
#scp rabid@172.16.0.16:/etc/62.152* /sharedock/gitrepos/confbckp/bsd/bind/
#scp rabid@172.16.0.16:/etc/PROTO* /sharedock/gitrepos/confbckp/bsd/bind/
#scp rabid@172.16.0.16:/etc/localhost* /sharedock/gitrepos/confbckp/bsd/bind/
#scp rabid@172.16.0.16:/etc/root.hint /sharedock/gitrepos/confbckp/bsd/bind/
#scp rabid@172.16.0.16:/etc/rndc.key /sharedock/gitrepos/confbckp/bsd/bind/
#scp rabid@172.16.0.16:/etc/inet/dhcpd4.conf /sharedock/gitrepos/confbckp/bsd/
#scp -r rabid@172.16.0.16:/etc/opt/ /sharedock/gitrepos/confbckp/bsd/
#scp -r rabid@172.16.0.16:/etc/squid/ /sharedock/gitrepos/confbckp/bsd/squid/
echo "copy pptp files"
#scp -r root@172.16.0.2:/etc/ppp/ /sharedock/gitrepos/confbckp/pptp/
#echo "copy nsf files"
#scp -r root@172.16.0.2:/local/notesdata/mail/ /mnt/mail/
cd /sharedock/gitrepos/confbckp
git add .
clear
echo "Set description"
read commitdescr
git commit -m "$commitdescr"
git push origin master
##
