client
nobind
dev tun
remote-cert-tls server

remote VPN_SERVER_NAME 1194 tcp

<key>
include(OPENVPN_CONFIG_PATH/pki/private/client.key)dnl
</key>
<cert>
include(OPENVPN_CONFIG_PATH/pki/issued/client.crt)dnl
</cert>
<ca>
include(OPENVPN_CONFIG_PATH/pki/ca.crt)dnl
</ca>
<dh>
include(OPENVPN_CONFIG_PATH/dh.pem)dnl
</dh>
<tls-auth>
include(OPENVPN_CONFIG_PATH/ta.key)dnl
</tls-auth>
key-direction 1
