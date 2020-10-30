#!/bin/bash
mkdir -p "${RDMO_SOURCE_MP}"
cd "${RDMO_SOURCE_MP}"

function ec() {
    echo -e "\n\033[0;93m${1}\033[0m"
    eval "${1}"
}

if [[ ("${RDMO_SOURCE_MP}" != "${INSTALL_SOURCE}") && -n "${INSTALL_SOURCE}" ]]; then
    echo "Install rdmo from: ${INSTALL_SOURCE}"
    ec "git clone \"${INSTALL_SOURCE}\" ."
    ec "git checkout \"${BRANCH}\""
    ec "git pull"
fi
ec "pip install -e \"${RDMO_SOURCE_MP}\""

# git clone https://github.com/rdmorganiser/rdmo-app ${RDMO_APP_MP}
mkdir -p "${RDMO_SOURCE_MP}/testing/log"

cp -f \
    "${HOME}/tpl/local-py-${DATABASE}.py" \
    "${RDMO_APP_MP}/config/settings/local.py"

cp -f \
    "${HOME}/tpl/local-py-testing.py" \
    "${RDMO_SOURCE_MP}/testing/config/settings/local.py"

cd "${RDMO_APP_MP}"
ec "python manage.py makemigrations"
ec "python manage.py migrate"
ec "python manage.py download_vendor_files"
ec "python manage.py collectstatic --no-input"
ec "python manage.py create_admin_user"
