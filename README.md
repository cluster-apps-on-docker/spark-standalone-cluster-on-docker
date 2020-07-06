# Apache Spark Standalone Cluster on Docker
> Build your own Apache Spark Standalone cluster with a JupyterLab interface on Docker :zap:

## Contents

- [Quick Start](#quick-start)
- [Features](#features)
- [Tech Stack Supported Version](#tech-stack-supported-version)
- [Contributing](#contributing)
- [Contributors](#contributors)

## <a name="quick-start"></a>Quick Start

### Build the cluster from DockerHub

1. Install [Docker and Docker Compose](https://docs.docker.com/get-docker/), check the [supported versions;](#tech-stack-supported-version);
2. Compose the cluster:

```bash
docker-compose up
```

3. Enjoy. :)

### Build the cluster from your local machine

> **Note**: Building locally is only supported on Unix OS's.

1. Install [Docker and Docker Compose](https://docs.docker.com/get-docker/), check the [supported versions;](#tech-stack-supported-version);
2. Change to the build folder:

```bash
cd build/
```

3. Build the images:

```bash
chmod +x build.sh ;./build.sh
```

4. Compose the cluster:

```bash
docker-compose up
```

5. Enjoy. :)

## <a name="features"></a>Features

1. **[Apache Spark Standalone Cluster](http://spark.apache.org/docs/latest/spark-standalone.html)** shipped with:
..* Master node;
..* Worker nodes with 1 core and 512m of memory (default).
2. Simulated **Hadoop Distributed File System**;
3. **[JupyterLab](https://jupyterlab.readthedocs.io/en/stable/)** interface;
4. **PySpark** notebook with Apache Spark API examples.

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
3. Do your magic :);
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



