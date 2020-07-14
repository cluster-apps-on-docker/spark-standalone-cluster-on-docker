FROM base
LABEL manteiner="Andre Perez <andre.marcos.perez@gmail.com>"

# -- Layer: Image Metadata

ARG build_date

LABEL org.label-schema.build-date=${build_date}
LABEL org.label-schema.name="Apache Spark Standalone Cluster on Docker - JupyterLab Image"
LABEL org.label-schema.description="JupyterLab image"
LABEL org.label-schema.url="https://github.com/andre-marcos-perez/spark-cluster-on-docker"
LABEL org.label-schema.schema-version="1.0"

# -- Layer: JupyterLab

ARG spark_version
ARG jupyterlab_version

RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev && \
    pip3 install pyspark==${spark_version} jupyterlab==${jupyterlab_version} wget

# -- Runtime

EXPOSE 8888
WORKDIR ${SHARED_WORKSPACE}

ARG data_files="workspace/data/"
ADD ${data_files} ${SHARED_WORKSPACE}/data

ARG notebooks_files="workspace/*.ipynb"
ADD ${notebooks_files} ${SHARED_WORKSPACE}

CMD jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=
