FROM arctype/nginx

RUN apt-get -y -q update && \
  apt-get -q -y install unzip git libxml2-dev libpng-dev libjpeg-dev libwebp-dev libkrb5-dev zlib1g-dev libbz2-dev libc-client2007e-dev libpq-dev libmysqlclient-dev libtidy-dev libgmp-dev autoconf libcurl4-openssl-dev libsqlite3-dev libonig-dev libzip-dev libfreetype6-dev

RUN mkdir -p /usr/src/php && \
  cd /usr/src/php && \
  curl -fSL https://www.php.net/distributions/php-7.4.33.tar.bz2 | tar -xj --strip-components=1 && \
  ./configure --help && \
  ./configure \
    --prefix=/usr \
    --with-bz2 \
    --with-curl \
    --enable-fpm \
    --with-freetype \
    --enable-gd \
    --with-gmp \
    --with-imap \
    --with-imap-ssl \
    --enable-intl \
    --with-jpeg \
    --with-kerberos \
    --enable-mbstring \
    --with-mysqli \
    --with-openssl \
    --with-pdo-mysql \
    --with-pdo-pgsql \
    --enable-soap \
    --with-pgsql \
    --with-tidy \
    --with-webp \
    --enable-xml \
    --with-xmlrpc \
    --with-zip \
    --with-zlib && \
  make && \
  make install && \
  cd /usr/src && \
  rm -rf /usr/src/php

RUN cd /usr/src \
  && git clone -b v1.4.4 https://github.com/edenhill/librdkafka.git && cd librdkafka && ./configure && make \
  && cd .. \
  && make -C librdkafka install \
  && git clone -b 3.1.3 https://github.com/arnaud-lb/php-rdkafka.git && cd php-rdkafka && phpize && ./configure && make all \
  && cd .. \
  && make -C php-rdkafka install \
  && rm -rf *

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

# Add ssh
ADD run_sshd /etc/service/sshd/run
ADD sshd_config /etc/service/sshd/sshd_config
RUN chmod 0755 /etc/service/php-fpm/run /etc/service/sshd/run && \
  rm -rf /etc/service/sshd/down
