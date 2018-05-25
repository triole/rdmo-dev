#!/bin/bash

cd ${RDMO_APP}
ps aux | grep "python manage.py" | awk -F" " '{print $2}' | xargs kill
python manage.py runserver 0.0.0.0:80
