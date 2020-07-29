#!/bin/bash

url="${1}"

curl -sLH "Authorization: Token ${API_DEV_KEY}" "http://localhost:8080/${url}"
