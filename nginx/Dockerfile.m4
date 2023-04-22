FROM arctype/base

EXPOSE 80 443

RUN apt-get -y -q update \
  && apt-get install -y -q nginx
RUN mkdir -p /etc/service/nginx
ADD run /etc/service/nginx/run
RUN chmod 0755 /etc/service/nginx/run
ADD nginx.conf.default /etc/service/nginx/nginx.conf
