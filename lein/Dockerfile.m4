FROM REPOSITORY/jdk

# Share lein binaries
ENV LEIN_HOME=/usr/local/share/lein

# Install leiningen
RUN mkdir -p $LEIN_HOME && chown app:app $LEIN_HOME && wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /usr/local/bin/lein && chmod 0755 /usr/local/bin/lein && setuser app lein version
