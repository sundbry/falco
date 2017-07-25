FROM REPOSITORY/base

# Install node
RUN mkdir /usr/local/node
RUN curl -fL https://nodejs.org/dist/v6.11.1/node-v6.11.1-linux-x64.tar.xz | tar -xJ -C /usr/local/node --strip-components=1
ENV PATH /usr/local/node/bin:$PATH
