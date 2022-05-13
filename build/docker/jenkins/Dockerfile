FROM jenkins/ssh-agent:jdk11
LABEL mantainer="Gagandeep Singh <singh.gagandeep8@gmail.com>"

# -- Layer: Image Metadata

ARG build_date

LABEL org.label-schema.build-date=${build_date}
LABEL org.label-schema.name="Apache Spark Standalone Cluster on Docker - JupyterLab Image"
LABEL org.label-schema.description="JupyterLab image"
LABEL org.label-schema.url="https://github.com/GagandeepS/spark-standalone-cluster-on-docker"
LABEL org.label-schema.schema-version="1.0"

RUN yum update -y && \
    yum install -y bash && \
    pip3 install --upgrade pip

RUN yum install -y ca-certificates

EXPOSE 22

WORKDIR ${SHARED_WORKSPACE}
