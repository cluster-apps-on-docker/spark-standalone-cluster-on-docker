FROM andreper/jupyterlab:3.0.0-spark-3.0.0

RUN apt-get update && apt-get install -y bash

# Install pip requirements
COPY ../requirements.txt .
RUN python -m pip install -r requirements.txt