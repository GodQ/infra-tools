FROM   godq/ssh-server-python:python3
MAINTAINER GodQ "https://github.com/godq"

ADD requirements.txt .

RUN pip install -r requirements.txt


RUN apt-get update
RUN apt-get install -y zip
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
