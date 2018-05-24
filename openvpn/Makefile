.PHONY: secret $(OPENVPN_CONFIG_PATH)/openvpn.conf $(OPENVPN_CONFIG_PATH)/openvpn-client.conf openvpn.tgz 

secret: openvpn.tgz $(OPENVPN_CONFIG_PATH)/openvpn-client.conf

$(OPENVPN_CONFIG_PATH):
	mkdir -p $@
	
$(OPENVPN_CONFIG_PATH)/openssl-1.0.cnf:
	cp -f openssl-1.0.cnf $@

$(OPENVPN_CONFIG_PATH)/x509-types:
	cp -r x509-types $@

$(OPENVPN_CONFIG_PATH)/pki: $(OPENVPN_CONFIG_PATH)/openssl-1.0.cnf $(OPENVPN_CONFIG_PATH)/x509-types
	if [ ! -d $@ ]; then \
		mkdir -p $(OPENVPN_CONFIG_PATH) && \
		cd $(OPENVPN_CONFIG_PATH) && \
		easyrsa init-pki && \
		easyrsa build-ca && \
		easyrsa gen-req $(VPN_SERVER_NAME) nopass && \
		easyrsa sign-req server $(VPN_SERVER_NAME) && \
		easyrsa gen-req client nopass && \
		easyrsa sign-req client client; \
	fi

$(OPENVPN_CONFIG_PATH)/dh.pem: 
	cd $(OPENVPN_CONFIG_PATH) && openssl dhparam -out dh.pem 2048

$(OPENVPN_CONFIG_PATH)/ta.key:
	cd $(OPENVPN_CONFIG_PATH) && PATH=$PATH:/usr/local/sbin openvpn --genkey --secret ta.key

$(OPENVPN_CONFIG_PATH)/openvpn.conf:
	m4 \
		-DVPN_SERVER_NAME=$(VPN_SERVER_NAME) \
		-DVPN_DOMAIN=$(VPN_DOMAIN) \
		-DVPN_VIRTUAL_NETWORK=$(VPN_VIRTUAL_NETWORK) \
		-DVPN_VIRTUAL_MASK=$(VPN_VIRTUAL_MASK) \
		-DVPN_SUBNET_A_NETWORK=$(VPN_SUBNET_A_NETWORK) \
		-DVPN_SUBNET_A_MASK=$(VPN_SUBNET_A_MASK) \
		-DVPN_SUBNET_B_NETWORK=$(VPN_SUBNET_B_NETWORK) \
		-DVPN_SUBNET_B_MASK=$(VPN_SUBNET_B_MASK) \
		-DVPN_DNS_SERVER=$(VPN_DNS_SERVER) \
		openvpn.conf.m4 > $@

$(OPENVPN_CONFIG_PATH)/openvpn-client.conf:
	m4 \
		-DVPN_SERVER_NAME=$(VPN_SERVER_NAME) \
		-DOPENVPN_CONFIG_PATH=$(OPENVPN_CONFIG_PATH) \
		openvpn-client.conf.m4 > $@

openvpn.tgz: $(OPENVPN_CONFIG_PATH) $(OPENVPN_CONFIG_PATH)/pki $(OPENVPN_CONFIG_PATH)/dh.pem $(OPENVPN_CONFIG_PATH)/ta.key $(OPENVPN_CONFIG_PATH)/openvpn.conf 
	rm -f $@
	tar -C $(OPENVPN_CONFIG_PATH) -czf $@ .
