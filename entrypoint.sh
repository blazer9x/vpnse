#!/bin/sh

#Link Configs
mkdir -p /etc/vpnserver
ln -sf /etc/vpnserver/vpn_server.config /tmp/vpnserver/vpn_server.config

exec /tmp/vpnserver/vpnserver execsvc

# Auto Tap bridged adapter
echo "for use with tap - bridged adapter"

sysctl -w net.ipv4.ip_forward=1
yum -y install dnsmasq

IP=10.2.2.1
DHCPRANGE=10.2.2.20,10.2.2.200
DEVNAME=tap_1

cat << TAP1 > /etc/dnsmasq.d/tap.conf
interface=tap_1
listen-address=$IP
dhcp-range=$DHCPRANGE,24h
TAP1

cat /etc/dnsmasq.d/tap.conf
systemctl restart dnsmasq

ip a flush $DEVNAME
ip a change $IP/24 dev $DEVNAME
ip link set $DEVNAME mtu 9000

iptables -D FORWARD -j ACCEPT
iptables -A FORWARD -j ACCEPT

iptables -t nat -D POSTROUTING -j MASQUERADE
iptables -t nat -A POSTROUTING -j MASQUERADE

exit $?
