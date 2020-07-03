#!/bin/bash

build_date=$(date -u +'%Y-%m-%d')

# -- Images

docker build --build-arg build_date="${build_date}" -f cluster-base/Dockerfile -t cluster-base .
docker build --build-arg build_date="${build_date}" -f spark-base/Dockerfile -t spark-base .
docker build --build-arg build_date="${build_date}" -f spark-master/Dockerfile -t spark-master .
docker build --build-arg build_date="${build_date}" -f spark-worker/Dockerfile -t spark-worker .

# -- Clean up

docker rmi "$(docker images | grep 'cluster-base' | awk '{print $3}')"
docker rmi "$(docker images | grep 'spark-base' | awk '{print $3}')"