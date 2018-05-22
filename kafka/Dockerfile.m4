FROM REPOSITORY/jdk

EXPOSE 9092

ENV LOG4J_PROPERTIES_PATH /usr/local/kafka/config/log4j.properties
ENV SERVER_PROPERTIES_M4_PATH /etc/service/kafka/server.properties.m4
ENV BROKER_ID 0
ENV ZOOKEEPER_CONNECT localhost:2181
ENV KAFKA_LOG_DIRS /tmp/kafka-logs
ENV KAFKA_HEAP_OPTS "-Xmx1G -Xms1G"

RUN apt-get -y -q update && apt-get -y -q install netcat

WORKDIR /usr/local/kafka
RUN curl -fSL http://mirrors.ocf.berkeley.edu/apache/kafka/1.1.0/kafka_2.11-1.1.0.tgz | tar -xz --strip-components=1
RUN useradd -d /usr/local/kafka kafka

RUN mkdir -p /etc/service/kafka
ADD server.properties.m4 /etc/service/kafka/
ADD run /etc/service/kafka/
RUN chmod 0755 /etc/service/kafka/run
