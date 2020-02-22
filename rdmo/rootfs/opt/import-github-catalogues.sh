#!/bin/bash

if ( [[ -n "${1}" ]] && [[ ! "${1}" =~ noshared ]] ); then
    user="--user ${1}"
else
    user=""
fi

cd "${SRC}"
git clone "https://github.com/rdmorganiser/rdmo-catalog" "rdmo-catalog"

cd ${RDMO_APP}

# as one liner
# find  "/vol" -regex ".*catalog\/.*\.xml$" -exec ./manage.py import {} \;

arr=()
if [[ "${1}" =~ noshared ]]; then
    arr=($(
        find  "${SRC}" -regex ".*catalog\/.*\.xml$" | sort | grep -v "/shared/"
    ))
else
    arr=($(
        find  "${SRC}" -regex ".*catalog\/.*\.xml$" | sort
    ))
fi

for i in "${arr[@]}"; do
    echo -e "Starting to import ${i}..."
    python manage.py import "${i}" ${user}
done
