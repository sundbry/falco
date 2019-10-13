define(PG_MAJOR, 10)dnl
# vim:set ft=dockerfile:
# Derived from https://github.com/docker-library/postgres/tree/04b1d366d51a942b88fff6c62943f92c7c38d9b6/9.5
FROM arctype/base

ENV LANG en_US.utf8

# explicitly set user/group IDs
RUN groupadd -r postgres --gid=999 && useradd -r -g postgres --uid=999 postgres && \
  apt-get update -q && \
  apt-get install -y -q locales gnupg2 libicu-dev python3 python3-pip pv lzop && \
  rm -rf /var/lib/apt/lists/* && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
  mkdir /docker-entrypoint-initdb.d && \
  apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update -y -q && \
	apt-get install -y -q \
    libpq-dev \
    postgresql-common \
		postgresql-PG_MAJOR \
    postgresql-server-dev-PG_MAJOR \
		postgresql-contrib-PG_MAJOR \
  && sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf 

RUN pip3 install virtualenv \
  && mkdir /usr/local/venv \
  && chown postgres /usr/local/venv \
  && setuser postgres /bin/bash -c "\
  virtualenv /usr/local/venv \
  && source /usr/local/venv/bin/activate \
  && pip3 install pyopenssl ndg-httpsclient pyasn1 wal-e[aws]==1.1.0b1 \
  && deactivate"


RUN mkdir -p /var/run/postgresql /etc/service/postgres \
  && chown -R postgres /var/run/postgresql

ADD wal-e /usr/local/bin/wal-e
ADD run /etc/service/postgres/run
ADD postgresql.conf /etc/service/postgres/postgresql.conf

ENV PATH /usr/lib/postgresql/PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data
EXPOSE 5432
