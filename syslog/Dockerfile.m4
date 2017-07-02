# Syslog relay server

FROM REPOSITORY/base

# Install papertrail cert
RUN mkdir /etc/syslog-ng/cert.d \
  && cd /etc/syslog-ng/cert.d \
  && curl https://papertrailapp.com/tools/papertrail-bundle.tar.gz | tar xzf - \
  && wget https://s3.amazonaws.com/repo.logdna.com/syslog/ld-root-ca.crt

# Override syslog-ng.conf
RUN rm -f /etc/syslog-ng/conf.d/*
ADD syslog-ng.conf /etc/syslog-ng/syslog-ng.conf
