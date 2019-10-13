FROM arctype/nginx

RUN add-apt-repository ppa:ondrej/php && \
  apt-get -y -q update && \
  apt-get -q -y install php7.1 php7.1-dev php7.1-fpm php7.1-gd php7.1-pgsql php7.1-mysql php7.1-mcrypt php7.1-xmlrpc php7.1-curl php7.1-mbstring php7.1-xml php7.1-intl php7.1-zip php7.1-soap php7.1-tidy php7.1-imap unzip git

RUN cd /home/app \
  && setuser app bash -c "git clone -b v0.11.4 https://github.com/edenhill/librdkafka.git && cd librdkafka && ./configure && make" \
  && make -C librdkafka install \
  && setuser app bash -c "git clone -b 3.0.5 https://github.com/arnaud-lb/php-rdkafka.git && cd php-rdkafka && phpize && ./configure && make all" \
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
