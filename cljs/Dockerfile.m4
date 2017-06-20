FROM REPOSITORY/lein

# Install node
RUN mkdir /usr/local/node
RUN curl -fL https://nodejs.org/dist/v4.4.5/node-v4.4.5-linux-x64.tar.gz | tar -xz -C /usr/local/node --strip-components=1
ENV PATH /usr/local/node/bin:$PATH

# Install ruby for tools
RUN apt-add-repository ppa:brightbox/ruby-ng \
  && apt-get -y -q update \
  && apt-get -y -q install ruby2.2 ruby2.2-dev
