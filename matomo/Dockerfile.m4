FROM REPOSITORY/php-fpm

RUN mkdir -p /var/www/matomo && \
  curl -fSL https://builds.piwik.org/piwik-3.4.0.tar.gz | tar -xz --strip-components=1 -C /var/www/matomo && \
  chown -R www-data:www-data /var/www/matomo
 
ADD nginx-default.conf /etc/service/nginx/nginx.conf
