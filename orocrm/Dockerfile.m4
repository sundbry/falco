define(`NODE_VERSION', `10.15.0')dnl
define(`OROCRM_VERSION', `3.1.0-rc')dnl
FROM REPOSITORY/php-fpm-7.1
 
RUN mkdir /usr/local/node && \
  curl -fL https://nodejs.org/dist/v`'NODE_VERSION/node-v`'NODE_VERSION-linux-x64.tar.xz | tar -xJ -C /usr/local/node --strip-components=1
ENV PATH /usr/local/node/bin:$PATH

RUN apt-get -y -q update && apt-get -y -q install php7.1-soap php7.1-tidy php7.1-imap unzip

RUN mkdir -p /etc/service/orocrm
ADD php.ini /etc/service/php-fpm/php.ini

RUN bash -c "curl -sS https://getcomposer.org/installer | php7.1" && \
  mv composer.phar /usr/bin/composer

RUN git clone -b OROCRM_VERSION https://github.com/oroinc/crm-application.git /var/www/orocrm && \
  cd /var/www/orocrm && \
  mkdir ../.composer && \
  chown -R www-data:www-data . ../.composer && \
  setuser www-data php7.1 -c /etc/service/php-fpm/php.ini -d allow_url_fopen=true /usr/bin/composer install --prefer-dist
 

RUN bash -c "echo 'env[PATH] = /usr/local/node/bin:/usr/local/bin:/usr/bin:/bin' >> /etc/service/php-fpm/pool.d/www.conf" && \
  bash -c "echo 'env[HTTPS] = on' >> /etc/service/php-fpm/pool.d/www.conf" 

ADD nginx-default.conf /etc/service/nginx/nginx.conf
ADD run /etc/service/orocrm/run
RUN chmod 0755 /etc/service/orocrm/run
ADD cron /etc/service/orocrm/cron
RUN rm -f /etc/service/cron/down && setuser www-data crontab /etc/service/orocrm/cron
RUN cp -r /var/www/orocrm/config /etc/service/orocrm/default-config
