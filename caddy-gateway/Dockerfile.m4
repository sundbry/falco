FROM arctype/caddy-ingress-controller:0.0.1

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk update && \
  apk add s3cmd

ADD Caddyfile.tmpl /etc/Caddyfile.tmpl
