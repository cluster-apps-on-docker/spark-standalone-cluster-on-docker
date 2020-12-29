ARG spark_version
FROM spark-base:${spark_version}
LABEL manteiner="Andre Perez <andre.marcos.perez@gmail.com>"

# -- Layer: Image Metadata

ARG build_date

LABEL org.label-schema.build-date=${build_date}
LABEL org.label-schema.name="Apache Spark Standalone Cluster on Docker - Spark Master Image"
LABEL org.label-schema.description="Spark master image"
LABEL org.label-schema.url="https://github.com/andre-marcos-perez/spark-cluster-on-docker"
LABEL org.label-schema.schema-version="1.0"

# -- Runtime

EXPOSE 8080 7077

CMD bin/spark-class org.apache.spark.deploy.master.Master >> logs/spark-master.out
