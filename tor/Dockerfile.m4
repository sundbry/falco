FROM REPOSITORY/base

RUN wget -O /usr/src/tor.tar.gz https://www.torproject.org/dist/tor-0.3.5.7.tar.gz
RUN mkdir /usr/src/tor && \
  tar  xzf /usr/src/tor.tar.gz --strip-components=1 -C /usr/src/tor

RUN apt-get -y -q update && \
  apt-get -y -q install build-essential automake autoconf libevent-dev libssl-dev

RUN cd /usr/src/tor && \
  ./configure && \
  make && \
  make install

