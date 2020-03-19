#!/bin/bash

IP=192.168.80.1
DHCPS=192.168.80.10,192.168.80.200

cat << DNSM > /etc/dnsmasq.conf
interface=tap_1
dhcp-range=tap_1,$DHCPS,24h
dhcp-option=tap_1,3,$IP
cache-size=1000
DNSM

ifconfig tap_1 $IP
systemctl restart dnsmasq
systemctl status dnsmasq
