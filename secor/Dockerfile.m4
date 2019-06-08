define(`GIT_TAG', ifelse(GIT_TAG, `', `master', GIT_TAG))dnl
FROM REPOSITORY/jdk

RUN setuser app git clone -b GIT_TAG https://github.com/pinterest/secor.git && \
  cd secor && \
  git log -n 1

RUN apt-get -y -q update && \
  apt-get -y -q install maven

ENV SECOR_INSTALL_DIR=/opt/secor
RUN cd secor && \
  mvn -Pkafka-1.0.0 package && \
  mkdir ${SECOR_INSTALL_DIR} && \
  tar -zxvf target/secor-*-bin.tar.gz -C ${SECOR_INSTALL_DIR} && \ 
  mv ${SECOR_INSTALL_DIR}/secor-*.jar ${SECOR_INSTALL_DIR}/secor.jar
  
RUN mkdir -p /etc/service/secor
ADD run /etc/service/secor/run
