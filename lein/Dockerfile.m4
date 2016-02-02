FROM REPOSITORY/jdk

# Share lein 
ENV LEIN_HOME=/usr/local/share/lein

RUN mkdir -p $LEIN_HOME
RUN chown app:app $LEIN_HOME

# Install lein
RUN wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -O /usr/local/bin/lein
RUN chmod 0755 /usr/local/bin/lein
USER app
RUN lein version
USER root
