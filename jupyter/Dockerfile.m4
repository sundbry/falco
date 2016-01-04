FROM REPOSITORY/jre

EXPOSE 8888

RUN apt-get update
RUN apt-get install -y python-pip python-dev
RUN pip install jupyter

ENV SPARK_HOME /usr/local/spark
WORKDIR /usr/local/spark
RUN curl -fSL http://www.us.apache.org/dist/spark/spark-1.5.2/spark-1.5.2-bin-hadoop2.6.tgz | tar -xz --strip-components=1

RUN mkdir -p /etc/service/jupyter
ADD run /etc/service/jupyter
RUN chmod 0755 /etc/service/jupyter/run
