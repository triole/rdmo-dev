#!/bin/bash

# functions
function isUp(){
    echo $(ps aux | grep -Po ".*\/bin\/python\smanage\.py\srunserver" | wc -l)
}

function addRdmoUser(){
    echo "Checking if rdmo user exists..."
    i=$(cut -d: -f1 /etc/passwd | grep -c ${RDMO_USER})
    if [[ "${i}" == "0" ]]; then
        echo "Adding rdmo user having username: ${RDMO_USER}"
        useradd -m -d ${RDMO_SRC} -s /bin/bash ${RDMO_USER}
        chown -R ${RDMO_USER}:${RDMO_USER} ${RDMO_SRC}
    else
        echo "User exists. Taking no action."
    fi
}

function installRdmo(){
    echo "Installing rdmo..."
    /opt/install-rdmo-app.sh
    cp -f /tmp/local-template-postgres.py ${RDMO_APP}/config/settings/local.py
    cp -f /tmp/local-testing-template.py ${RDMO_APP}/testing/config/settings/local.py
    cd ${RDMO_APP}
    python manage.py migrate
    python manage.py create_admin_user
    # make dir for test logs
    mkdir -p ${RDMO_SRC}/testing/log
}

function keepAlive(){
    while true; do
        while [[ $(isUp) == "1" ]]; do
            sleep 4
        done
        sleep 2
        if [[ $(isUp) == "0" ]]; then
            runServer
        fi
    done
}

function runServer(){
    if [[ "${GUNICORN}" == "True" ]]; then
        gunicorn --bind 0.0.0.0:80 \
            config.wsgi:application \
            --log-level info \
            --access-logfile '/var/log/gunicorn_access.log' \
            --error-logfile '/var/log/gunicorn_err.log'
    else
        python manage.py runserver 0.0.0.0:80
    fi
}


# main
if [[ -z "$(pip freeze | grep "rdmo")" ]]; then
    addRdmoUser
    installRdmo
fi

cd ${RDMO_APP}
if [[ "${DEVMODE}" == "True" ]]; then
    keepAlive
else
    runServer
fi
