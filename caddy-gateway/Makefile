.PHONY: container

caddy-ingress-controller:
	GOPATH=$$(pwd) go get github.com/wehco/caddy-ingress-controller

container: src/github.com/wehco/caddy-ingress-controller
	#make -C $< PKG=github.com/wehco/caddy-ingress-controller clean push
	make -C $< clean push
