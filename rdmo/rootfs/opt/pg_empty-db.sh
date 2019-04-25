#!/bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"


# create pgpass if it does not exist
pgp="${HOME}/.pgpass"
if [[ ! -f ${pgp} ]]; then
    echo ${POSTGRES_HOST}:${POSTGRES_PORT}:${POSTGRES_DB}:${POSTGRES_USER}:${POSTGRES_PASSWORD} > "${pgp}"
    chmod 600 "${pgp}"
fi


# detect scripts
sql_scripts=($(find ${scriptdir}sql -regex ".*\.sql$"))


# --- action, repeat a few times because of foreign key dependecies
for i in $(seq 1 1 5); do
    for sql in "${sql_scripts[@]}"; do
        psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -a -f ${sql}
    done
done
