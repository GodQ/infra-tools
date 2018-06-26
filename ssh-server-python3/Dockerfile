FROM   godq/ssh-server
MAINTAINER GodQ "https://github.com/godq"

RUN apt-get update

RUN apt-get install -y python3 python3-dev python3-pip python3-pytest

RUN  ln -s /usr/bin/python3 /usr/bin/python
RUN  ln -s /usr/bin/pip3 /usr/bin/pip
RUN  ln -s /usr/bin/py.test-3 /usr/bin/py.test

RUN pip install pytest-timeout

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
