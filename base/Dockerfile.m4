FROM phusion/baseimage:focal-1.0.0

ENV DEBIAN_FRONTEND=noninteractive KILL_PROCESS_TIMEOUT=60 KILL_ALL_PROCESS_TIMEOUT=60

RUN apt-get update -y -q && \
  apt-get upgrade -y -q && \
  apt-get -y -q remove syslog-ng && \
  apt-get install -y -q wget less m4 make build-essential pkg-config libglib2.0-dev libssl-dev libjson-c-dev ca-certificates libcurl4-openssl-dev && \
  mkdir -p /usr/src/syslog-ng && \
  curl -sfL https://github.com/balabit/syslog-ng/releases/download/syslog-ng-3.23.1/syslog-ng-3.23.1.tar.gz | tar -xz -C /usr/src/syslog-ng --strip-components=1 && \
  cd /usr/src/syslog-ng && \
  ./configure --help && \
  ./configure --prefix=/usr --disable-riemann --disable-python --disable-systemd --enable-http --sysconfdir=/etc/syslog-ng && \
  make && \
  make install && \
  rm -rf /usr/src/syslog-ng && \
  touch /etc/service/cron/down /etc/service/sshd/down && \
  useradd -m app

# configure syslog
ADD syslog-defaults /etc/default/syslog-ng
ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
ADD syslog-stdout.conf /etc/syslog-ng/conf.d/syslog-stdout.conf
ADD syslog-dest.conf.m4 /etc/syslog-ng/syslog-dest.conf.m4

