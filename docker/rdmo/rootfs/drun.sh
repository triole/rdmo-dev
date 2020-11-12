#!/bin/bash

function waitforpg() {
    pg_isready -h ${POSTGRES_HOST} -U ${POSTGRES_USER} || (
        sleep 1
        waitforpg
    )
}

waitforpg

if [[ -z "$(pip freeze | grep "rdmo")" ]]; then
    ${HOME}/sh/install-rdmo.sh
fi

if [[ "${TESTMODE}" == "True" ]]; then
    echo "Run tests"
    cd "${RDMO_SOURCE_MP}" && pytest
else
    while true; do
        cd "${RDMO_APP_MP}"
        python manage.py runserver 0.0.0.0:8080
        sleep 1
    done
fi
