#!/bin/bash

if [[ "${1}" == "p2" ]]; then
    echo -e "\nBuilding python2 version...\n"
    cp -f ./rdmo/dockerfile.p2 ./rdmo/dockerfile
else
    echo "-e \nBuilding python3 version...\n"
    cp -f ./rdmo/dockerfile.p3 ./rdmo/dockerfile
fi

sudo docker-compose down --rmi all --remove-orphans
sudo docker volume rm \
    rdmo-dc_rdmosrc \
    rdmo-dc_volfiles

sudo docker-compose up -d
sudo docker-compose logs -f
