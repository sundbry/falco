FROM REPOSITORY/base

RUN mkdir -p /usr/local/src/redis \
  && curl -fSL http://download.redis.io/releases/redis-4.0.2.tar.gz | tar -xz --strip-components=1 -C /usr/local/src/redis
RUN cd /usr/local/src/redis \
  && make \
  && make install

EXPOSE 6379

ADD run /etc/service/redis/run
ADD redis.conf /etc/service/redis/redis.conf
RUN chmod 0755 /etc/service/redis/run
