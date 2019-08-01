FROM REPOSITORY/go

RUN mkdir -p $GOPATH/src/github.com/prometheus && \
  cd $GOPATH/src/github.com/prometheus && \
  git clone https://github.com/prometheus/prometheus.git && \
  cd prometheus && \
  make build && \
  mv prometheus /usr/bin/

RUN useradd prometheus

RUN mkdir /opt/grafana && \
	curl -sfL https://dl.grafana.com/oss/release/grafana-6.3.0-beta2.linux-amd64.tar.gz | tar -xz -C /opt/grafana --strip-components=1 && \
	useradd grafana

ENV PATH /opt/grafana/bin:$PATH

RUN mkdir -p /etc/service/prometheus /etc/service/grafana
ADD run /etc/service/prometheus/run
ADD run-grafana /etc/service/grafana/run
EXPOSE 9090 
EXPOSE 3000
