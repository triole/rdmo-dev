#!/bin/bash

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/"
cd ${RDMO_APP}

find ${scriptdir} -mindepth 1 -maxdepth 1 -regex ".*\.xml$" \
	-exec python manage.py import {} \;
