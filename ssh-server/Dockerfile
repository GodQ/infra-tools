FROM       ubuntu:20.04
MAINTAINER GodQ "https://github.com/godq"

ENV http_proxy http://proxy.vmware.com:3128
ENV https_proxy https://proxy.vmware.com:3128

RUN apt-get update

RUN apt-get install -y iputils-ping net-tools openssh-server curl wget vim 

RUN mkdir /var/run/sshd

RUN echo 'root:password' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]
