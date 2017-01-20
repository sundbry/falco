FROM REPOSITORY/base

# OpenJDK
#RUN echo | add-apt-repository ppa:openjdk-r/ppa
#RUN apt-get update -q -q
#RUN apt-get install -y openjdk-8-jdk

# Oracle
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
  && add-apt-repository ppa:webupd8team/java \
  && apt-get -q update \
  && apt-get -q -y install oracle-java8-installer \
  && java -version
