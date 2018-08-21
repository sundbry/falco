define(TIMESCALEDB_VERSION, 0.11.0)dnl
# Derived from https://github.com/timescale/timescaledb-docker/blob/master/Dockerfile
FROM REPOSITORY/postgres

RUN apt-get -y -q update && \
  apt-get -y -q install cmake

RUN mkdir -p /usr/src/timescaledb \
	&& wget -q -O /usr/src/timescaledb.tar.gz https://github.com/timescale/timescaledb/archive/TIMESCALEDB_VERSION.tar.gz \
	&& tar -C /usr/src/timescaledb --strip-components 1 -zxf /usr/src/timescaledb.tar.gz \
	&& rm -f /usr/src/timescaledb.tar.gz \
	&& cd /usr/src/timescaledb \
	&& ./bootstrap \
	&& cd build \
	&& make install \
  && cd ~ \
  && rm -rf /usr/src/timescaledb/build

RUN echo "shared_preload_libraries = 'timescaledb'" >> /etc/service/postgres/postgresql.conf
