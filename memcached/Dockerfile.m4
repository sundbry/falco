FROM phusion/baseimage:0.11

RUN apt-get -y -q update && \
  apt-get -y -q install build-essential libevent-dev

RUN mkdir -p /usr/src/memcached && \
  curl -fSL http://memcached.org/latest | tar -zx --strip-components=1 -C /usr/src/memcached 

RUN cd /usr/src/memcached && \
  ./configure && \
  make && make test && make install

EXPOSE 11211
RUN useradd memcached
ADD run /etc/service/memcached/run
