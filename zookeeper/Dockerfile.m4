define(ZOO_VERSION, 3.5.4-beta)dnl
FROM REPOSITORY/jdk

# Comma-separated list of hosts
ENV SERVERS zookeeper-1
# Zookeeper node id, starting at 1
ENV MYID 1
# Log4j properties
ENV LOG4J_PROPERTIES_PATH /opt/zookeeper/conf/log4j.properties
# Zookeeper config template path
ENV ZOOCFG_M4 /etc/service/zookeeper/zoo.cfg.m4
# Zookeeper data path
ENV ZOODATA /tmp/zookeeper
# Zookeeper config dir
ENV ZOOCFGDIR /etc/service/zookeeper

EXPOSE 2181 2888 3888

RUN apt-get update && apt-get install -y python net-tools netcat
# https://www.apache.org/mirrors/dist.html
RUN curl -fL http://www.us.apache.org/dist/zookeeper/zookeeper-ZOO_VERSION/zookeeper-ZOO_VERSION.tar.gz | tar xzf - -C /opt && mv /opt/zookeeper-ZOO_VERSION /opt/zookeeper
RUN useradd -d /etc/service/zookeeper zookeeper

VOLUME /tmp/zookeeper
RUN mkdir -p /etc/service/zookeeper
ADD zoo.cfg.m4 /etc/service/zookeeper/
ADD run /etc/service/zookeeper/
ADD health /etc/service/zookeeper/health
RUN chmod 0755 /etc/service/zookeeper/run /etc/service/zookeeper/health

