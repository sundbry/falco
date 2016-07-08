FROM REPOSITORY/base

EXPOSE 3306
ENV MY_CNF /etc/service/mysql/my.cnf
VOLUME /var/lib/mysql

RUN apt-get -y install mysql-server

ADD run /etc/service/mysql/
ADD my.cnf /etc/service/mysql/my.cnf
RUN chmod 0755 /etc/service/mysql/run
