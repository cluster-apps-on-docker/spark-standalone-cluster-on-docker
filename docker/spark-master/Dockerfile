ARG spark_version="3.0.0"
FROM spark-base:${spark_version}
LABEL manteiner="Andre Perez <https://github.com/andre-marcos-perez>"

# -- Layer: Image Metadata

ARG build_date
LABEL org.label-schema.build-date=${build_date}
LABEL org.label-schema.name="Apache Spark Standalone Cluster on Docker - Spark Master Image"
LABEL org.label-schema.description="Spark master image"
LABEL org.label-schema.url="https://github.com/andre-marcos-perez/spark-cluster-on-docker"
LABEL org.label-schema.schema-version="1.0"

# -- Layer: Apache Spark Master

ENV SPARK_MASTER_HOST spark-master
ENV SPARK_MASTER_PORT 7077

# -- Runtime

EXPOSE 8080  7077
WORKDIR ${SPARK_HOME}

CMD bin/spark-class org.apache.spark.deploy.master.Master >> logs/spark-master.out
