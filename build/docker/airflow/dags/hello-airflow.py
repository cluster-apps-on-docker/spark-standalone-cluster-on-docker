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
        "owner": "jyoti",
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
        return kwargs['message']

    def task_2(**kwargs):
        logger.info('=====Executing Task 2=============')
        task_instance = kwargs['ti']
        result = task_instance.xcom_pull(key=None, task_ids='Task_1')
        logger.info('Extracted the value from task 1')
        logger.info(result)

    with new_dag:
        task1 = PythonOperator(task_id='Task_1',
                                                    python_callable=task_1,
                                                    op_kwargs=
                                                    {
                                                        'message': 'hellow airflow'
                                                    },
                                                    provide_context=True)

        task2 = PythonOperator(task_id='Task_2',
                                            python_callable=task_2,
                                            op_kwargs=None,
                                            provide_context=True)
        task2.set_upstream(task1)
        return new_dag

dag_id = "hello_airflow1"
globals()[dag_id] = create_dag(dag_id)
