# Build docker-atlassian confluence from source on local machine:
# ./bin/prepare 7.19.0
# docker build -t docker-atlassian-confluence .
FROM docker-atlassian-confluence

# https://confluence.atlassian.com/doc/setting-up-a-mail-session-for-the-confluence-distribution-6328.html
COPY server.xml /opt/atlassian/confluence/conf/server.xml
COPY docker-entrypoint.sh /
USER root
RUN chown daemon:daemon /opt/atlassian/confluence/conf/server.xml
RUN cp /opt/atlassian/confluence/confluence/WEB-INF/lib/jakarta.mail-1.6.5.jar /opt/atlassian/confluence/lib/ \
  && cp /opt/atlassian/confluence/confluence/WEB-INF/lib/javax.activation-1.2.0.jar /opt/atlassian/confluence/lib/ \
  && cp /opt/atlassian/confluence/confluence/WEB-INF/lib/javax.activation-api-1.2.0.jar /opt/atlassian/confluence/lib/

USER daemon:daemon
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/opt/atlassian/confluence/bin/start-confluence.sh", "-fg"]
