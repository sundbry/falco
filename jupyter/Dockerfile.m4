FROM REPOSITORY/jdk

EXPOSE 8888

RUN apt-get update
RUN apt-get install -y python-pip python-dev
RUN pip install jupyter

ENV SPARK_HOME /usr/local/spark
WORKDIR /usr/local/spark
RUN curl -fSL http://www.us.apache.org/dist/spark/spark-1.6.0/spark-1.6.0-bin-hadoop2.6.tgz | tar -xz --strip-components=1

RUN pip install toree==0.1.0.dev3
RUN jupyter toree install

RUN mkdir -p /etc/service/jupyter
ADD run /etc/service/jupyter
RUN chmod 0755 /etc/service/jupyter/run
