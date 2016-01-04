FROM REPOSITORY/spark-master:2016-01-04.011645

EXPOSE 8081 7078

RUN rm -rf /etc/service/spark-master
RUN mkdir -p /etc/service/spark-slave
ADD run /etc/service/spark-slave/
RUN chmod 0755 /etc/service/spark-slave/run

ENV SPARK_WORKER_PORT 7078
