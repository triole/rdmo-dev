#!/bin/bash

if [[ -z "${1}" ]]; then
    db="postgres"
else
    db="${1}"
fi

# c=$(pip freeze | grep -Po "^rdmo==.*")
# changed to a simpler scheme because "pip -e" install
# does display the git url and a lot more than just the package name

pip install -e ${RDMO_SRC}
git clone https://github.com/rdmorganiser/rdmo-app ${RDMO_APP}
cp /tmp/local-template-${db}.py ${RDMO_APP}/config/settings/local.py
cd ${RDMO_APP}
python manage.py migrate
python manage.py create_admin_user
python manage.py download_vendor_files
pip install -r ${RDMO_APP}/requirements/gunicorn.txt
python manage.py collectstatic --no-input

chown -R rdmo:rdmo ${RDMO_SRC}
chown rdmo:rdmo /var/log/rdmo*
