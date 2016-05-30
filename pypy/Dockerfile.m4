FROM REPOSITORY/base

RUN cd /usr/local/src && wget -q https://bitbucket.org/pypy/pypy/downloads/pypy-5.1.1-linux64.tar.bz2 && tar -C /usr/local -xjf pypy-5.1.1-linux64.tar.bz2 && ln -s /usr/local/pypy-5.1.1-linux64/bin/pypy /usr/local/bin && rm /usr/local/src/* && pypy -V
RUN apt-get update -q -q && apt-get install -y -q -q python-pip python-dev
RUN pip install virtualenv
