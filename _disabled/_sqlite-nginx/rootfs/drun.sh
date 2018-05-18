#!/bin/bash

/opt/install-rdmo-app.sh

while true; do
   gunicorn --bind unix:${RDMODIR}/rdmo.sock config.wsgi:application -D
   nginx -g "daemon off;"
   sleep 10
done
