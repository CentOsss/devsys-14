#!/bin/sh

GW1=62.152.71.193

/sbin/pfctl -Fa -f /etc/pf.conf
/sbin/route delete default
/sbin/route add -net 0.0.0.0/0 $GW1

pkill -x openvpn
/usr/local/sbin/openvpn --daemon --config /etc/openvpn/server.conf.mts
/usr/local/sbin/openvpn --daemon --config /etc/openvpn/server2.conf.mts
route delete 192.168.5/24 192.168.254.130