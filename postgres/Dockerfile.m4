# vim:set ft=dockerfile:
# Derived from https://github.com/docker-library/postgres/tree/04b1d366d51a942b88fff6c62943f92c7c38d9b6/9.5
FROM REPOSITORY/base

# explicitly set user/group IDs
RUN groupadd -r postgres --gid=999 && useradd -r -g postgres --uid=999 postgres

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
RUN apt-get update -q && \
  apt-get install -y -q locales && \
  rm -rf /var/lib/apt/lists/* && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

ENV PG_MAJOR 9.5
RUN mkdir /docker-entrypoint-initdb.d
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 && echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update -q \
	&& apt-get install -y \
    python3 python3-pip \
    postgresql-common \
		postgresql-$PG_MAJOR \
		postgresql-contrib-$PG_MAJOR \
    lzop pv \
  && sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf \
  && pip3 install virtualenv

RUN mkdir /usr/local/venv \
  && chown postgres /usr/local/venv \
  && setuser postgres /bin/bash -c "\
  virtualenv /usr/local/venv \
  && source /usr/local/venv/bin/activate \
  && pip3 install pyopenssl ndg-httpsclient pyasn1 wal-e[aws]==1.1.0b1 \
  && deactivate"

ADD wal-e /usr/local/bin/wal-e
RUN chmod 0755 /usr/local/bin/wal-e

RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data

RUN mkdir -p /etc/service/postgres
ADD run /etc/service/postgres/run
ADD postgresql.conf /etc/service/postgres/postgresql.conf
RUN chmod 0755 /etc/service/postgres/run

EXPOSE 5432
