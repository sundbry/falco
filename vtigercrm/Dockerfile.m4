FROM REPOSITORY/php-fpm

RUN apt-get -y -q update && apt-get -y -q install php-imap

RUN mkdir -p /var/www/vtiger && \
  curl -fSL https://cfhcable.dl.sourceforge.net/project/vtigercrm/vtiger%20CRM%207.1.0/Core%20Product/vtigercrm7.1.0.tar.gz \
    | tar -xz --strip-components=1 -C /var/www/vtiger && \
  chown -R www-data:www-data /var/www/vtiger
 
ADD nginx-default.conf /etc/service/nginx/nginx.conf
RUN echo \
  bash -c "echo 'php_flag[memory_limit] = 256M' >> /etc/service/php-fpm/pool.d/www.conf"
  bash -c "echo 'php_flag[max_execution_time] = 60' >> /etc/service/php-fpm/pool.d/www.conf"
