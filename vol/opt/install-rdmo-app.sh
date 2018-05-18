#!/bin/bash

if [[ -z "${1}" ]]; then
    db="postgres"
else
    db="${1}"
fi

# c=$(pip freeze | grep -Po "^rdmo==.*")
# changed to a simpler scheme because "pip -e" install
# does display the git url and a lot more than just the package name
c=$(pip freeze | grep "rdmo")

if [[ -z "${c}" ]]; then
    pip install -e ${VOL_RDMO}
    git clone https://github.com/rdmorganiser/rdmo-app ${RDMO_APPDIR}
    cp ${VOL_FILES}/tmp/local-template-${db}.py ${RDMO_APPDIR}/config/settings/local.py
    cd ${RDMO_APPDIR}
    python manage.py migrate
    python manage.py create_admin_user
    python manage.py download_vendor_files
    pip install -r ${RDMO_APPDIR}/requirements/gunicorn.txt
    python manage.py collectstatic --no-input
fi

chown -R rdmo:rdmo /srv/rdmo
chown rdmo:rdmo /var/log/rdmo*
