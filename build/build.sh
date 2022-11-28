#!/bin/bash
#
# -- Build Apache Spark Standalone Cluster Docker Images

# ----------------------------------------------------------------------------------------------------------------------
# -- Variables ---------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

BUILD_DATE="$(date -u +'%Y-%m-%d')"

SHOULD_BUILD_BASE="$(grep -m 1 build_base build.yml | grep -o -P '(?<=").*(?=")')"
SHOULD_BUILD_SPARK="$(grep -m 1 build_spark build.yml | grep -o -P '(?<=").*(?=")')"
SHOULD_BUILD_JUPYTERLAB="$(grep -m 1 build_jupyter build.yml | grep -o -P '(?<=").*(?=")')"

SPARK_VERSION="$(grep -m 1 spark build.yml | grep -o -P '(?<=").*(?=")')"
JUPYTERLAB_VERSION="$(grep -m 1 jupyterlab build.yml | grep -o -P '(?<=").*(?=")')"

SPARK_VERSION_MAJOR=${SPARK_VERSION:0:1}

if [[ "${SPARK_VERSION_MAJOR}" == "2" ]]
then
  HADOOP_VERSION="2.7"
  SCALA_VERSION="2.11.12"
  SCALA_KERNEL_VERSION="0.6.0"
elif [[ "${SPARK_VERSION_MAJOR}"  == "3" ]]
then
  HADOOP_VERSION="3.2"
  SCALA_VERSION="2.12.10"
  SCALA_KERNEL_VERSION="0.10.9"
else
  exit 1
fi

# ----------------------------------------------------------------------------------------------------------------------
# -- Functions----------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

function cleanContainer() {
    container="$(docker ps -a | grep $1 | awk '{print $1}')"
    
    while [ -n "${container}" ];
    do
      docker stop "${container}"
      docker rm "${container}"
    done
}

function cleanContainers() {
    cleanContainer 'jupyterlab'
    cleanContainer 'spark-worker'
    cleanContainer 'spark-master'
    cleanContainer 'spark-base'
    cleanContainer 'base'
}

function cleanImage() {
  docker rmi -f "$(docker images | grep -m 1 $1 | awk '{print $3}')"
}

function cleanImages() {

    if [[ "${SHOULD_BUILD_JUPYTERLAB}" == "true" ]]
    then
      cleanImage 'jupyterlab'
    fi

    if [[ "${SHOULD_BUILD_SPARK}" == "true" ]]
    then
      cleanImage 'spark-worker'
      cleanImage 'spark-master'
      cleanImage 'spark-base'
    fi

    if [[ "${SHOULD_BUILD_BASE}" == "true" ]]
    then
      cleanImage 'base'
    fi

}

function cleanVolume() {
  docker volume rm $1
}

function cleanVolumes() {
  cleanVolume "hadoop-distributed-file-system"
}

function cleanEnvironment() {
  cleanContainers;
  cleanImages;
  cleanVolumes;
}

function buildImage() {
  build_args=$1
  filename=$2
  tag_name=$3

  eval "docker build --progress=plain $build_args -f $filename -t $tag_name ."
}

function buildImages() {

  if [[ "${SHOULD_BUILD_BASE}" == "true" ]]
  then
    build_arg_1="--build-arg build_date="${BUILD_DATE}"";
    build_arg_2="--build-arg scala_version="${SCALA_VERSION}""
    builds_args="$build_arg_1 $build_arg_2";
    filename='docker/base/Dockerfile';
    tag_name='base:latest';

    buildImage $builds_args $filename $tag_name
  fi

  if [[ "${SHOULD_BUILD_SPARK}" == "true" ]]
  then
    build_arg_1="--build-arg build_date="${BUILD_DATE}""
    build_arg_2="--build-arg spark_version="${SPARK_VERSION}""
    build_arg_3="--build-arg hadoop_version="${HADOOP_VERSION}""
    builds_args="$build_arg_1 $build_arg_2 $build_arg_3";
    
    filename='docker/spark-base/Dockerfile';
    tag_name="spark-base:${SPARK_VERSION}";

    buildImage $builds_args $filename $tag_name

    build_arg_1="--build-arg build_date="${BUILD_DATE}"";
    build_arg_2="--build-arg spark_version="${SPARK_VERSION}""
    builds_args="$build_arg_1 $build_arg_2";

    filename='docker/spark-master/Dockerfile';
    tag_name="spark-master:${SPARK_VERSION}";

    buildImage $builds_args $filename $tag_name

    build_arg_1="--build-arg build_date="${BUILD_DATE}""
    build_arg_2="--build-arg spark_version="${SPARK_VERSION}""
    builds_args="$build_arg_1 $build_arg_2"; 
    
    filename='docker/spark-worker/Dockerfile';
    tag_name="spark-worker:${SPARK_VERSION}";

    buildImage $builds_args $filename $tag_name
  fi

  if [[ "${SHOULD_BUILD_JUPYTERLAB}" == "true" ]]
  then
    build_arg_1="--build-arg build_date="${BUILD_DATE}"" 
    build_arg_2="--build-arg scala_version="${SCALA_VERSION}"" 
    build_arg_3="--build-arg spark_version="${SPARK_VERSION}""
    build_arg_4="--build-arg jupyterlab_version="${JUPYTERLAB_VERSION}"" 
    build_arg_5="--build-arg scala_kernel_version="${SCALA_KERNEL_VERSION}""

    builds_args="$build_arg_1 $build_arg_2 $build_arg_3 $build_arg_4 $build_arg_5"; 
    filename='docker/spark-worker/Dockerfile';
    tag_name="jupyterlab:${JUPYTERLAB_VERSION}-spark-${SPARK_VERSION}";

    buildImage $builds_args $filename $tag_name
  fi
}

function buildEnvironment() {
  buildImages;
}

function prepareEnvironment() {
  cleanEnvironment;
  buildEnvironment;
}

# ----------------------------------------------------------------------------------------------------------------------
# -- Main --------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

prepareEnviroment;