FROM REPOSITORY/go

RUN go get github.com/mholt/caddy/caddy \
  && caddy -version
