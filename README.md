# VPN-SE Docker Image to build on top of Centos 7

```
cd vpnse
./build
```

Example for docker-compose.yml:

```
version: '2'
services:
  vpnse:
    image: vpnse:latest
    volumes:
      - ./data:/etc/vpnserver
    cap_add: [NET_ADMIN]
    network_mode: host
    restart: always
```
