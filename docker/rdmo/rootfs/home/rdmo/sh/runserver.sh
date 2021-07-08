#!/bin/bash

cd "${RDMO_APP_MP}"
python manage.py runserver 0.0.0.0:8000
