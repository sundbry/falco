define(`NODE_VERSION', `10.17.0')dnl
define(`OROCRM_VERSION', `3.1.15')dnl
FROM arctype/php-fpm
 
RUN mkdir /usr/local/node && \
  curl -fL https://nodejs.org/dist/v`'NODE_VERSION/node-v`'NODE_VERSION-linux-x64.tar.xz | tar -xJ -C /usr/local/node --strip-components=1
ENV PATH /usr/local/node/bin:$PATH

ADD php.ini /etc/service/php-fpm/php.ini

RUN mkdir -p /etc/service/orocommerce && \
  bash -c "curl -sS https://getcomposer.org/installer | php" && \
  mv composer.phar /usr/bin/composer

RUN git clone -b OROCRM_VERSION https://github.com/oroinc/orocommerce-application.git /usr/lib/orocommerce && \
  cd /usr/lib/orocommerce && \
  mkdir ../.composer && \
  chown -R www-data:www-data . ../.composer && \
  setuser www-data php /usr/bin/composer install --prefer-dist
 
RUN mkdir -p /etc/service/oro-ws
ADD nginx-default.conf /etc/service/nginx/nginx.conf
ADD run /etc/service/orocommerce/run
ADD run-websocket /etc/service/oro-ws/run
ADD cron /etc/service/orocommerce/cron
RUN \
  bash -c "echo 'env[PATH] = /usr/local/node/bin:/usr/local/bin:/usr/bin:/bin' >> /etc/service/php-fpm/pool.d/www.conf" && \
  bash -c "echo 'env[HTTPS] = on' >> /etc/service/php-fpm/pool.d/www.conf" && \
  rm -f /etc/service/cron/down && \
  setuser www-data crontab /etc/service/orocommerce/cron && \
  chown -R www-data:www-data /var/www
