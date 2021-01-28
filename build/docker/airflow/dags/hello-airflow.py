"""hello-airflow.py shows the basics of airflows.

Things to note:

1. The dag is created as a global
2. kwargs['dag_run'].conf contains the values passed at runtime, if any
3. tasks can retrieve values from previous tasks via XCOM
"""
import codecs
import logging
from datetime import timedelta
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.utils import dates

logging.basicConfig(format="%(name)s-%(levelname)s-%(asctime)s-%(message)s",
                    level=logging.INFO)

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)


def create_dag(dag_id):
    default_args = {
        "owner": "someone",
        "description": (
            "DAG to explain airflow concepts"
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
        schedule_interval=timedelta(minutes=5),
    )

    def task_1(**kwargs):
        logger.info('=====Executing Task 1=============')
        logger.info(f"kwargs = {kwargs!r}")
        task_instance = kwargs['ti']
        logger.info(f"task instance = {task_instance}")
        dag_run = kwargs["dag_run"]
        logger.info(f"dag_run = {dag_run!r}")
        logger.info(f"dag_run.conf = {dag_run.conf!r}")
        logger.info("pass kwargs['message'] to next task via XCOM")
        logger.info(f"message = {kwargs['message']!r}")
        return kwargs['message']

    def task_2(**kwargs):
        logger.info('=====Executing Task 2=============')
        logger.info(f"kwargs = {kwargs!r}")
        task_instance = kwargs['ti']
        logger.info(f"task instance = {task_instance}")
        dag_run = kwargs["dag_run"]
        logger.info(f"dag_run = {dag_run!r}")
        logger.info(f"dag_run.conf = {dag_run.conf!r}")
        result = task_instance.xcom_pull(key=None, task_ids='Task_1')
        logger.info(f'Extracted the value from task 1 via XCOM: {result}')

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


dag_id = "hello_airflow"
globals()[dag_id] = create_dag(dag_id)
