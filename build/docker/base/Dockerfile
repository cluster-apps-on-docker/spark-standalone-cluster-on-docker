ARG java_image_tag=21.0.8-jre-headless-ubuntu-24.04
FROM sapmachine:${java_image_tag}
LABEL maintainer="Andre Perez <andre.marcos.perez@gmail.com>"

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

RUN apt-get -y update && \
    apt-get -y install curl python3 r-base && \
    apt-get -y clean

RUN curl -L https://github.com/scala/scala/releases/download/v${scala_version}/scala-${scala_version}.deb -o scala.deb && \
    apt-get -y install ./scala.deb && \
    rm -rf scala.deb && \
    apt-get -y clean

ENV SCALA_HOME="/usr/bin/scala"
ENV PATH=${PATH}:${SCALA_HOME}/bin
ENV SHARED_WORKSPACE=${shared_workspace}

# -- Runtime

VOLUME ${shared_workspace}
CMD ["bash"]
