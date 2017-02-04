FROM REPOSITORY/jdk

RUN git clone -b v3.1.2 https://github.com/confluentinc/kafka-rest.git

RUN apt-get -y update && apt-get -y install maven

RUN cd kafka-rest && \
  mvn -Dmaven.test.skip=true install

RUN mkdir -p /etc/service/kafka-rest

ADD run /etc/service/kafka-rest/run
ADD log4j.properties /etc/service/kafka-rest/log4j.properties
ADD kafka-rest.properties.m4 /etc/service/kafka-rest/kafka-rest.properties.m4

RUN chmod 0755 /etc/service/kafka-rest/run
