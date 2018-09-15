# SoftEther VPN server RTM with Centos 7
FROM centos:7

EXPOSE 80/tcp 443/tcp 992/tcp 1194/tcp 5555/tcp 80/udp 443/udp 500/udp 1194/udp 4500/udp
ENTRYPOINT ["/usr/vpnserver/entrypoint"]

WORKDIR /usr/vpnserver
RUN yum -y install gcc gcc-c++ make wget curl && \
    yum -y install openssl-devel readline-devel && \
    wget "https://www.softether-download.com/files/softether/v4.25-9656-rtm-2018.01.15-tree/Source_Code/softether-src-v4.25-9656-rtm.tar.gz" -O /tmp/softether-vpnserver.tar.gz && \
    tar -xzvf /tmp/softether-vpnserver.tar.gz -C /usr/local/

WORKDIR /usr/local/v4.25-9656
RUN ./configure && \
    make && \
    make install && \
    mkdir -p /etc/vpnserver && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    rm /tmp/softether-vpnserver.tar.gz

COPY entrypoint /usr/vpnserver/entrypoint
