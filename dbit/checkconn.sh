#!/bin/sh
 
GW=172.18.0.2

/usr/local/sbin/fping -q -c 2 $GW > /dev/null 2>&1
  if [ $? != 0 ]; then
    if [ ! -f /tmp/gw.changed ]; then
    date >> /home/rabid/asd
     /sbin/route delete 172.17/16 172.18.0.2
     /sbin/route delete 172.22.0.0/16 172.18.0.2
     /sbin/route delete 192.168.37/24 172.18.0.2
     /sbin/route delete 192.168.204/24 172.18.0.2
     /sbin/ifconfig vlan2 172.21.0.1 delete
     /sbin/ifconfig vlan2 172.23.0.3 delete
     /sbin/ifconfig vlan2 172.17.0.1 netmask 255.255.0.0
     /sbin/ifconfig vlan2 alias 172.23.0.3 netmask 255.255.255.0
     /sbin/route add 172.22.0.0/16 172.17.0.2
     /sbin/route add 192.168.37/24 172.17.0.2
     /sbin/route add 192.168.204/24 172.17.0.2
     /usr/bin/touch /tmp/gw.changed
     exit
    fi
    exit
  fi

  if [ $? = 0 ]; then
    if [ -f /tmp/gw.changed ]; then
     /sbin/route delete 172.22.0.0/16 172.17.0.2
     /sbin/route delete 192.168.37/24 172.17.0.2
     /sbin/route delete 192.168.204/24 172.17.0.2
     /sbin/ifconfig vlan2 172.17.0.1 delete
     /sbin/ifconfig vlan2 172.23.0.3 delete
     /sbin/ifconfig vlan2 172.21.0.1 netmask 255.255.0.0
     /sbin/ifconfig vlan2 alias 172.23.0.3 netmask 255.255.255.0
     /sbin/route add 172.17/16 172.18.0.2
     /sbin/route add 172.22.0.0/16 172.18.0.2
     /sbin/route add 192.168.37/24 172.18.0.2
     /sbin/route add 192.168.204/24 172.18.0.2
     /bin/rm /tmp/gw.changed
     exit
    fi
  fi