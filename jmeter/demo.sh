#!/bin/bash

worker_count=2
git_url=https://gitlab.com/godq/jmeter_test.git

# cleanup all existent containers
docker ps -f ancestor=jmeter-worker -q | xargs docker rm -f

# i=0
for((i=0;i<$worker_count;i++))
do
    docker run -it -d --rm \
        --name jmeter-worker-$i \
        -e ROLE=worker \
        -e SOURCE_GIT_URL=$git_url \
        -e PROJECT_DIR=jmeter \
        -e LIB_EXT_DIR=lib \
        godq/jmeter
done
docker ps | grep jmeter-worker-

# docker run -it --rm --name jmeter-master -e ROLE=master -e SOURCE_GIT_URL=$git_url jmeter-worker bash
docker run -it --rm \
    --name jmeter-master \
    -p 5000:80 \
    -e ROLE=master \
    -e SOURCE_GIT_URL=$git_url \
    -e PROJECT_DIR=jmeter \
    -e LIB_EXT_DIR=lib \
    godq/jmeter \
    bash

# docker run -it -d --rm \
#     --name jmeter-master \
#     -p 5000:80 \
#     -e ROLE=master \
#     -e SOURCE_GIT_URL=$git_url \
#     -e PROJECT_DIR=jmeter \
#     -e LIB_EXT_DIR=lib \
#     godq/jmeter
