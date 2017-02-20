FROM REPOSITORY/base

EXPOSE 3306
ENV MY_CNF /etc/service/mysql/my.cnf
VOLUME /var/lib/mysql

RUN apt-get -y update \
 && apt-get -y install mysql-server

ENV MYSQL_BACKUP_INTERVAL=86400
RUN mkdir -p /etc/service/mysql-backup /var/run/mysqld \
  && chown mysql:mysql /var/run/mysqld

ADD run /etc/service/mysql/run
ADD backup /etc/service/mysql-backup/run
ADD my.cnf /etc/service/mysql/my.cnf

RUN chmod 0755 /etc/service/mysql/run /etc/service/mysql-backup/run
