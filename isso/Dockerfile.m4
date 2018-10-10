define(`GIT_TAG', ifelse(GIT_TAG, `', `master', GIT_TAG))dnl
FROM REPOSITORY/node

RUN cd /usr/local/src \
  && wget -q https://bitbucket.org/pypy/pypy/downloads/pypy2-v6.0.0-linux64.tar.bz2 \
  && tar -C /usr/local -xjf pypy2-v6.0.0-linux64.tar.bz2 \
  && ln -s /usr/local/pypy2-v6.0.0-linux64/bin/pypy /usr/local/bin \
  && rm /usr/local/src/* \
  && pypy -V

RUN apt-get update -q \
  && apt-get install -y -q python-pip python-dev libffi-dev sqlite3 \
  && pip install virtualenv

RUN npm install -g uglify-js jade requirejs bower \ 
 && npm install -g --unsafe-perm node-sass

RUN setuser app bash -c "git clone -b GIT_TAG https://github.com/posativ/isso.git \
  && cd isso \
  && virtualenv -p /usr/local/bin/pypy . \
  && source ./bin/activate \
  && pip install gevent \ 
  && python setup.py develop \
  && make init js \
  && ./bin/isso --version"

RUN mkdir -p /etc/service/isso
ADD run /etc/service/isso/run
ADD isso-default.cfg /etc/service/isso/isso.cfg
