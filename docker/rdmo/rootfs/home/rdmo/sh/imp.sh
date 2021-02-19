#!/bin/bash

cd "${RDMO_APP_MP}"
python manage.py import $@
