FROM golang:1.20.5 as builder
COPY . /agent
WORKDIR /agent
RUN git clone https://github.com/GodQ/go-rest-agent.git \
    && cd go-rest-agent \
    && go build -o /agent/agent \
    && ls /agent



FROM openjdk:22-jdk-slim

# https://jmeter.apache.org/usermanual/remote-test.html

ENV JMETER_VERSION 5.6.2
# need to overwrite
ENV SOURCE_GIT_URL "https://gitlab.com/godq/jmeter_test.git" 
# default jmx dir <git project>/jmeter, need to overwrite
ENV PROJECT_DIR "jmeter"
# default lib ext dir <git project>/lib, need to overwrite
ENV LIB_EXT_DIR "lib"
# worker for worker node, master for master node
ENV ROLE=worker
# go-rest-agent port, need to overwrite
ENV AGENT_PORT 80

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update \
    && apt-get install -y zip git curl wget net-tools \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -kv https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz -O \
    && tar zxvf apache-jmeter-${JMETER_VERSION}.tgz -C /tmp \
    && mv /tmp/apache-jmeter-${JMETER_VERSION} /jmeter \
    && rm -f apache-jmeter-${JMETER_VERSION}.tgz

# RUN wget https://github.com/GodQ/go-rest-agent/releases/download/1.0.1/go-rest-agent.tgz -O agent.tgz \
#     && mkdir /tmp/agent/ && tar zxvf agent.tgz -C /tmp/agent \
#     && cp /tmp/agent/dist/linux-amd64/agent /jmeter \
#     && chmod +x agent

EXPOSE 1099
EXPOSE ${AGENT_PORT}

WORKDIR /jmeter

COPY start.sh .
COPY --from=builder /agent/agent /jmeter/

# Default command
CMD ["bash", "start.sh"]
