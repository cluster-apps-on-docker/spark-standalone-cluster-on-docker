# powershell
# tested on Windows 10 (1809) / Docker version 19.03.13, build 4484c46d9d / PowerShell version 5.1.17763.1490
# -- Build Apache Spark Standalone Cluster Docker Images

# ----------------------------------------------------------------------------------------------------------------------
# -- Variables ---------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

$BUILD_DATE = Get-Date -Format "yyyy-MM-dd"

$yml_content = Get-Content build.yml

$SHOULD_BUILD_BASE = [regex]::Match($yml_content, 'build_base: "(.+?)"').Groups[1].value
$SHOULD_BUILD_SPARK = [regex]::Match($yml_content, 'build_spark: "(.+?)"').Groups[1].value
$SHOULD_BUILD_JUPYTERLAB = [regex]::Match($yml_content, 'build_jupyterlab: "(.+?)"').Groups[1].value

$SCALA_VERSION = [regex]::Match($yml_content, 'scala: "(.+?)"').Groups[1].value
$SPARK_VERSION = [regex]::Match($yml_content, 'spark: "(.+?)"').Groups[1].value
$HADOOP_VERSION = [regex]::Match($yml_content, 'hadoop: "(.+?)"').Groups[1].value
$JUPYTERLAB_VERSION = [regex]::Match($yml_content, 'jupyterlab: "(.+?)"').Groups[1].value

# ----------------------------------------------------------------------------------------------------------------------
# -- Functions----------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

function cleanContainers() {
  write-host '-- cleaning containers --'  
  if($SHOULD_BUILD_JUPYTERLAB){
    docker ps -a | Select-String -Pattern 'jupyterlab' | ConvertFrom-String | %{docker stop $_.P1; docker rm $_.P1}
  }

  if($SHOULD_BUILD_SPARK){
    docker ps -a | Select-String -Pattern 'spark-worker' | ConvertFrom-String | %{docker stop $_.P1; docker rm $_.P1}
    docker ps -a | Select-String -Pattern 'spark-master' | ConvertFrom-String | %{docker stop $_.P1; docker rm $_.P1}
    docker ps -a | Select-String -Pattern 'spark-base' | ConvertFrom-String | %{docker stop $_.P1; docker rm $_.P1}
  }

  if($SHOULD_BUILD_BASE){
    docker ps -a | Select-String -Pattern 'base' | ConvertFrom-String | %{docker stop $_.P1; docker rm $_.P1}
  }
}

function cleanImages() {
  write-host '-- cleaning images --'  

  if($SHOULD_BUILD_JUPYTERLAB){
    docker images | Select-String -Pattern 'jupyterlab' | ConvertFrom-String | %{docker rmi -f $_.P3}
  }

  if($SHOULD_BUILD_SPARK){
    docker images | Select-String -Pattern 'spark-worker' | ConvertFrom-String | %{docker rmi -f $_.P3}
    docker images | Select-String -Pattern 'spark-master' | ConvertFrom-String | %{docker rmi -f $_.P3}
    docker images | Select-String -Pattern 'spark-base' | ConvertFrom-String | %{docker rmi -f $_.P3}
  }

  if($SHOULD_BUILD_BASE){
    docker images | Select-String -Pattern 'base' | ConvertFrom-String | %{docker rmi -f $_.P3}
  }

}

function cleanVolume() {
  write-host '-- cleaning volume --'  
  docker volume rm "hadoop-distributed-file-system"
}

function buildImages() {
  write-host '-- building images --'  

  if($SHOULD_BUILD_BASE){
    docker build `
        --build-arg build_date="${BUILD_DATE}" `
        --build-arg scala_version="${SCALA_VERSION}" `
        -f docker/base/Dockerfile `
        -t base:latest .
  }

  if($SHOULD_BUILD_SPARK){
    docker build `
        --build-arg build_date="${BUILD_DATE}" `
        --build-arg spark_version="${SPARK_VERSION}" `
        --build-arg hadoop_version="${HADOOP_VERSION}" `
        -f docker/spark-base/Dockerfile `
        -t spark-base:${SPARK_VERSION}-hadoop-${HADOOP_VERSION} .

    docker build `
        --build-arg build_date="${BUILD_DATE}" `
        --build-arg spark_version="${SPARK_VERSION}" `
        --build-arg hadoop_version="${HADOOP_VERSION}" `
        -f docker/spark-master/Dockerfile `
        -t spark-master:${SPARK_VERSION}-hadoop-${HADOOP_VERSION} .

    docker build `
        --build-arg build_date="${BUILD_DATE}" `
        --build-arg spark_version="${SPARK_VERSION}" `
        --build-arg hadoop_version="${HADOOP_VERSION}" `
        -f docker/spark-worker/Dockerfile `
        -t spark-worker:${SPARK_VERSION}-hadoop-${HADOOP_VERSION} .
  }

  if($SHOULD_BUILD_JUPYTERLAB){
    docker build `
        --build-arg build_date="${BUILD_DATE}" `
        --build-arg scala_version="${SCALA_VERSION}" `
        --build-arg spark_version="${SPARK_VERSION}" `
        --build-arg jupyterlab_version="${JUPYTERLAB_VERSION}" `
        -f docker/jupyterlab/Dockerfile `
        -t jupyterlab:${JUPYTERLAB_VERSION}-spark-${SPARK_VERSION} .
    }

}

# ----------------------------------------------------------------------------------------------------------------------
# -- Main --------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------

cleanContainers
cleanImages
cleanVolume
buildImages

write-host '-- build.ps1 done --'  
