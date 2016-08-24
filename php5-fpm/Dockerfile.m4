FROM REPOSITORY/nginx

RUN apt-get -q update && apt-get -q -y install php5 php5-dev php5-fpm php5-gd php5-pgsql php-pear php5-mysql php5-mcrypt php5-xcache php5-xmlrpc

RUN cd /home/app \
  && setuser app bash -c "git clone -b 0.9.1 git@github.com:edenhill/librdkafka.git && cd librdkafka && ./configure && make" \
  && make -C librdkafka install \
  && setuser app bash -c "git clone -b 0.9.1-php5 https://github.com/arnaud-lb/php-rdkafka.git && cd php-rdkafka && phpize && ./configure && make all" \
  && make -C php-rdkafka install

EXPOSE 9000

ENV PHP_INI /etc/service/php-fpm/php.ini
ENV PHP_FPM_CONF /etc/service/php-fpm/php-fpm.conf

RUN mkdir -p /etc/service/php-fpm
ADD php.ini /etc/service/php-fpm/php.ini
ADD php-fpm.conf /etc/service/php-fpm/php-fpm.conf
ADD pool.d /etc/service/php-fpm/pool.d
ADD run /etc/service/php-fpm/run
RUN chmod 0755 /etc/service/php-fpm/run
