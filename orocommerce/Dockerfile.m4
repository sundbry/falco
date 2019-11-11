define(`NODE_VERSION', `10.17.0')dnl
define(`OROCRM_VERSION', `3.1.15')dnl
FROM arctype/php-fpm
 
RUN mkdir /usr/local/node && \
  curl -fL https://nodejs.org/dist/v`'NODE_VERSION/node-v`'NODE_VERSION-linux-x64.tar.xz | tar -xJ -C /usr/local/node --strip-components=1
ENV PATH /usr/local/node/bin:$PATH

RUN mkdir -p /etc/service/orocommerce
ADD php.ini /etc/service/php-fpm/php.ini

RUN bash -c "curl -sS https://getcomposer.org/installer | php" && \
  mv composer.phar /usr/bin/composer

RUN git clone -b OROCRM_VERSION https://github.com/oroinc/orocommerce-application.git /var/www/orocommerce && \
  cd /var/www/orocommerce && \
  mkdir ../.composer && \
  chown -R www-data:www-data . ../.composer && \
  setuser www-data php -c /etc/service/php-fpm/php.ini -d allow_url_fopen=true /usr/bin/composer install --prefer-dist
 
ADD nginx-default.conf /etc/service/nginx/nginx.conf
ADD run /etc/service/orocommerce/run
ADD cron /etc/service/orocommerce/cron
RUN \
  bash -c "echo 'env[PATH] = /usr/local/node/bin:/usr/local/bin:/usr/bin:/bin' >> /etc/service/php-fpm/pool.d/www.conf" && \
  bash -c "echo 'env[HTTPS] = on' >> /etc/service/php-fpm/pool.d/www.conf" && \
  chmod 0755 /etc/service/orocommerce/run && \
  rm -f /etc/service/cron/down && \
  setuser www-data crontab /etc/service/orocommerce/cron && \
  cp -r /var/www/orocommerce/config /etc/service/orocommerce/default-config && \
  ln -sf /etc/service/php-fpm/php.ini /usr/lib/php.ini
