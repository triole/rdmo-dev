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
    /vol/shed/supervisord -c ${HOME}/conf/supervisor.conf
fi
