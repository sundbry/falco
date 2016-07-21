FROM REPOSITORY/jdk
# Java required for Solr (Riak Search)

# Open ports (see doc/Ports.md)
EXPOSE 4369 8087 8093 8098 8099 8985

# Data volumes
VOLUME /var/lib/riak
VOLUME /var/log/riak

# Install Riak
RUN curl https://packagecloud.io/gpg.key | sudo apt-key add -
RUN apt-get install -y apt-transport-https
ADD basho.list /etc/apt/sources.list.d/basho.list
# Install jq for scripts
RUN apt-get update -y -q -q && apt-get install -y -q -q riak=2.1.4-1 jq

# Setup the Riak service
RUN mkdir -p /etc/service/riak /usr/local/lib/riak/user
ADD run /etc/service/riak/
RUN chmod 0755 /etc/service/riak/run

# Add the config template
ADD riak.conf.m4 /etc/service/riak/riak.conf.m4
ADD advanced.config /etc/riak/advanced.config

WORKDIR /etc/service/riak
