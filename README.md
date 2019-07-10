# A simple ETL example

## Installation

### Install AirFlow & Postgres

```bash
# install postgres and dev tools
sudo apt-get update
sudo apt-get install postgresql python3-dev build-essential
# start postgresql in the backend
sudo service postgresql restart

export AIRFLOW_HOME=~/airflow
```

```bash
# install from pypi using pip
pip install apache-airflow[postgres]

# initialize the database
airflow initdb

# start the web server, default port is 8080
airflow webserver -p 8080

# start the scheduler
airflow scheduler

# visit localhost:8080 in the browser and enable the example dag in the home page
```

### Set up database

Before setting up the ETL pipeline, we need to first create some databases, tables and populate some random data.

```bash
cd init_db

# Create databases and set up users
./create_everything.sh

# create some tables and populate it with some data.
./load_data.sh
```

### Copy dags into airflow

```bash
export AIRFLOW_HOME=~/airflow
mkdir $AIRFLOW_HOME/dags
cp -R ./etl-example/dags/* $AIRFLOW_HOME/dags
mkdir $AIRFLOW_HOME/sql
cp ./etl-example/sql/*.sql $AIRFLOW_HOME/sql
```

### Config Airflow

1. Go to the connections screen in the UI (through Admin) 
2. create a new postgres connection *postgres_oltp*. 
    - Then specify conntype=Postgres, Schema=orders, login=oltp_read (same password) and port 5432 or whatever you’re using.
3. add another connection for Postgres - *postgres_dwh*
    - conntype=Postgres, Schema=dwh, login=dwh_svc_account (same password) and port 5432.
4. Add a pool to airflow (also under Admin) - *postgres_dwh*. Let’s give this a value of 10.
5. add a Variable - *sql_path*: set the value to the sql directory

## Run Airflow from Docker

```bash
# first time to launch for debugging
docker-compose -f docker-compose-LocalExecutor.yml up --abort-on-container-exit

# take down the container
docker-compose -f docker-compose-LocalExecutor.yml down

# run in background
docker-compose -f docker-compose-LocalExecutor.yml up -d
```

## Useful `psql` Command

- \? list all the commands
- \l list databases
- \conninfo display information about current connection
- \c [DBNAME] connect to new database, e.g., \c template1
- \dn show a list of schemas 
- \dt list tables of the public schema
- \dt <schema-name>.* list tables of certain schema, e.g., \dt public.*
- \dt *.* list tables of all schemas
- \q quit psql

## Reference

- [Apache Airflow](http://airflow.apache.org/start.html)
- [Stackoverflow - OrderLine](https://stackoverflow.com/questions/10367206/what-is-a-order-line)
- [ETL example](https://gtoonstra.github.io/etl-with-airflow/etlexample.html#install-airflow-on-host-system)