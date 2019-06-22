FROM REPOSITORY/base
ARG ASTERISK_VERSION=16.4.0
ARG SRTP_VERSION=1.6.0
ARG JANSSON_VERSION=2.12

# Derived from https://github.com/hibou-io/asterisk-docker/blob/master/Dockerfile
# https://hibou.io/blog/news-info-1/post/announcing-asterisk-docker-14

RUN apt-get update \
    && apt-get install -y \
        build-essential \
        openssl \
        libxml2-dev \
        libncurses5-dev \
        uuid-dev \
        sqlite3 \
        libsqlite3-dev \
        pkg-config \
        libjansson-dev \
        libssl-dev \
        curl \
        msmtp \
				libedit-dev \
				autoconf \
				libtool

# Asterisk expects /usr/sbin/sendmail
RUN ln -s /usr/bin/msmtp /usr/sbin/sendmail

RUN cd /tmp \
		&& curl -L -o srtp.tgz https://github.com/cisco/libsrtp/archive/v${SRTP_VERSION}.tar.gz \
    && tar xzf srtp.tgz
RUN cd /tmp/libsrtp* \
    && ./configure CFLAGS=-fPIC \
    && make \
    && make install

RUN cd /tmp \
		&& curl -L -o jansson.tgz https://github.com/akheron/jansson/archive/v${JANSSON_VERSION}.tar.gz \
		&& tar xzf jansson.tgz \
    && cd jansson-* \
		&& autoreconf -i \
    && ls -l && ./configure && make && make install

RUN cd /tmp && curl -o asterisk.tar.gz http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-${ASTERISK_VERSION}.tar.gz \
    && tar xzf asterisk.tar.gz
RUN cd /tmp/asterisk* \
    && ./configure --with-pjproject-bundled --with-crypto --with-ssl \
    && make \
    && make install \
    && make samples \
    && make config

CMD asterisk -fvvv
