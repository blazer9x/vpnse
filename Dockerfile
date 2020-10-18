# SoftEther VPN server RTM with Centos 7
FROM centos:7

EXPOSE 992/tcp 5555/tcp 8080/tcp
ENTRYPOINT ["/usr/entrypoint"]

WORKDIR /tmp
RUN yum -y install gcc gcc-c++ make wget curl iptables-services && \
 yum -y install openssl-devel readline-devel && \
 yum -y install grep which && \
 yum -y install dnsmasq && \
 wget "https://www.softether-download.com/files/softether/v4.34-9745-rtm-2020.04.05-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.34-9745-rtm-2020.04.05-linux-x64-64bit.tar.gz" -O /tmp/softether-vpnserver.tar.gz && \
 tar -xzvf /tmp/softether-vpnserver.tar.gz -C /tmp/
 
WORKDIR /tmp/vpnserver
RUN make clean && \
 yes 1 | make && \
 yum clean all && \
 rm -rf /var/cache/yum && \
 rm /tmp/softether-vpnserver.tar.gz

COPY entrypoint.sh /usr/entrypoint
