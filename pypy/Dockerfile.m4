FROM REPOSITORY/base

RUN cd /usr/local/src && wget -q https://bitbucket.org/pypy/pypy/downloads/pypy2-v5.3.1-linux64.tar.bz2 && tar -C /usr/local -xjf pypy2-v5.3.1-linux64.tar.bz2 && ln -s /usr/local/pypy2-v5.3.1-linux64/bin/pypy /usr/local/bin && rm /usr/local/src/* && pypy -V
RUN apt-get update -q && apt-get install -y -q python-pip python-dev libffi-dev && pip install virtualenv
