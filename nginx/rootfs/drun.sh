#!/bin/bash

confdir="/etc/nginx/servers"

rm -f "${confdir}/*.conf"
if [[ "${GUNICORN}" == "True" ]]; then
    cp "${confdir}/gunicorn.tpl" "${confdir}/gunicorn.conf"
else
    cp "${confdir}/django.tpl" "${confdir}/django.conf"
fi

nginx -c /etc/nginx/nginx.conf
