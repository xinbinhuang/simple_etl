# A simple ETL example

## Installation

### Install Postgres

```bash
sudo apt-get update
sudo apt-get install postgresql
sudo service postgresql restart
```

### Set up database

Before setting up the ETL pipeline, we need to first create some databases, tables and populate some random data.

- `orders`: production database
    - `customer`: customer table
    - `order_info`: table for the order information
    - `orderline`: table for the order line information
    - `product`

```bash
cd init_db

# Create databases and set up users
./create_everything.sh

# create some tables and populate it with some data.
./load_data.sh
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

- [Stackoverflow - OrderLine](https://stackoverflow.com/questions/10367206/what-is-a-order-line)
