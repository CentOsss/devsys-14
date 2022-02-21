#!/bin/sh

GW1=89.223.64.1

/sbin/pfctl -Fa -f /etc/pf.conf.contnat
/sbin/route delete default
/sbin/route add -net 0.0.0.0/0 $GW1

pkill -x openvpn
/usr/local/sbin/openvpn --daemon --config /etc/openvpn/server.conf
/usr/local/sbin/openvpn --daemon --config /etc/openvpn/server2.conf