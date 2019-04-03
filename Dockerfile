# SoftEther VPN server RTM with Centos 7
FROM centos:7

EXPOSE 80/tcp 443/tcp 992/tcp 1194/tcp 5555/tcp 8080/tcp 80/udp 443/udp 500/udp 1194/udp 4500/udp 8080/udp
ENTRYPOINT ["/usr/entrypoint"]

WORKDIR /tmp
RUN yum -y install gcc gcc-c++ make wget curl && \
 yum -y install openssl-devel readline-devel && \
 wget "https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.29-9680-rtm/softether-src-v4.29-9680-rtm.tar.gz" -O /tmp/softether-vpnserver.tar.gz && \
 tar -xzvf /tmp/softether-vpnserver.tar.gz -C /tmp/
WORKDIR /tmp/v4.29-9680
RUN wget "https://raw.githubusercontent.com/blazer9x/vpnse/master/file/Interop_OpenVPN.h" -O src/Cedar/Interop_OpenVPN.h && \
 wget "https://raw.githubusercontent.com/blazer9x/vpnse/master/file/Interop_SSTP.h" -O src/Cedar/Interop_SSTP.h && \
 ./configure && \
 make clean && \
 make && \
 make install && \
 yum clean all && \
 rm -rf /var/cache/yum && \
 rm /tmp/softether-vpnserver.tar.gz

COPY entrypoint /usr/entrypoint
