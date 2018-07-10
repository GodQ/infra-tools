FROM   godq/ssh-server-python:python3
MAINTAINER GodQ "https://github.com/godq"

RUN mkdir -p /app/logs/
RUN mkdir /workspace
COPY demo /workspace/

RUN apt-get update
RUN apt-get install -y zip
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
