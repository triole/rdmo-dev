#!/bin/bash

function isUp(){
  echo $(ps aux | grep -Po ".*\/bin\/python\smanage\.py\srunserver" | wc -l)
}

/opt/install-rdmo-app.sh

while true; do
   while [ $(isUp) == "1" ]; do
     sleep 2
   done
   cd ${RDMOAPPDIR}
   python manage.py runserver 0.0.0.0:80
done
