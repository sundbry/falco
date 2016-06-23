FROM REPOSITORY/base

# Install node
RUN mkdir /usr/local/node
RUN curl -fL https://nodejs.org/dist/v4.4.5/node-v4.4.5-linux-x64.tar.gz | tar -xz -C /usr/local/node --strip-components=1
ENV PATH /usr/local/node/bin:$PATH
