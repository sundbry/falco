FROM REPOSITORY/php-fpm-7.1
 
RUN mkdir /usr/local/node && \
  curl -fL https://nodejs.org/dist/v8.11.1/node-v8.11.1-linux-x64.tar.xz | tar -xJ -C /usr/local/node --strip-components=1
ENV PATH /usr/local/node/bin:$PATH

RUN bash -c "curl -sS https://getcomposer.org/installer | php7.1" && \
  mv composer.phar /usr/bin/composer

RUN git clone -b 3.0.0-beta https://github.com/oroinc/crm-application.git /var/www/orocrm && \
  cd /var/www/orocrm && \
  mkdir ../.composer && \
  chown -R www-data:www-data . ../.composer && \
  setuser www-data php7.1 -c /etc/service/php-fpm/php.ini -d allow_url_fopen=true /usr/bin/composer install --prefer-dist

RUN apt-get -y -q update && apt-get -y -q install php7.1-soap php7.1-tidy
 
ADD nginx-default.conf /etc/service/nginx/nginx.conf
ADD php.ini /etc/service/php-fpm/php.ini

RUN bash -c "echo 'env[PATH] = /usr/local/node/bin:/usr/local/bin:/usr/bin:/bin' >> /etc/service/php-fpm/pool.d/www.conf" 

RUN mkdir -p /etc/service/orocrm
ADD run /etc/service/orocrm/run
RUN chmod 0755 /etc/service/orocrm/run
