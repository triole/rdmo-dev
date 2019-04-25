#!/bin/bash

url="${1}"

curl -LH "Authorization: ${API_DEV_KEY}" "http://localhost:80/${url}"
