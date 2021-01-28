ARG airflow_image_version=apache/airflow:latest
from ${airflow_image_version}
LABEL maintainer="Todd Greenwood-Geer <toddg@envirosoftwaresolutions.com>"

# -- Layer: Image Metadata

ARG build_date

LABEL org.label-schema.build-date=${build_date}
LABEL org.label-schema.name="Apache Spark Standalone Cluster on Docker - Airflow + PySpark Image"
LABEL org.label-schema.description="PySpark + Java and local folders [airflow-logs, dags, scripts]"
LABEL org.label-schema.url="https://github.com/andre-marcos-perez/spark-cluster-on-docker"
LABEL org.label-schema.schema-version="1.0"

# -- Layer: PySpark + Java

# cannot inherit ARG from parent image; this is the default airflow uid
ARG airflow_uid="50000"
ARG spark_version="3.0.0"

# install default jdk as root
USER root
RUN apt-get update -y && apt-get install -y default-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin

# drop back to airflow user
USER ${airflow_uid}

# install pyspark and airflow as the airflow user
RUN pip install "pyspark==${spark_version}"

# -- Layer: Scientific programming dependencies

ARG requests_version="2.25.1"
ARG numpy_version="1.19.5"
ARG pandas_version="1.1.5"
ARG matplotlib_version="3.3.4"
ARG scipy_version="1.5.4"

# install other deps here as needed
RUN pip install "requests==${requests_version}" \
                "numpy==${numpy_version}" \
                "pandas==${pandas_version}" \
                "matplotlib==${matplotlib_version}"\
                "scipy==${scipy_version}"\
