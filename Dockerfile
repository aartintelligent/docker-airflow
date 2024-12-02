ARG AIRFLOW_VERSION=latest

FROM apache/airflow:${AIRFLOW_VERSION}

USER root

COPY --chown=airflow:root dags/* /opt/airflow/dags/*

USER airflow

COPY requirements.txt /requirements.txt

RUN if [ -s "/requirements.txt" ]; then \
        if ! pip install -r "/requirements.txt"; then \
            echo "Failed to install requirements from requirements.txt"; \
            exit 1; \
        fi; \
    fi

WORKDIR /opt/airflow
