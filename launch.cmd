 #!/bin/bash
 
cd /mnt/c/Users/sidhu/Vscode/pyspark_standalone/spark-standalone-cluster-on-docker/build/
./build.sh
docker-compose -f docker-compose.yml up -d dbeaver