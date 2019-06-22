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
				libtool \
				doxygen

# Asterisk expects /usr/sbin/sendmail
RUN ln -s /usr/bin/msmtp /usr/sbin/sendmail

RUN cd /usr/src \
		&& curl -L -o libsrtp.tgz https://github.com/cisco/libsrtp/archive/v${SRTP_VERSION}.tar.gz \
    && tar xzf libsrtp.tgz
RUN cd /usr/src/libsrtp* \
    && ./configure CFLAGS=-fPIC \
    && make \
    && make install \
		&& rm -rf /usr/src/libsrtp*

RUN cd /usr/src \
		&& curl -L -o jansson.tgz https://github.com/akheron/jansson/archive/v${JANSSON_VERSION}.tar.gz \
		&& tar xzf jansson.tgz \
    && cd jansson-* \
		&& autoreconf -i \
    && ./configure && make && make install \
		&& rm -rf /usr/src/jannson*

RUN cd /usr/src \
		&& curl -L -o pjproject.tgz https://github.com/pjsip/pjproject/archive/2.9.tar.gz \
		&& tar xzf pjproject.tgz \
		&& cd pjproject-* \
		&& ./configure --with-external-srtp --disable-video --enable-shared --prefix=/usr \
		&& make && make install && ldconfig

RUN cd /usr/src && curl -o asterisk.tar.gz http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-${ASTERISK_VERSION}.tar.gz \
    && tar xzf asterisk.tar.gz
RUN cd /usr/src/asterisk* \
		&& apt-get -y install aptitude \
		&& ./contrib/scripts/install_prereq install
RUN cd /usr/src/asterisk* \
    && ./configure --with-pjproject=/usr --with-pjproject-bundled=no --with-crypto --with-ssl --with-srtp \
    && make \
    && make install

RUN mkdir -p /etc/service/asterisk
ADD run /etc/service/asterisk/
