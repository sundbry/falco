FROM REPOSITORY/jre

WORKDIR /usr/local/spark
RUN curl -fSL http://www.us.apache.org/dist/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz | tar -xz --strip-components=1

ENV SPARK_HOME /usr/local/spark
ADD log4j.properties $SPARK_HOME/conf/log4j.properties
RUN chown -R app:app $SPARK_HOME

RUN mkdir -p /etc/service/spark-master
ADD run /etc/service/spark-master/
RUN chmod 0755 /etc/service/spark-master/run

EXPOSE 8080 7077
