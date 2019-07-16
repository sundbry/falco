secrets=nginx.conf

.PHONY: secret $(secrets)

secret: $(secrets)

nginx.conf: $(NGINX_CONF_PATH)
	cp -f $< $@
