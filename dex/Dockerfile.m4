FROM REPOSITORY/go

RUN go get github.com/dexidp/dex || true && \
 cd /usr/go/src/github.com/dexidp/dex && \
 make

FROM REPOSITORY/base
COPY --from=0 /usr/go/src/github.com/dexidp/dex/bin/dex /usr/bin/dex
COPY --from=0 /usr/go/src/github.com/dexidp/dex/web /usr/lib/dex/web
COPY --from=0 /usr/go/src/github.com/dexidp/dex/examples/config-dev.yaml /etc/service/dex/config-example.yml
ADD run /etc/service/dex/run
