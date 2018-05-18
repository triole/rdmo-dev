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
        useradd -m -d ${RDMO_DIR} -s /bin/bash ${RDMO_USER}
        chown -R ${RDMO_USER}:${RDMO_USER} ${RDMO_DIR}
    else
        echo "User exists. Taking no action."
    fi
}

function installRdmo(){
    echo "Installing rdmo..."
    /vol/files/opt/install-rdmo-app.sh
    cp -f /vol/files/tmp/local-template-postgres.py ${RDMO_APPDIR}/config/settings/local.py
}

function keepAlive(){
    while true; do
        while [ $(isUp) == "1" ]; do
            sleep 2
        done
        cd ${RDMO_APPDIR}
        python manage.py runserver 0.0.0.0:80
    done
}

# main
addRdmoUser
installRdmo
keepAlive
