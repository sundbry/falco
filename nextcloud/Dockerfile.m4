FROM arctype/php-fpm

RUN curl -fSL https://download.nextcloud.com/server/releases/nextcloud-19.0.3.tar.bz2 > /usr/src/nextcloud.tbz2
RUN rm -f /etc/service/cron/down

ENV NGINX_CONF=/etc/service/nextcloud/nginx.conf
ADD nginx.conf /etc/service/nextcloud/nginx.conf
ADD nextcloud-pool.conf /etc/service/php-fpm/pool.d/nextcloud-pool.conf
ADD nextcloud-cron /etc/cron.d/nextcloud-cron
ADD run /etc/service/nextcloud/run
