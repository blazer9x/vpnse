# VPN-SE Docker Image to build on top of Centos 7

```
cd vpnse
build -t vpnse .
```

Example for docker-compose.yml:

```
version: '2'
services:
  vpnse:
    image: vpnse:latest
    volumes:
      - ./data/softether/etc:/etc/vpnserver
      - ./data/softether/log:/var/log/vpnserver
    cap_add: [NET_ADMIN]
    network_mode: host
    restart: always
```
