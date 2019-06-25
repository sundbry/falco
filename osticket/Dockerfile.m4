FROM REPOSITORY/php-fpm

RUN cd /usr/src \
  && curl -L -o osticket.tgz https://github.com/osTicket/osTicket/archive/v1.12.tar.gz \
  && tar xzf osticket.tgz \
