#!/bin/sh

docker-compose down
docker-compose up -d
sleep 3
bash dnsmasq.sh
