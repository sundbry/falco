FROM REPOSITORY/base

RUN \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 58712A2291FA4AD5 \
	&& echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.6.list \
	&& apt-get -y -q update \
	&& apt-get -y -q install mongodb-org

VOLUME ["/var/lib/mongodb", "/var/log/mongodb"]
EXPOSE 27017

RUN mkdir -p /etc/service/mongo
ADD mongod.conf /etc/service/mongo/mongod.conf
ADD run /etc/service/mongo/run
