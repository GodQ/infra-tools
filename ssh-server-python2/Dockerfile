FROM   godq/ssh-server
MAINTAINER GodQ "https://github.com/godq"

RUN apt-get update

RUN apt-get install -y python2.7 python-dev python-pip

RUN pip install virtualenv

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
