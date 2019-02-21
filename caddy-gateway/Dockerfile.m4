FROM arctype/caddy-ingress-controller:0.1.4

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  apk add s3cmd m4 coreutils && \
  mkdir -p /etc/service/collector 

ADD crontab.m4 /etc/service/collector/crontab.m4
ADD install-collector /usr/local/bin/install-collector
ADD Caddyfile.tmpl /etc/Caddyfile.tmpl
