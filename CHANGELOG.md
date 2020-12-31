# Changelog

All notable changes to this project will be documented in this file.

## [1.2.3](https://github.com/andre-marcos-perez/spark-standalone-cluster-on-docker/releases/tag/v1.2.3) (2020-12-31)

### Core

 - Added wget Python package on JupyterLab image since it is been used on Medium article ([#65](https://github.com/cluster-apps-on-docker/spark-standalone-cluster-on-docker/issues/65)).

### Repository

 - Enhanced Github actions with build matrix.

## [1.2.2](https://github.com/andre-marcos-perez/spark-standalone-cluster-on-docker/releases/tag/v1.2.2) (2020-12-30)

### Repository

 - Enhanced ci/cd script with Github actions.

## [1.2.1](https://github.com/andre-marcos-perez/spark-standalone-cluster-on-docker/releases/tag/v1.2.1) (2020-12-29)

### Support

 - Added Patreon support link. :sparkling_heart:

### Repository

 - Added staging branch between develop and master to test CI/CD pipeline without pushing images to Docker Hub.

### Core

 - Exposed Spark driver web ui 4040 port ([#39](https://github.com/cluster-apps-on-docker/spark-standalone-cluster-on-docker/issues/39));
 - Upgraded JupyterLab from v2.1.4 to v3.0.0;
 - Made SparkR available for all Spark versions;
 - Enhanced Spark compatibility with Scala kernel ([#35](https://github.com/cluster-apps-on-docker/spark-standalone-cluster-on-docker/issues/35)).
 
## [1.2.0](https://github.com/andre-marcos-perez/spark-standalone-cluster-on-docker/releases/tag/v1.2.0) (2020-08-19)

### Features

 - R kernel for JupyterLab;
 - Jupyter notebook with Spark R API (SparkR) example.

## [1.1.0](https://github.com/andre-marcos-perez/spark-standalone-cluster-on-docker/releases/tag/v1.1.0) (2020-08-09)

### Features

 - Scala kernel for JupyterLab;
 - Jupyter notebook with Spark Scala API example.

### Repository

 - Docs general improvements;
 - Pull request template refactored.

## [1.0.0](https://github.com/andre-marcos-perez/spark-standalone-cluster-on-docker/releases/tag/v1.0.0) (2020-07-30)

### Tech Stack

 - **Infra**
   - Python 3.7
   - Scala 2.12
   - Docker Engine 1.13.0+
   - Docker Compose 1.10.0+

 - **Apps**
   - JupyterLab 2.1.4
   - Apache Spark 2.4.0, 2.4.4 and 3.0.0

### Features

 - Docker compose file to build the cluster from your own machine;
 - Docker compose file to build the cluster from Docker Hub;
 - GitHub Workflow CI with Docker Hub to build the cluster daily.

### Repository

- Contributing rules;
- GitHub templates for Bug Issue, Feature Request and Pull Request.

### Community

 - Article on [Medium](https://towardsdatascience.com/apache-spark-cluster-on-docker-ft-a-juyterlab-interface-418383c95445).