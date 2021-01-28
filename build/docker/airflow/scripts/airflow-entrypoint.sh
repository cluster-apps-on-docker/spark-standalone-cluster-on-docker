#!/usr/bin/env bash

# comment out after initial cleaning and init
#airflow db check
#airflow db init
#airflow db reset -y

# we can leave the upgrade in for every start
airflow db upgrade

# add admin user
airflow users create --role Admin   --username admin \
                                    --firstname a \
                                    --lastname b \
                                    --email c \
                                    --password admin


# now that the db is in a good state, start the webserver
airflow webserver
