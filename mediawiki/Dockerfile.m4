FROM REPOSITORY/php-fpm

RUN mkdir /var/www/mediawiki \
  && curl -fL https://releases.wikimedia.org/mediawiki/1.28/mediawiki-1.28.1.tar.gz | tar -xz --strip-components=1 -C /var/www/mediawiki \
  && chown -R www-data:www-data /var/www/mediawiki

ADD nginx-default.conf /etc/service/nginx/nginx.conf

ENV LOCALSETTINGS_PHP /etc/service/mediawiki/localsettings.php
ADD run /etc/service/mediawiki/run
RUN chmod 0755 /etc/service/mediawiki/run
