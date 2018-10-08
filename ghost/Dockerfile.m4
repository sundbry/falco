FROM REPOSITORY/node

RUN setuser root npm install -g ghost-cli
RUN setuser app mkdir /home/app/ghost \
  && cd /home/app/ghost \
  && setuser app ghost install \
  --process local \
  --db sqlite3 \
  --no-setup \
  --no-stack
ADD default-config.production.json /home/app/ghost/config.production.json
RUN mkdir -p /etc/service/ghost
ADD run /etc/service/ghost/run
