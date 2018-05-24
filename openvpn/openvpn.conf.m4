# Addresses in this subnet
server VPN_VIRTUAL_NETWORK VPN_VIRTUAL_MASK

verb 3
key /etc/openvpn/pki/private/VPN_SERVER_NAME.key
ca /etc/openvpn/pki/ca.crt
cert /etc/openvpn/pki/issued/VPN_SERVER_NAME.crt
dh /etc/openvpn/dh.pem
tls-auth /etc/openvpn/ta.key
key-direction 0
keepalive 10 60
persist-key
persist-tun
duplicate-cn

proto tcp
port 1194
dev tun0
status /tmp/openvpn-status.log

# client-config-dir /etc/openvpn/ccd

user nobody
group nogroup

# Route client subnets
# common home/office networks
#route 192.168.0.0 255.255.255.0
#route 10.0.0.0 255.255.0.0
# Route server subnets
push "route VPN_SUBNET_A_NETWORK VPN_SUBNET_A_MASK"
push "route VPN_SUBNET_B_NETWORK VPN_SUBNET_B_MASK"
# Provide DNS
push "dhcp-option DOMAIN VPN_DOMAIN"
push "dhcp-option DOMAIN-SEARCH VPN_DOMAIN"
push "dhcp-option DNS VPN_DNS_SERVER"
