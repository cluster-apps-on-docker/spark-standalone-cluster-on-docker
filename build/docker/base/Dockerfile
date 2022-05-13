ARG debian_buster_image_tag=8-jre-slim
# FROM openjdk:${debian_buster_image_tag}
FROM amazoncorretto:8
LABEL mantainer="Gagandeep Singh <singh.gagandeep8@gmail.com>"

# -- Layer: Image Metadata

ARG build_date

LABEL org.label-schema.build-date=${build_date}
LABEL org.label-schema.name="Apache Spark Standalone Cluster on Docker - Cluster Base Image"
LABEL org.label-schema.description="Cluster base image shipped with Python, Scala and a shared workspace folder"
LABEL org.label-schema.url="https://github.com/andre-marcos-perez/spark-cluster-on-docker"
LABEL org.label-schema.schema-version="1.0"

# -- Layer: OS + Python + Scala

ARG scala_version
ARG shared_workspace=/opt/workspace

RUN mkdir -p ${shared_workspace}/data && \
    mkdir -p /usr/share/man/man1
#     apt-get update -y && \
#     apt-get install -y curl python3 r-base && \
#     ln -s /usr/bin/python3 /usr/bin/python && \
#     curl https://downloads.lightbend.com/scala/${scala_version}/scala-${scala_version}.deb -k -o scala.deb && \
#     apt install -y ./scala.deb && \
#     rm -rf scala.deb /var/lib/apt/lists/*

RUN yum -y update
RUN yum -y install yum-utils curl
RUN yum -y groupinstall development

RUN yum list python3*
RUN yum -y install python3 python3-dev python3-pip python3-virtualenv

RUN python -V
RUN python3 -V

ENV PYSPARK_DRIVER_PYTHON python3
ENV PYSPARK_PYTHON python3

RUN pip3 install --upgrade pip

ENV SCALA_HOME="/usr/bin/scala"
ENV PATH=${PATH}:${SCALA_HOME}/bin
ENV SHARED_WORKSPACE=${shared_workspace}

# -- Runtime

VOLUME ${shared_workspace}
CMD ["bash"]
