FROM arctype/base

EXPOSE 80 443

RUN add-apt-repository ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx
RUN mkdir -p /etc/service/nginx
ADD run /etc/service/nginx/run
RUN chmod 0755 /etc/service/nginx/run
ADD nginx.conf.default /etc/service/nginx/nginx.conf
