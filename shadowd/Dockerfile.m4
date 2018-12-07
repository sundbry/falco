FROM REPOSITORY/base

EXPOSE 9115

RUN apt-get -y -q update && \
  apt-get -y -q install cmake libboost-all-dev libdbi-dev libcrypto++-dev

RUN echo TIMESTAMP && \
  setuser app git clone git@github.com:zecure/shadowd.git

RUN cd shadowd && \
  setuser app mkdir build && \
  cd build && \
  setuser app cmake .. -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_BUILD_TYPE=Release .. && \
  setuser app make shadowd && \
  make install && \
  mkdir -p /etc/service/shadowd

ADD run /etc/service/shadowd/run
