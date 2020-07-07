# Apache Spark Standalone Cluster on Docker
> Build your own Apache Spark Standalone cluster with a JupyterLab interface on Docker :zap:

This project gives you an out-of-the-box **Apache Spark** Standalone cluster (one master + two workers)  
with a **JupyterLab** interface built on top of **Docker**. The cluster is shipped with a [jupyter  
notebook](build/workspace/) with examples on how to read, process and write data using **PySpark**,  
Apache Spark's Python API, from a simulated **Apache Hadoop Distributed File System**.

![architecture](docs/image/spark-cluster-on-docker.png)

## Contents

- [Features](#features)
- [Quick Start](#quick-start)
- [Tech Stack Supported Version](#tech-stack-supported-version)
- [Contributing](#contributing)
- [Contributors](#contributors)

## <a name="features"></a>Features

1. **Apache Spark Standalone Cluster** shipped with:
   * One master node;
   * Two worker nodes with 1 core and 512m of memory (default).
2. Simulated **Hadoop Distributed File System**;
3. **JupyterLab** interface;
4. **PySpark** notebook with Apache Spark API examples.

## <a name="quick-start"></a>Quick Start

### Build the cluster from DockerHub

1. Install [Docker and Docker Compose](https://docs.docker.com/get-docker/), check the [supported versions](#tech-stack-supported-version);
2. Get the source code;
3. Compose the cluster:

```bash
docker-compose up
```

### Build the cluster from your local machine

> **Note**: Building locally is only supported on Unix OS's.

1. Install [Docker and Docker Compose](https://docs.docker.com/get-docker/), check the [supported versions](#tech-stack-supported-version);
2. Get the source code;
3. Build the images:

```bash
cd build ; chmod +x build.sh ; ./build.sh
```

4. Compose the cluster:

```bash
docker-compose up
```

## <a name="tech-stack"></a>Tech Stack Supported Version

| Tech          | Supported Version |
| ------------- | ----------------- |
| Docker        | 19.03.x           |
| Python        | 3.7               |
| Scala         | 2.12.x            |
| Apache Spark  | 3.0.0             |
| Apache Hadoop | 2.7               |
| JupyterLab    | 2.1.4             |

## <a name="contribuing"></a>Contributing

We'd love some help. To contribute, follow the steps bellow:

1. Fork the project;
2. Create your feature branch, we use [gitflow](https://github.com/nvie/gitflow);
3. Do your magic :smile:;
4. Commit your changes;
5. Push to your feature branch;
6. Create a [new pull request](https://github.com/andre-marcos-perez/spark-cluster-on-docker/pulls).

Some ideas:

- Microsoft Windows build script;
- JupyterLab Scala kernel;
- Scala Jupyter notebook with Apache Spark Scala API examples;
- JupyterLab R kernel;
- R Jupyter notebook with Apache Spark R API examples
- Tests, tests and more tests.

## <a name="contributors"></a>Contributors

 - **André Perez** - [dekoperez](https://twitter.com/dekoperez) - andre.marcos.perez@gmail.com



