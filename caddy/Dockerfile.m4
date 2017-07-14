FROM REPOSITORY/go

RUN go get github.com/mholt/caddy/caddy \
  && caddy -version

RUN mkdir -p /etc/service/caddy
ADD run /etc/service/caddy/run
RUN chmod 0755 /etc/service/caddy/run
