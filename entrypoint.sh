#!/bin/sh

#Link Configs
mkdir -p /etc/vpnserver
ln -sf /etc/vpnserver/vpn_server.config /tmp/vpnserver/vpn_server.config

exec /tmp/vpnserver/vpnserver execsvc

exit $?
