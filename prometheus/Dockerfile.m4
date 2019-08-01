FROM REPOSITORY/go

RUN mkdir -p $GOPATH/src/github.com/prometheus && \
  cd $GOPATH/src/github.com/prometheus && \
  git clone https://github.com/prometheus/prometheus.git && \
  cd prometheus && \
  make build && \
  mv prometheus /usr/bin/

RUN mkdir -p /etc/service/prometheus
ADD run /etc/service/prometheus/run
EXPOSE 9090
