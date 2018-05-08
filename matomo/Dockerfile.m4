FROM REPOSITORY/php-fpm

RUN mkdir -p /var/www/matomo && \
  curl -fSL https://builds.piwik.org/piwik-3.5.0.tar.gz | tar -xz --strip-components=1 -C /var/www/matomo && \
  chown -R www-data:www-data /var/www/matomo
 
ADD nginx-default.conf /etc/service/nginx/nginx.conf

RUN cd /home/app && \
  curl -fSL https://github.com/maxmind/geoip-api-c/releases/download/v1.6.12/GeoIP-1.6.12.tar.gz | tar -xz && \
  cd GeoIP-1.6.12 && \
  setuser app bash -c "./configure && make && make check" && \
  make install

RUN pecl install geoip-1.1.1

RUN bash -c "echo 'extension=geoip.so' >> /etc/service/php-fpm/php.ini" && \
  bash -c "echo 'geoip.custom_directory=/var/lib/misc' >> /etc/service/php-fpm/php.ini" && \
  curl -fSL http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz | gzip -dc > /var/lib/misc/GeoIPCity.dat
