FROM REPOSITORY/nginx

RUN apt-get -q update && apt-get -q -y install php5 php5-fpm php5-gd php5-pgsql php-pear php5-mysql php5-mcrypt php5-xcache php5-xmlrpc

EXPOSE 9000

ENV PHP_INI /etc/service/php-fpm/php.ini
ENV PHP_FPM_CONF /etc/service/php-fpm/php-fpm.conf

RUN mkdir -p /etc/service/php-fpm
ADD php.ini /etc/service/php-fpm/php.ini
ADD php-fpm.conf /etc/service/php-fpm/php-fpm.conf
ADD pool.d /etc/service/php-fpm/pool.d
ADD run /etc/service/php-fpm/run
RUN chmod 0755 /etc/service/php-fpm/run
