#!/bin/bash
mkdir -p "${RDMO_SOURCE_MP}"

cd "${RDMO_SOURCE_MP}"
if [[ "${RDMO_SOURCE_MP}" != "${INSTALL_SOURCE}" ]]; then
    echo "Install rdmo from: ${INSTALL_SOURCE}"
    git clone "${INSTALL_SOURCE}" .
    git checkout "${BRANCH}"
    git pull
fi
pip install -e "${RDMO_SOURCE_MP}"

# git clone https://github.com/rdmorganiser/rdmo-app ${RDMO_APP_MP}
mkdir -p "${RDMO_SOURCE_MP}/config/settings"
mkdir -p "${RDMO_SOURCE_MP}/testing/config/settings"
mkdir -p "${RDMO_SOURCE_MP}/testing/log"

cp -f \
    "${HOME}/tpl/local-py-${DATABASE}.py" \
    "${RDMO_SOURCE_MP}/config/settings/local.py"

cp -f \
    "${HOME}/tpl/local-py-testing.py" \
    "${RDMO_SOURCE_MP}/testing/config/settings/local.py"

cd "${RDMO_APP_MP}"
python manage.py makemigrations
python manage.py migrate
python manage.py download_vendor_files
python manage.py collectstatic --no-input
python manage.py create_admin_user
