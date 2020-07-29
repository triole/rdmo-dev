#!/bin/bash

if ([[ -n "${1}" ]] && [[ ! "${1}" =~ noshared ]]); then
    user="--user ${1}"
else
    user=""
fi

fol="rdmo-catalog"
cd "${HOME}"
if [[ ! -d "${fol}" ]]; then
    git clone "https://github.com/rdmorganiser/rdmo-catalog" "${fol}"
fi

cd ${RDMO_APP_MP}

arr=()
if [[ "${1}" =~ noshared ]]; then
    arr=($(
        find "${HOME}" -regex ".*catalog\/.*\.xml$" | sort -f | grep -v "/shared/"
    ))
    arr+=($(find "${HOME}" -regex ".*catalog\/.*conditions.*\.xml$" | sort -f))
else
    arr=($(
        find "${HOME}" -regex ".*catalog\/.*\.xml$" | sort -f
    ))
    arr+=($(find "${HOME}" -regex ".*catalog\/.*conditions.*\.xml$" | sort -f | grep -v "/shared/"))
fi

for i in "${arr[@]}"; do
    echo -e "Starting to import ${i}..."
    python manage.py import "${i}" ${user}
done
