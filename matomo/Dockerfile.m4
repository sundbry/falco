FROM REPOSITORY/php-fpm

RUN mkdir -p /var/www/matomo && \
  curl -fSL https://builds.piwik.org/piwik-3.4.0.tar.gz | tar -xz --strip-components=1 -C /var/www/matomo && \
  chown -R www-data:www-data /var/www/matomo
 
ADD nginx-default.conf /etc/service/nginx/nginx.conf

RUN apt-get -y -q update && \
  apt-get -y -q install php-geoip libgeoip-dev && \
  pecl install geoip
RUN bash -c "echo 'extension=geoip.so' >> /etc/service/php-fpm/php.ini" && \
  bash -c "echo 'geoip.custom_directory=/var/lib/misc' >> /etc/service/php-fpm/php.ini" && \
  curl -fSL http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz | tar -xz > /var/lib/misc/GeoIPCity.dat
