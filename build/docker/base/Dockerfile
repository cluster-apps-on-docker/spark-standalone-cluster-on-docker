ARG IMAGE="ubuntu:16.04"
FROM ${IMAGE}

ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBCONF_NOWARNINGS="yes"
ARG DEBCONF_TERSE="yes"
ARG APT="apt-get -qq -y"
ARG LANG="C.UTF-8"

# Configure APT
RUN set -x \
&& echo "debconf debconf/frontend select ${DEBIAN_FRONTEND}" | debconf-set-selections \
&& echo 'APT::Install-Recommends "false";' | tee /etc/apt/apt.conf.d/99install-recommends \
&& echo 'APT::Get::Assume-Yes "true";' | tee /etc/apt/apt.conf.d/99assume-yes \
&& sed -Ei 's|^(DPkg::Pre-Install-Pkgs .*)|#\1|g' /etc/apt/apt.conf.d/70debconf \
&& debconf-show debconf

# Install Packages
RUN set -x \
&& mv /etc/apt/apt.conf.d/70debconf . \
&& ${APT} update \
&& ${APT} install apt-utils >/dev/null \
&& mv 70debconf /etc/apt/apt.conf.d \
&& ${APT} upgrade >/dev/null \
&& ${APT} install curl >/dev/null

ARG debian_buster_image_tag=8-jre-slim
FROM openjdk:${debian_buster_image_tag}
LABEL manteiner="Andre Perez <andre.marcos.perez@gmail.com>"

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
    mkdir -p /usr/share/man/man1 && \
    ${APT} update >/dev/null
    ${APT} install curl python3 r-base && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    curl https://downloads.lightbend.com/scala/${scala_version}/scala-${scala_version}.deb -k -o scala.deb && \
    ${APT} install ./scala.deb && \
    rm -rf scala.deb /var/lib/apt/lists/*

ENV SCALA_HOME="/usr/bin/scala"
ENV PATH=${PATH}:${SCALA_HOME}/bin
ENV SHARED_WORKSPACE=${shared_workspace}

# -- Runtime

VOLUME ${shared_workspace}
CMD ["bash"]
