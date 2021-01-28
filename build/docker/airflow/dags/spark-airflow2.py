import codecs
import logging
from datetime import timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.utils import dates

logging.basicConfig(format="%(name)s-%(levelname)s-%(asctime)s-%(message)s", level=logging.INFO)

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

def create_dag(dag_id):
    default_args = {
        "owner": "ABC",
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
        from pyspark.sql import SparkSession
        spark = SparkSession.\
            builder.\
                appName("pyspark-notebook").\
                master("local[1]").\
                getOrCreate()
        import zipfile
        import os

        with zipfile.ZipFile(os.path.join('data', 'iris_data.zip'), 'r') as zip_ref:
            zip_ref.extractall('data')
            
        data = spark.read.csv(os.path.join('data', 'iris.data'))
        logger.info(data.show(n=5))
        return kwargs['message']

    def task_2(**kwargs):
        logger.info('=====Executing Task 2=============')
        task_instance = kwargs['ti']
        result = task_instance.xcom_pull(key=None, task_ids='Task_1')

        from pyspark.sql import Row
        from pyspark.sql import SQLContext
        sc = spark.sparkContext

        sqlContext = SQLContext(spark)
        list_p = [('John',19),('Smith',29),('Adam',35),('Henry',50)]
        rdd = sc.parallelize(list_p)
        ppl = rdd.map(lambda x: Row(name=x[0], age=int(x[1])))
        DF_ppl = sqlContext.createDataFrame(ppl)
        logger.info(DF_ppl.printSchema())

    with new_dag:
        task1 = PythonOperator(task_id='Task_1',
                                                    python_callable=task_1,
                                                    op_kwargs=
                                                    {
                                                        'message': 'hello airflow'
                                                    },
                                                    provide_context=True)

        task2 = PythonOperator(task_id='Task_2',
                                            python_callable=task_2,
                                            op_kwargs=None,
                                            provide_context=True)
        task2.set_upstream(task1)
        return new_dag

dag_id = "spark-airflow-2"
globals()[dag_id] = create_dag(dag_id)
