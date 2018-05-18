#!/bin/bash

cd ${RDMO_APPDIR}

# as one liner
# find  "/vol" -regex ".*catalog\/.*\.xml$" -exec ./manage.py import {} \;

arr=($(find  "/vol" -regex ".*catalog\/.*\.xml$"))

IFS=$'\n'
sorted=($(sort <<<"${arr[*]}"))
unset IFS

for i in "${sorted[@]}"; do
   echo -e "Starting to import ${i}..."
   python manage.py import ${i}
done
