FROM REPOSITORY/nginx

RUN apt-get -q update && apt-get -q -y install php php-dev php-fpm php-gd php-pgsql php-pear php-mysql php-mcrypt php-xmlrpc php-curl php-mbstring

RUN cd /home/app \
  && setuser app bash -c "git clone -b 0.9.1 git@github.com:edenhill/librdkafka.git && cd librdkafka && ./configure && make" \
  && make -C librdkafka install \
  && setuser app bash -c "git clone -b 0.9.1-php7 https://github.com/arnaud-lb/php-rdkafka.git && cd php-rdkafka && phpize && ./configure && make all" \
  && make -C php-rdkafka install

EXPOSE 9000

ENV PHP_INI=/etc/service/php-fpm/php.ini PHP_FPM_CONF=/etc/service/php-fpm/php-fpm.conf

# Add extra ini files in your image to conf.d
RUN mkdir -p /etc/service/php-fpm
ADD php.ini /etc/service/php-fpm/php.ini
ADD php-fpm.conf /etc/service/php-fpm/php-fpm.conf
ADD pool.d /etc/service/php-fpm/pool.d
ADD run /etc/service/php-fpm/run
RUN chmod 0755 /etc/service/php-fpm/run
