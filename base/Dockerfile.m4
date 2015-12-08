FROM phusion/baseimage:0.9.17

ENV DEBIAN_FRONTEND noninteractive

# Update apt
RUN apt-get update -q -q
RUN apt-get upgrade --yes

# Install utitiles
RUN apt-get install -y wget less screen m4 make git

# Configure syslog
ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf

RUN useradd -m app
RUN chown -R app:app /home/app
WORKDIR /home/app
