#!/bin/bash


# create pgpass if it does not exist
pgp="${HOME}/.pgpass"
if [[ ! -f ${pgp} ]]; then
    echo ${POSTGRES_HOST}:${POSTGRES_PORT}:${POSTGRES_DB}:${POSTGRES_USER}:${POSTGRES_PASSWORD} > "${pgp}"
    chmod 600 "${pgp}"
fi


psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER}
