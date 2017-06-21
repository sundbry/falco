FROM REPOSITORY/base

EXPOSE 1194

RUN apt-get install -y openvpn iptables

# Setup the service
RUN mkdir -p /etc/service/openvpn/secret
ADD run /etc/service/openvpn/
RUN chmod 0755 /etc/service/openvpn/*

WORKDIR /etc/service/openvpn
