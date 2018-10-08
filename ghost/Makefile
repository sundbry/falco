SECRETS=config.production.json

.PHONY: secret $(SECRETS)

secret: $(SECRETS)

config.production.json: $(GHOST_CONFIG_PATH)
	cp -f $< $@
