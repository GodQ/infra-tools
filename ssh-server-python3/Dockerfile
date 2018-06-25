FROM   godq/ssh-server
MAINTAINER GodQ "https://github.com/godq"

RUN apt-get update

RUN apt-get install -y python3 python3-dev python3-pip python3-pytest

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
