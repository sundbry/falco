FROM REPOSITORY/php-fpm

RUN apt-get -y update && apt-get -y install php-imap

RUN chmod 0777 /usr/src \
  && cd /usr/src \
  && setuser www-data git clone -b v1.12 https://github.com/osTicket/osTicket.git
