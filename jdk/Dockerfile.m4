FROM REPOSITORY/base

RUN echo | add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update -q -q
RUN apt-get install -y openjdk-8-jdk
RUN java -version
