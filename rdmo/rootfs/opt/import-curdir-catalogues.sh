#!/bin/bash

curdir="$(pwd)"
cd ${RDMO_APP}

arr=($(find "${curdir}" -regex ".*\.xml$" | sort))

IFS=$'\n'
sorted=($(sort <<<"${arr[*]}"))
unset IFS

for i in "${sorted[@]}"; do
   echo -e "Starting to import ${i}..."
   python manage.py import ${i}
done
