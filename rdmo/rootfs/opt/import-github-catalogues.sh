#!/bin/bash

if [[ -n "${1}" ]]; then
    user="--user ${1}"
else
    user=""
fi

cd "${SRC}"
git clone "https://github.com/rdmorganiser/rdmo-catalog" "rdmo-catalog"

cd ${RDMO_APP}

# as one liner
# find  "/vol" -regex ".*catalog\/.*\.xml$" -exec ./manage.py import {} \;

arr=($(find  "${SRC}" -regex ".*catalog\/.*\.xml$"))

IFS=$'\n'
sorted=($(sort <<<"${arr[*]}"))
unset IFS

for i in "${sorted[@]}"; do
   echo -e "Starting to import ${i}..."
   python manage.py import "${i}" ${user}
done
