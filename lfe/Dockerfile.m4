# Lisp-flavored Erlang

FROM REPOSITORY/base

# Install erlang
#RUN echo "deb https://packages.erlang-solutions.com/ubuntu xenial contrib" >> /etc/apt/sources.list \
#  && wget https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc \
#  && apt-key add erlang_solutions.asc
RUN apt-get -y -q update && apt-get -y -q install erlang
# Install LFE
RUN mkdir /usr/local/lfe && curl -fL https://github.com/rvirding/lfe/archive/v1.1.1.tar.gz | tar -xz -C /usr/local/lfe --strip-components=1
RUN cd /usr/local/lfe && make && make install
