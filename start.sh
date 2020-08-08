#!/bin/bash

echo "for use with tap - bridged adapter"

sysctl -w net.ipv4.ip_forward=1

yum -y install dnsmasq

IP=192.168.4.1
DHCPRANGE=192.168.4.100,192.168.4.200

cat << TAP1 > /etc/dnsmasq.d/tap.conf
interface=tap_1
listen-address=$IP
dhcp-range=$DHCPRANGE,12h
server=8.8.8.8
server=8.8.4.4
TAP1

cat /etc/dnsmasq.d/tap.conf
systemctl restart dnsmasq

ip a flush tap_1
ip a change $IP/24 dev tap_1

iptables -D FORWARD -j ACCEPT
iptables -A FORWARD -j ACCEPT

iptables -t nat -D POSTROUTING -j MASQUERADE
iptables -t nat -A POSTROUTING -j MASQUERADE
