#!/bin/bash
#
# -- Build Apache Spark Standalone Cluster Docker Images

# ----------------------------------------------------------------------------------------------------------------------
# -- Variables ---------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

SHOULD_BUILD_CLUSTER_BASE="true"
SHOULD_BUILD_SPARK_BASE="true"
SHOULD_BUILD_SPARK_MASTER="true"
SHOULD_BUILD_SPARK_WORKER="true"
SHOULD_BUILD_JUPYTERLAB="true"

BUILD_DATE="$(date -u +'%Y-%m-%d')"
SCALA_VERSION="2.12.11"
SPARK_VERSION="3.0.0"
HADOOP_VERSION="2.7"

# ----------------------------------------------------------------------------------------------------------------------
# -- Functions----------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

function clean_up_containers() {

    if [[ "${SHOULD_BUILD_SPARK_WORKER}" == "true" ]]
    then
      container="$(docker ps -a | grep 'spark-worker' -m 1 | awk '{print $1}')"
      while [ -n "${container}" ];
      do
        docker stop "${container}"
        docker rm "${container}"
        container="$(docker ps -a | grep 'spark-worker' -m 1 | awk '{print $1}')"
      done
    fi

    if [[ "${SHOULD_BUILD_SPARK_MASTER}" == "true" ]]
    then
      container="$(docker ps -a | grep 'spark-master' | awk '{print $1}')"
      docker stop "${container}"
      docker rm "${container}"
    fi

    if [[ "${SHOULD_BUILD_SPARK_BASE}" == "true" ]]
    then
      container="$(docker ps -a | grep 'spark-base' | awk '{print $1}')"
      docker stop "${container}"
      docker rm "${container}"
    fi

    if [[ "${SHOULD_BUILD_CLUSTER_BASE}" == "true" ]]
    then
      container="$(docker ps -a | grep 'cluster-base' | awk '{print $1}')"
      docker stop "${container}"
      docker rm "${container}"
    fi

}

function clean_up_images() {

    if [[ "${SHOULD_BUILD_SPARK_WORKER}" == "true" ]] ; then docker rmi "$(docker images | grep 'spark-worker' | awk '{print $3}')" ; fi
    if [[ "${SHOULD_BUILD_SPARK_MASTER}" == "true" ]] ; then docker rmi "$(docker images | grep 'spark-master' | awk '{print $3}')" ; fi
    if [[ "${SHOULD_BUILD_SPARK_BASE}" == "true" ]] ; then docker rmi "$(docker images | grep 'spark-base' | awk '{print $3}')" ; fi
    if [[ "${SHOULD_BUILD_CLUSTER_BASE}" == "true" ]] ; then docker rmi "$(docker images | grep 'cluster-base' | awk '{print $3}')" ; fi

}

function build_images() {

  if [[ "${SHOULD_BUILD_CLUSTER_BASE}" == "true" ]]
  then
    docker build \
      --build-arg build_date="${BUILD_DATE}" \
      --build-arg scala_version="${SCALA_VERSION}" \
      -f docker/cluster-base/Dockerfile \
      -t cluster-base .
  fi

  if [[ "${SHOULD_BUILD_SPARK_BASE}" == "true" ]]
  then
    docker build \
      --build-arg build_date="${BUILD_DATE}" \
      --build-arg spark_version="${SPARK_VERSION}" \
      --build-arg hadoop_version="${HADOOP_VERSION}" \
      -f docker/spark-base/Dockerfile \
      -t spark-base:${SPARK_VERSION} .
  fi

  if [[ "${SHOULD_BUILD_SPARK_MASTER}" == "true" ]]
  then
    docker build \
      --build-arg build_date="${BUILD_DATE}" \
      -f docker/spark-master/Dockerfile \
      -t spark-master:${SPARK_VERSION} .
  fi

  if [[ "${SHOULD_BUILD_SPARK_WORKER}" == "true" ]]
  then
    docker build \
      --build-arg build_date="${BUILD_DATE}" \
      -f docker/spark-worker/Dockerfile \
      -t spark-worker:${SPARK_VERSION} .
  fi

}

# ----------------------------------------------------------------------------------------------------------------------
# -- Main --------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

clean_up_containers;
clean_up_images;
build_images;
