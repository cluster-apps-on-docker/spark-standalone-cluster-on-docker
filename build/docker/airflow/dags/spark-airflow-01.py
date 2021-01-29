"""spark-airflow-01.py shows how to instantiate pyspark and process data."""
import logging
from datetime import timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.utils import dates
from pyspark.sql import SparkSession
import requests
import tempfile
import os

logging.basicConfig(format="%(name)s-%(levelname)s-%(asctime)s-%(message)s",
                    level=logging.INFO)

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)


def create_dag(dag_id):
    default_args = {
        "owner": "demo",
        "description": (
            "DAG to explain airflow + pyspark concepts"
        ),
        "depends_on_past": False,
        "start_date": dates.days_ago(1),
        "retries": 1,
        "retry_delay": timedelta(minutes=1),
        "provide_context": True,
        "catchup": False,
    }

    new_dag = DAG(
        dag_id,
        default_args=default_args,
        schedule_interval=None,
    )

    def task_1(**kwargs):
        logger.info('=====Executing Task 1=============')
        install_missing_dependencies()

        logger.info(f'Importing pyspark.sql.SparkSession')
        spark = SparkSession. \
            builder. \
            appName("spark-airflow-01"). \
            master("local[1]"). \
            getOrCreate()
        logger.info(f'created spark session = {spark!r}')

        logger.info("downloading iris.data")
        url = "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"
        logger.info(f'downloading resource from url = {url!r}')
        r = requests.get(url)
        logger.info("downloaded iris.data")

        with tempfile.TemporaryDirectory() as tmpdirname:
            logger.info(f"created temp directory {tmpdirname}")
            with open(os.path.join(tmpdirname, "iris.data"), "wb") as fd:
                fd.write(r.content)
                logger.info("wrote iris.data")
                data = spark.read.csv(os.path.join(tmpdirname, "iris.data"))
                logger.info("loaded iris.data into spark")
                logger.info(data.show(n=5))

    def install_missing_dependencies():
        # TODO: BUGBUG: installing deps like this is a Very Bad Practice (TM)
        # TODO: BUGBUG: do something much smarter after switching to KubernetesExecutor
        logger.info('Importing nec. python libs...')
        import sys
        import subprocess
        import pkg_resources
        required = {'numpy', 'pandas', 'wget'}
        installed = {pkg.key for pkg in pkg_resources.working_set}
        missing = required - installed
        if missing:
            # implement pip as a subprocess:
            logger.info(f'Importing missing libs: {missing!r}')
            subprocess.check_call([sys.executable, '-m', 'pip', 'install', *missing])

    with new_dag:
        task1 = PythonOperator(task_id='Task_1',
                               python_callable=task_1,
                               op_kwargs=
                               {
                                   'message': 'hello airflow'
                               },
                               provide_context=True)

        return new_dag


dag_id = "spark-airflow-01"
globals()[dag_id] = create_dag(dag_id)
