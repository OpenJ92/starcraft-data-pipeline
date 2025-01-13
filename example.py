from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime

# Import your managers
from starcraft_gather_manager import GatherManager
from starcraft_injection_manager import InjectionManager

def gather_data():
    gather_manager = GatherManager()
    gather_manager.gather()  # Replace with your actual gathering logic

def inject_data():
    injection_manager = InjectionManager()
    injection_manager.inject()  # Replace with your actual injection logic

# Define the DAG
default_args = {
    'owner': 'starcraft',
    'depends_on_past': False,
    'retries': 3,
}

with DAG(
    'starcraft_data_pipeline',
    default_args=default_args,
    description='StarCraft Data Pipeline: Gather -> Inject',
    schedule_interval='@daily',  # Adjust schedule as needed
    start_date=datetime(2025, 1, 1),
    catchup=False,
) as dag:

    gather_task = PythonOperator(
        task_id='gather_data',
        python_callable=gather_data
    )

    inject_task = PythonOperator(
        task_id='inject_data',
        python_callable=inject_data
    )

    # Define task dependencies
    gather_task >> inject_task

