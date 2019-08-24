FROM phusion/baseimage:0.11

RUN apt-get -y -q update && \
  apt-get -y -q install build-essential

RUN mkdir -p /usr/src/redis \
  && curl -fSL http://download.redis.io/releases/redis-5.0.5.tar.gz | tar -xz --strip-components=1 -C /usr/src/redis
RUN cd /usr/src/redis \
  && make \
  && make install

EXPOSE 6379
RUN useradd redis
ADD run /etc/service/redis/run
ADD redis.conf /etc/service/redis/redis.conf
RUN chmod 0755 /etc/service/redis/run
