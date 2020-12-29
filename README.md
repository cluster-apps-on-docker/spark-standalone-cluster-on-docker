# Apache Spark Standalone Cluster on Docker

> The project was featured on an [article](https://www.mongodb.com/blog/post/getting-started-with-mongodb-pyspark-and-jupyter-notebook) at **MongoDB** official tech blog! :scream:

> The project just got its own [article](https://towardsdatascience.com/apache-spark-cluster-on-docker-ft-a-juyterlab-interface-418383c95445) at **Towards Data Science** Medium blog! :sparkles:

## Introduction

This project gives you an **Apache Spark** cluster in standalone mode with a **JupyterLab** interface built on top of **Docker**.
Learn Apache Spark through its **Scala**, **Python** (PySpark) and **R** (SparkR) API by running the Jupyter [notebooks](build/workspace/) with examples on how to read, process and write data.

<p align="center"><img src="docs/image/cluster-architecture.png"></p>

![build](https://github.com/andre-marcos-perez/spark-standalone-cluster-on-docker/workflows/build/badge.svg?branch=master)
![jupyterlab-latest-version](https://img.shields.io/docker/v/andreper/jupyterlab/3.0.0-spark-3.0.0?color=yellow&label=jupyterlab-latest)
![spark-latest-version](https://img.shields.io/docker/v/andreper/spark-master/3.0.0?color=yellow&label=spark-latest)
![docker-version](https://img.shields.io/badge/docker-v1.13.0%2B-blue)
![docker-compose-file-version](https://img.shields.io/badge/docker--compose-v1.10.0%2B-blue)
![spark-scala-api](https://img.shields.io/badge/spark%20api-scala-red)
![spark-pyspark-api](https://img.shields.io/badge/spark%20api-pyspark-red)
![spark-sparkr-api](https://img.shields.io/badge/spark%20api-sparkr-red)

## TL;DR

```bash
curl -LO https://raw.githubusercontent.com/andre-marcos-perez/spark-standalone-cluster-on-docker/master/docker-compose.yml
docker-compose up
```

## Contents

- [Quick Start](#quick-start)
- [Tech Stack](#tech-stack)
- [Metrics](#metrics)
- [Contributing](#contributing)
- [Contributors](#contributors)

## <a name="quick-start"></a>Quick Start

### Cluster overview

| Application            | URL                                      | Description                                                |
| ---------------------- | ---------------------------------------- | ---------------------------------------------------------- |
| JupyterLab             | [localhost:8888](http://localhost:8888/) | Cluster interface with built-in Jupyter notebooks          |
| Apache Spark Driver    | [localhost:4040](http://localhost:4040/) | Spark Driver web ui                                        |
| Apache Spark Master    | [localhost:8080](http://localhost:8080/) | Spark Master node                                          |
| Apache Spark Worker I  | [localhost:8081](http://localhost:8081/) | Spark Worker node with 1 core and 512m of memory (default) |
| Apache Spark Worker II | [localhost:8082](http://localhost:8082/) | Spark Worker node with 1 core and 512m of memory (default) |

### Prerequisites

 - Install [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/), check **infra** [supported versions](#tech-stack)

### Download from Docker Hub (easier)

1. Download the source code or clone the repository;
2. Edit the [docker compose](docker-compose.yml) file with your favorite tech stack version, check **apps** [supported versions](#tech-stack);
3. Build the cluster;

```bash
docker-compose up
```

4. Run Apache Spark code using the provided Jupyter [notebooks](build/workspace/) with Scala, PySpark and SparkR examples;
5. Stop the cluster by typing `ctrl+c`.

### Build from your local machine

> **Note**: Local build is currently only supported on Linux OS distributions.

1. Download the source code or clone the repository;
2. Move to the build directory;

```bash
cd build
```

3. Edit the [build.yml](build/build.yml) file with your favorite tech stack version;
4. Match those version on the [docker compose](build/docker-compose.yml) file;
5. Build the images;

```bash
chmod +x build.sh ; ./build.sh
```

6. Build the cluster;

```bash
docker-compose up
```

7. Run Apache Spark code using the provided Jupyter [notebooks](build/workspace/) with Scala, PySpark and SparkR examples;
8. Stop the cluster by typing `ctrl+c`.

## <a name="tech-stack"></a>Tech Stack

- Infra

| Component      | Version |
| -------------- | ------- |
| Docker Engine  | 1.13.0+ |
| Docker Compose | 1.10.0+ |

- Languages and Kernels

| Spark | Hadoop | Scala   | [Scala Kernel](https://almond.sh/) | Python | [Python Kernel](https://ipython.org/) | R     | [R Kernel](https://irkernel.github.io/) |
| ----- | ------ | ------- | ---------------------------------- | ------ | ------------------------------------- | ----- | --------------------------------------- |
| 3.x   | 3.2    | 2.12.10 | 0.10.9                             | 3.7.3  | 7.19.0                                 | 3.5.2 | 1.1.1                                   |
| 2.x   | 2.7    | 2.11.12 | 0.6.0                              | 3.7.3  | 7.19.0                                 | 3.5.2 | 1.1.1                                   |

- Available Images

| Component      | Version                 | Docker Tag                                           |
| -------------- | ----------------------- | ---------------------------------------------------- |
| Apache Spark   | 2.4.0 \| 2.4.4 \| 3.0.0 | **\<spark-version>**                                 |
| JupyterLab     | 3.0.0                   | **\<jupyterlab-version>**-spark-**\<spark-version>** |

## <a name="metrics"></a>Metrics

| Image                                                          | Size                                                                                           | Downloads                                                                 |
| -------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| [JupyterLab](https://hub.docker.com/r/andreper/jupyterlab)     | ![docker-size-jupyterlab](https://img.shields.io/docker/image-size/andreper/jupyterlab/latest) | ![docker-pull](https://img.shields.io/docker/pulls/andreper/jupyterlab)   |
| [Spark Master](https://hub.docker.com/r/andreper/spark-master) | ![docker-size-master](https://img.shields.io/docker/image-size/andreper/spark-master/latest)   | ![docker-pull](https://img.shields.io/docker/pulls/andreper/spark-master) |
| [Spark Worker](https://hub.docker.com/r/andreper/spark-worker) | ![docker-size-worker](https://img.shields.io/docker/image-size/andreper/spark-worker/latest)   | ![docker-pull](https://img.shields.io/docker/pulls/andreper/spark-worker) |

## <a name="contributing"></a>Contributing

We'd love some help. To contribute, please read [this file](CONTRIBUTING.md).

> Staring us on GitHub is also an awesome way to show your support :star:

## <a name="contributors"></a>Contributors

The project is maintained by:

 - **André Perez** - [dekoperez](https://twitter.com/dekoperez) - andre.marcos.perez@gmail.com
 
A list of amazing people that somehow contributed to the project can be found in [this file](CONTRIBUTORS.md).
