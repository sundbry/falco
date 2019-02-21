FROM cptactionhank/atlassian-confluence:6.12.2

# https://confluence.atlassian.com/doc/setting-up-a-mail-session-for-the-confluence-distribution-6328.html
COPY server.xml /opt/atlassian/confluence/conf/server.xml
COPY docker-entrypoint.sh /
USER root
RUN chown daemon:daemon /opt/atlassian/confluence/conf/server.xml
RUN mv /opt/atlassian/confluence/confluence/WEB-INF/lib/mail-*jar /opt/atlassian/confluence/lib/
USER daemon:daemon
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/opt/atlassian/confluence/bin/start-confluence.sh", "-fg"]
