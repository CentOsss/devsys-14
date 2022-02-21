#!/bin/bash
scp rabid@intra:/etc/pf.conf /itrepos/confbckp/intra/
scp rabid@intra:/etc/hostname.* /itrepos/confbckp/intra/
scp rabid@intra:/etc/openvpn/server.conf /itrepos/confbckp/intra/openvpn/
scp rabid@intra:/etc/openvpn/server2.conf /itrepos/confbckp/intra/openvpn/
scp rabid@intra:/etc/squid/squid.conf /itrepos/confbckp/intra/squid/
cd /itrepos/confbckp
git add .
clear
echo "Set description"
read commitdescr
git commit -m "$commitdescr"
git push origin master
