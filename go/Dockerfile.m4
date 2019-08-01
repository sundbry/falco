FROM REPOSITORY/base

ENV GOPATH /usr/go
ENV GOROOT /usr/lib/go
ENV PATH $PATH:$GOPATH/bin:$GOROOT/bin
RUN mkdir $GOPATH \
  && mkdir $GOROOT \
  && curl -fSL https://storage.googleapis.com/golang/go1.12.7.linux-amd64.tar.gz | tar -C $GOROOT -xz --strip-components=1 \
  && go version
