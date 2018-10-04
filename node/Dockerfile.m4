FROM REPOSITORY/base

# Install node
RUN mkdir /usr/local/node
RUN curl -fL https://nodejs.org/dist/v8.12.0/node-v8.12.0-linux-x64.tar.xz | tar -xJ -C /usr/local/node --strip-components=1
ENV PATH /usr/local/node/bin:$PATH
