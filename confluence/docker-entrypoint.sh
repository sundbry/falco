#!/bin/bash

# check if the `server.xml` file has been changed since the creation of this
# Docker image. If the file has been changed the entrypoint script will not
# perform modifications to the configuration file.
#if [ "$(stat -c "%Y" "${CONF_INSTALL}/conf/server.xml")" -eq "0" ]; then
  if [ -n "${X_PROXY_NAME}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "proxyName" --value "${X_PROXY_NAME}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PROXY_PORT}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "proxyPort" --value "${X_PROXY_PORT}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PROXY_SCHEME}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "scheme" --value "${X_PROXY_SCHEME}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PROXY_SECURE}" ]; then
    xmlstarlet ed --inplace --pf --ps --insert '//Connector[@port="8090"]' --type "attr" --name "secure" --value "${X_PROXY_SECURE}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_PATH}" ]; then
    xmlstarlet ed --inplace --pf --ps --update '//Context[@docBase="../confluence"]/@path' --value "${X_PATH}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_SMTP_HOST}" ]; then
    xmlstarlet ed --inplace --pf --ps --update '//Context[@docBase="../confluence"]/Resource[@name="mail/SMTPServer"]/@mail.smtp.host' --value "${X_SMTP_HOST}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_SMTP_PORT}" ]; then
    xmlstarlet ed --inplace --pf --ps --update '//Context[@docBase="../confluence"]/Resource[@name="mail/SMTPServer"]/@mail.smtp.port' --value "${X_SMTP_PORT}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_SMTP_AUTH}" ]; then
    xmlstarlet ed --inplace --pf --ps --update '//Context[@docBase="../confluence"]/Resource[@name="mail/SMTPServer"]/@mail.smtp.auth' --value "${X_SMTP_AUTH}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_SMTP_USER}" ]; then
    xmlstarlet ed --inplace --pf --ps --update '//Context[@docBase="../confluence"]/Resource[@name="mail/SMTPServer"]/@mail.smtp.user' --value "${X_SMTP_USER}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_SMTP_PASSWORD}" ]; then
    xmlstarlet ed --inplace --pf --ps --update '//Context[@docBase="../confluence"]/Resource[@name="mail/SMTPServer"]/@password' --value "${X_SMTP_PASSWORD}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_SMTP_STARTTLS}" ]; then
    xmlstarlet ed --inplace --pf --ps --update '//Context[@docBase="../confluence"]/Resource[@name="mail/SMTPServer"]/@mail.smtp.starttls.enable' --value "${X_SMTP_STARTTLS}" "${CONF_INSTALL}/conf/server.xml"
  fi
  if [ -n "${X_SMTP_TRANSPORT}" ]; then
    xmlstarlet ed --inplace --pf --ps --update '//Context[@docBase="../confluence"]/Resource[@name="mail/SMTPServer"]/@mail.transport.protocol' --value "${X_SMTP_TRANSPORT}" "${CONF_INSTALL}/conf/server.xml"
  fi
#fi

if [ -f "${CERTIFICATE}" ]; then
  keytool -noprompt -storepass changeit -keystore ${JAVA_CACERTS} -import -file ${CERTIFICATE} -alias CompanyCA
fi

exec "$@"
