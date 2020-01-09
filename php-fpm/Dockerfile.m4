FROM arctype/nginx

RUN mkdir -p /usr/src/php && \
  cd /usr/src/php && \
  curl -fSL https://www.php.net/distributions/php-7.2.26.tar.bz2 | tar -xj --strip-components=1 

RUN apt-get -y -q update && \
  apt-get -q -y install unzip git libxml2-dev libpng-dev libjpeg-dev libwebp-dev libkrb5-dev zlib1g-dev libbz2-dev libc-client2007e-dev libpq-dev libmysqlclient-dev libtidy-dev libmcrypt-dev libgmp-dev autoconf libcurl4-openssl-dev

RUN cd /usr/src/php && \
  ./configure --help && \
  ./configure \
    --prefix=/usr \
    --with-bz2 \
    --with-curl \
    --enable-fpm \
    --with-gd \
    --with-gmp \
    --with-imap \
    --with-imap-ssl \
    --enable-intl \
    --with-jpeg-dir=/usr \
    --with-kerberos \
    --enable-mbstring \
    --with-mcrypt \
    --with-mysqli \
    --with-openssl \
    --with-pcre-regex \
    --with-pdo-mysql \
    --with-pdo-pgsql \
    --with-png-dir=/usr \
    --enable-soap \
    --with-pgsql \
    --with-tidy \
    --with-webp-dir=/usr \
    --enable-xml \
    --with-xmlrpc \
    --enable-zip \
    --with-zlib && \
  make && \
  make install

RUN cd /usr/src \
  && git clone -b v1.2.1 https://github.com/edenhill/librdkafka.git && cd librdkafka && ./configure && make \
  && make -C librdkafka install \
  && cd .. \
  && git clone -b 3.1.2 https://github.com/arnaud-lb/php-rdkafka.git && cd php-rdkafka && phpize && ./configure && make all \
  && make -C php-rdkafka install \

EXPOSE 9000

ENV PHP_INI=/etc/service/php-fpm/php.ini PHP_FPM_CONF=/etc/service/php-fpm/php-fpm.conf

# Add extra ini files in your image to conf.d
RUN mkdir -p /etc/service/php-fpm
ADD php.ini /etc/service/php-fpm/php.ini
ADD php-fpm.conf /etc/service/php-fpm/php-fpm.conf
ADD pool.d /etc/service/php-fpm/pool.d
ADD run /etc/service/php-fpm/run
RUN chmod 0755 /etc/service/php-fpm/run && \
  ln -sf /etc/service/php-fpm/php.ini /usr/lib/php.ini
