#!/bin/sh

# Auto Tap bridged adapter
echo "for use with tap - bridged adapter"

sysctl -w net.ipv4.ip_forward=1
yum -y install dnsmasq

IP=192.168.255.1
DHCPRANGE=192.168.255.10,192.168.255.250
DEVNAME=tap_1

cat << TAP1 > /etc/dnsmasq.d/tap.conf
interface=tap_1
listen-address=$IP
dhcp-range=$DHCPRANGE,24h
cache-size=1000
server=8.8.8.8
server=8.8.4.4
TAP1

dnsmasq --test
cat /etc/dnsmasq.d/tap.conf
systemctl restart dnsmasq

ip a flush $DEVNAME
ip a change $IP/24 dev $DEVNAME
ip link set $DEVNAME mtu 9000

iptables -D FORWARD -j ACCEPT
iptables -A FORWARD -j ACCEPT

iptables -t nat -D POSTROUTING -j MASQUERADE
iptables -t nat -A POSTROUTING -j MASQUERADE

